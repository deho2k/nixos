{pkgs, ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(media, esc)";
            rightalt = "leftcontrol";
          };
          media = {
            tab = "delete";
            shift = "volumeup";
            control = "volumedown";
            escape = "~";
            c = "f13";
            v = "f14";
            q = "play";
            x = "next";
            z = "prev";
            a = "left";
            s = "down";
            w = "up";
            d = "right";
            "1" = "f1";
            "2" = "f2";
            "3" = "f3";
            "4" = "f4";
            "5" = "f5";
            "6" = "f6";
            "7" = "f7";
            "8" = "f8";
            "9" = "f9";
            "0" = "f10";
            minus = "f11";
            equal = "f12";
          };
        };
      };
    };
  };
}
