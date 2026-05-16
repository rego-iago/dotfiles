# help @
#   configuration.nix(5) man page
#   https://search.nixos.org/options
#   NixOS manual (`nixos-help`)

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-desktop.nix # hardware scan
    ./module.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs = {
    config.allowUnfree = true;
  };

  module1.enable = false;

  # hardware rgb controls
  services.hardware.openrgb.enable = true;

  # auto-mount external drives
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # mount IOS
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # nvidia configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # steam config
  #hardware.steam-hardware.enable = true;

  # systemd-boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # network
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  # networking config
  # ssh daemon.
  # services.openssh.enable = true;
  # networking.firewall = {
  #   allowedTCPPorts = [ ... ];
  #   allowedUDPPorts = [ ... ];
  # };
  # networking.firewall.enable = false;

  # internationalisation
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "pt_PT.UTF-8";
  i18n.extraLocaleSettings = {
    LANGUAGE = "pt_PT.UTF-8";
    LC_ALL = "pt_PT.UTF-8";
  };
  i18n.supportedLocales = [ "all" ];
  console = {
    keyMap = "pt-latin1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # sound configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # printing configuration
  services.printing.enable = true;

  # bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # user account (password set with ‘passwd’)
  users.users.iago = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "adbusers"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  # external fonts
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    maple-mono.truetype
    maple-mono.NF-CN
    atkinson-hyperlegible-next
  ];

  # touchpad
  services.libinput.enable = true;

  # windowing system
  programs.niri = {
    enable = true;
  };

  # programs & services
  programs.firefox = {
    enable = true;
    policies.WebsiteFilter = {
      Block = [
        "*://*.nitter.net/*"
        "*://nitter.net/*"
        "*://*.youtube.com/*"
        "*://youtube.com/*"
        "*://*.reddit.com/*"
        "*://reddit.com/*"
        "*://*.instagram.com/*"
        "*://instagram.com/*"
        "*://*.skyscrapercity.com/*"
        "*://skyscrapercity.com/*"
        "*://*.bsky.app/*"
        "*://bsky.app/*"
        "*://*.twitch.tv/*"
        "*://twitch.tv/*"
      ];
    };
  };
  programs.tmux.enable = true;
  #programs.steam = { enable = true;
  # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  #};
  programs.adb.enable = true;
  services.tor.enable = true;

  # package management (search: $ nix search wget)
  environment.systemPackages = with pkgs; [

    home-manager # ricing manager

    # terminal
    neovim
    kitty
    wget
    git

    # compilers (for lsps)
    python314
    clang-tools
    texlab
    nil
    jdt-language-server
    unstable.gleam
    ocamlPackages.lsp
    haskellPackages.haskell-language-server
    python3
    erlang
    rebar3

    texlive.combined.scheme-full # system-wide for correct behaviour when compiling

    xwayland-satellite # x11 compatibility

    # notifications
    mako
    dunst
    libnotify

    swww # background
    wofi # launcher program
    starship # terminal personalization
    wl-clipboard # clipboard
    ripgrep

    # image
    hyprpicker
    hyprshade
    hyprshot
    inkscape
    imagemagick

    # international font support
    pango
    libthai
    harfbuzz

    # usb management
    usbutils
    udiskie
    udisks
    libimobiledevice
    ifuse # optional, to mount using 'ifuse'

    # bluetooth
    blueman
    bluez-tools

    pwvucontrol # audio control

    # windows compatibility
    wineWowPackages.stable # both 32 & 64-bit support
    wine # 32-bit support only
    (wine.override { wineBuild = "wine64"; }) # 64-bit support only
    wine64
    wineWowPackages.staging # experimental features
    winetricks # (all versions)
    wineWowPackages.waylandFull # native wayland support (unstable)
    wineWowPackages.full

    tor-browser

    glib
    wlsunset # automatic blue light filter

    # multimedia
    gparted # partition
    libarchive # formatting
    kiwix # archives
    yazi # file explorer
    gallery-dl # image download
    yt-dlp # video download
    calibre # book library
    qgis # FOSS maps
    libwacom # touch tablet
    mpv # video player
    tageditor # music file editor
    amberol # music player
    zathura # pdf viewer
    ffmpeg-full # handle multimedia stream

    # screen recorder
    obs-studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    })

    # social
    telegram-desktop
    signal-desktop
    teams-for-linux

    libreoffice # office

    #prismlauncher # minecraft

    inotify-tools
    ollama

    # system fetch
    hyfetch
    fastfetch
  ];

  nix.settings.auto-optimise-store = true;
  # first verison of NixOs installed, (!!) not to be changed (!!)
  system.stateVersion = "24.11";

}
