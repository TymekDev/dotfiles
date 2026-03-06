{ lib, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$all"
        "$time"
        "$line_break"
        "$character"
      ];

      directory.fish_style_pwd_dir_length = 1;

      rlang.detect_files = [
        ".Rprofile"
        "DESCRIPTION"
        "renv.lock"
      ];

      time = {
        disabled = false;
        format = "at [ $time]($style) ";
        time_format = "%R";
      };
    };
  };
}
