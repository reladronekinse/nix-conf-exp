# ============================================================
# NixOS System Configuration
# ============================================================
{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # ── Boot ──────────────────────────────────────────────────
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = [ config.boot.kernelPackages.r8168 ];
    blacklistedKernelModules = [ "r8169" ];
    kernelParams = [ "net.ifnames=0" ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
      grub.enable         = false;
      refind.enable       = true;
    };
  };

  # ── Networking ────────────────────────────────────────────
  networking = {
    hostName    = "nixos";
    enableIPv6  = false;
    nameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ];

    networkmanager = {
      enable = true;
    };

    interfaces.eth0 = {
      mtu = 1500;
      wakeOnLan.enable = false;
    };
  };

  services.flatpak.enable = true;
  # ── Locale & Time ─────────────────────────────────────────
  time.timeZone = "Asia/Yekaterinburg";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS        = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT    = "en_US.UTF-8";
      LC_MONETARY       = "en_US.UTF-8";
      LC_NAME           = "en_US.UTF-8";
      LC_NUMERIC        = "en_US.UTF-8";
      LC_PAPER          = "en_US.UTF-8";
      LC_TELEPHONE      = "en_US.UTF-8";
      LC_TIME           = "en_US.UTF-8";
    };
  };

  # ── Display & Desktop ─────────────────────────────────────
  services.displayManager.gdm.enable = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout  = "us";
      variant = "";
    };
  };

  programs.niri.enable = true;
  programs.xwayland.enable = true;
  # Включить doas
  security.doas.enable = true;

  # Настройка правил: сохранять переменные окружения и запоминать пароль
  security.doas.extraRules = [{
    groups = [ "wheel" ]; # Пользователи в этой группе получают права
    persist = true;       # Не запрашивать пароль каждый раз
    keepEnv = true;       # Сохранять $PATH и другие переменные
  }];

  # Отключить sudo (опционально, если хотите полностью убрать)
  security.sudo.enable = false;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];

    config = {
      common = {
        default = lib.mkForce [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = lib.mkForce [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = lib.mkForce [ "wlr" ];
      };

      niri = {
        default = lib.mkForce [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = lib.mkForce [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = lib.mkForce [ "wlr" ];
      };
    };
  };

  programs.throne = {
    enable          = true;
    tunMode.enable  = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # ── Audio ─────────────────────────────────────────────────
  services.pipewire = {
    enable            = true;
    wireplumber.enable = true;
    alsa = {
      enable      = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable  = true;
  };

  # ── Security ──────────────────────────────────────────────
  security.polkit.enable = true;

  # ── Users ─────────────────────────────────────────────────
  users.users.reladronekinse = {
    isNormalUser = true;
    description  = "reladronekinse";
    extraGroups  = [ "networkmanager" "wheel" ];
    hashedPassword = "$6$lYgyoxJjJ3WRHlP0$T/2/u3eEnBkzgd.Xq7NJQvNWClMdMkEWlNUprQ.bhI58ESVJFVVw.HFvTChW0rsIwu1LA0.Hxs8qXSCI/kF0H.";
  };

  # ── Fonts ─────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    liberation_ttf
    font-awesome
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  # ── System Packages ───────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Core utils
    vim wget git

    # Wayland / display
    wayland mesa libinput
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    qt5.qtwayland
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia

    # Niri / Wayland
    waybar wofi
    awww mako

    # Audio / brightness / clipboard
    alsa-utils pavucontrol playerctl
    brightnessctl wl-clipboard

    # Apps
    kitty
    kdePackages.dolphin kdePackages.ark kdePackages.kate
    librewolf-bin
    telegram-desktop
    libreoffice
    obs-studio
    prismlauncher jdk25
    discord
    mpv
    heroic

    # Eye candy / misc
    fastfetch feh nwg-look
    cava cmatrix

    # Tools
    ethtool
    btop
    cool-retro-term
    lavat
    s-tui
    globe-cli
    qbittorrent
    xwayland-satellite
    neovim
    python3
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "librewolf-unwrapped-151.0.2-1" "librewolf-151.0.2-1"
    "librewolf-bin-151.0.1-2" "librewolf-bin-unwrapped-151.0.1-2"
  ];

  # ── Programs ──────────────────────────────────────────────
  programs.steam = {
    enable                    = true;
    remotePlay.openFirewall   = true;
    dedicatedServer.openFirewall = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      fontconfig libGL
      libX11 libICE libSM
      zlib icu openssl
    ];
  };

  # ── home-manager ──────────────────────────────────────────
  home-manager = {
    useGlobalPkgs        = true;
    useUserPackages      = true;
    backupFileExtension  = "backup";
    users.reladronekinse = import ./home-nix/home.nix;
    users.root            = import ./home-nix/root.nix;
  };

  system.stateVersion = "26.05";
}
