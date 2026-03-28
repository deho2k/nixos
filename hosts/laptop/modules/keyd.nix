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
                        q = "play";
                        x = "next";
                        z = "prev";
                        a = "left";
                        s = "down";
                        w = "up";
                        d = "right";
                    };
                };
            };
        };
    };
}
