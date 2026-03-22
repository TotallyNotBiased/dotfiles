{ pkgs, inputs, ... }:
{
  home-manager.users.unbiased = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          density = "compact";
          position = "top";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "WiFi";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          avatarImage = "/home/unbiased/.face";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = false;
          name = "Melbourne, Australia";
        };
        wallpaper = {
          enabled = true;
          directory = "/home/unbiased/img/wallpaper/";
        };
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
    };
  };
}
