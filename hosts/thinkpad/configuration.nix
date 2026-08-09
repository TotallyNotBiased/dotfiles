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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling.enable = true;
    mouse.accelProfile = "flat";
  };

  # hacky bullshit since firefox broke in unstable
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "0";
  };

  hardware.trackpoint = {
    enable = true;
    sensitivity = 100;
  };

  hardware.wooting.enable = true;

  hardware.bluetooth.enable = true;
  services.tlp.enable = false;
  services.tuned.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.niri.enable = true;

  programs.gpu-screen-recorder.enable = true;

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
    xwayland-satellite
    brightnessctl
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

  system.stateVersion = "25.11";
}
