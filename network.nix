# ============================================================
#  Decibel OS — Network
#  /etc/nixos/network.nix
#
#  Networking, firewall, and Bluetooth.
#  Most of this just works out of the box.
#  You probably won't need to touch this often.
# ============================================================

{ config, pkgs, ... }: {

  # ── NetworkManager ───────────────────────────────────────
  # Handles WiFi, ethernet, VPN connections.
  # nm-applet gives you a system tray icon for quick access.
  networking.networkmanager.enable = true;

  # ── Firewall ─────────────────────────────────────────────
  # Enabled by default. Blocks incoming connections
  # unless you explicitly open a port.
  networking.firewall = {
    enable = true;

    # Open ports here when you need them.
    # Example: allowedTCPPorts = [ 80 443 8080 ];
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # ── Bluetooth ────────────────────────────────────────────
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;             # Bluetooth on at startup
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;   # Bluetooth manager GUI

  # ── DNS ──────────────────────────────────────────────────
  # Using Cloudflare and Google DNS by default.
  # TODO: Consider privacy-focused DNS alternatives
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # ── Network Tools ────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    networkmanagerapplet  # nm-applet system tray icon
    nmap                  # Network scanner
    iproute2              # ip command
  ];

}
