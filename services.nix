# ============================================================
#  Decibel OS — Services
#  /etc/nixos/services.nix
#
#  Background daemons and system services.
#  These run quietly in the background keeping things working.
#  You rarely need to change this unless you're adding
#  a server or specific system feature.
# ============================================================

{ config, pkgs, ... }: {

  # ── D-Bus ────────────────────────────────────────────────
  # Inter-process communication — required by most desktop apps
  services.dbus.enable = true;

  # ── XDG Portal ───────────────────────────────────────────
  # Allows sandboxed apps (Flatpak) to access system resources
  # like file picker, screen sharing, notifications
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome   # File picker and screen share
    ];
    config.common.default = "*";
  };

  # ── Polkit ───────────────────────────────────────────────
  # Handles permission requests — "do you want to allow this app
  # to make system changes?" prompts
  security.polkit.enable = true;

  # ── Udisks ───────────────────────────────────────────────
  # Automatic mounting of USB drives and external storage
  services.udisks2.enable = true;

  # ── Upower ───────────────────────────────────────────────
  # Battery monitoring and power management
  services.upower.enable = true;

  # ── Thermald ─────────────────────────────────────────────
  # Intel thermal management — keeps your CPU cool
  # Important for the EliteBook 830 G5
  services.thermald.enable = true;

  # ── TLP ──────────────────────────────────────────────────
  # Power management for laptops — extends battery life
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC  = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  # ── Printing ─────────────────────────────────────────────
  # Enable if you need printer support
  # services.printing.enable = true;

  # ── SSH ──────────────────────────────────────────────────
  # SSH client is available by default.
  # Uncomment below ONLY if you want this machine to accept
  # incoming SSH connections.
  # services.openssh = {
  #   enable = true;
  #   settings.PasswordAuthentication = false;  # Key-based auth only
  # };

  # ── Syncthing ────────────────────────────────────────────
  # File sync across devices — good for keeping configs in sync
  # Uncomment to enable
  # services.syncthing = {
  #   enable = true;
  #   user = "decibel";           # Change to your username
  #   dataDir = "/home/decibel";
  # };

  # ── Automatic Updates ────────────────────────────────────
  # NixOS can automatically upgrade itself.
  # Disabled by default — upgrade manually with `rebuild`
  # system.autoUpgrade = {
  #   enable = true;
  #   dates = "weekly";
  # };

}
