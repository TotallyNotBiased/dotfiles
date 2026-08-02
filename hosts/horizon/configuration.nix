{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/sddm.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    style = {
      wallpapers = [ "${config.users.users.unbiased.home}/dotfiles/assets/wallpaper.jpg" ];
      wallpaperStyle = "centered";
    };
    extraEntries = ''
      /Windows 11
      protocol: efi
      path: uuid(1129758d-79ac-4023-b64c-fe5155dd7a49):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };


  networking.hostName = "horizon";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
  };

  # hacky bullshit since firefox broke in unstable
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "0";
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  systemd.network.links."10-wan" = {
    matchConfig.PermanentMACAddress = "9c:6b:00:85:16:14";
    linkConfig.Name = "Ethernet";
  };

  hardware.wooting.enable = true;

  hardware.bluetooth.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.niri.enable = true;

  users.users.unbiased = {
    isNormalUser = true;
    description = "unbiased";
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
    ];
  };

  environment.systemPackages = with pkgs; [
    sbctl
    xwayland-satellite
  ];

  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = [ "gtk" ];
  };

  system.stateVersion = "26.05";
}
