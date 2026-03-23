{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    theme = "sddm-astronaut-theme";
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling.enable = true;
    mouse.accelProfile = "flat";
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

  users.users.unbiased = {
    isNormalUser = true;
    description = "unbiased";
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    uutils-coreutils
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
  };

  system.stateVersion = "25.11";
}
