{ ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      default_agent = "plan";
    };
    tui = {
      theme = "system";
    };
  };
}
