{
  lib,
  stdenv,
  writers,
  are-we-dark-yet,
}:
let
  openCommand = if stdenv.isDarwin then "open" else "xdg-open";
in
writers.writePython3Bin "serve-remote-open"
  {
    makeWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${lib.getBin are-we-dark-yet}/bin"
    ];
    flakeIgnore = [
      "E501"
    ];
  }
  ''
    import argparse
    import subprocess
    from http.server import BaseHTTPRequestHandler, HTTPServer
    from urllib.parse import parse_qs, urlparse

    OPEN_COMMAND = "${openCommand}"

    allowed_schemes = ["http", "https"]
    allowed_hostnames = ["localhost", "127.0.0.1", "github.com"]


    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            if self.path != "/mode":
                self.respond(404)
                return

            try:
                result = subprocess.run(["are-we-dark-yet"], capture_output=True, text=True)
                if result.returncode != 0:
                    self.respond(500)
                    return
                self.send_response(200)
                self.send_header("Content-Type", "text/plain")
                self.end_headers()
                self.wfile.write(result.stdout.strip().encode("utf-8"))
            except Exception:
                self.respond(500)

        def do_POST(self):
            if self.path != "/open":
                self.respond(404)
                return

            content_length = int(self.headers["Content-Length"])
            post_data = self.rfile.read(content_length).decode("utf-8")
            form_data = parse_qs(post_data)

            if "url" not in form_data:
                self.respond(400)
                return

            url = form_data["url"][0]
            url_parsed = urlparse(url)

            if url_parsed.scheme not in allowed_schemes:
                self.respond(422)
                return
            if url_parsed.hostname not in allowed_hostnames:
                self.respond(422)
                return

            try:
                subprocess.run([OPEN_COMMAND, url])
                self.respond(200)
                return
            except Exception:
                self.respond(500)
                return

        def respond(self, code):
            self.send_response(code)
            self.end_headers()


    def run_server(port):
        server_address = ("", port)
        httpd = HTTPServer(server_address, Handler)
        print(f"Listening for remote opens on port {port}")
        httpd.serve_forever()


    if __name__ == "__main__":
        parser = argparse.ArgumentParser()
        parser.add_argument("--port", default=8765, type=int, help="Port to listen on")
        args = parser.parse_args()
        run_server(args.port)
  ''
