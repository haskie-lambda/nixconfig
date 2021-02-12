{ ... }: 

{
  services.dunst = {
    enable = true;
    settings = {
      shortcuts = {
        close="ctrl+space";
        close_all="ctrl+shift+space";
        history = "ctrl+<";
      };
      global = {
        geometry = "300x15-30+50";
        format = "<b>%a</b>\n<i>%s</i>\n%b\n%p";
        indicate_hidden = "yes";
        sort = "yes";
        font = "Monocpace 10";
        word_wrap = "yes";
        stack_duplicates = true;
        show_indicators = "yes";
        browser = "/usr/bin/firefox -new-tab";
        verbosity = "mesg";
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
      };
      
    };
  };
}
