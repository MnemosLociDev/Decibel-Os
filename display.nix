# ============================================================
#  Decibel OS — Display
#  /etc/nixos/display.nix
#
#  Display server, greeter, and compositor settings.
#  This is the layer between your hardware and your desktop.
# ============================================================

{ config, pkgs, ... }: {

  # ── Wayland / Display Server ─────────────────────────────
  # Decibel OS is Wayland-first. No Xorg by default.
  # Most modern apps work natively on Wayland.
  services.xserver.enable = false;  # Disable Xorg

  # XWayland allows old X11 apps to run inside Wayland
  # Enable this if you need legacy app support
  # programs.xwayland.enable = true;

  # ── Login Greeter ────────────────────────────────────────
  # Greetd is a minimal login manager that works with any compositor.
  # ReGreet is a clean GTK greeter that sits on top of it.
  # TODO: Replace with custom Decibel OS themed greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # ── Hardware Acceleration ────────────────────────────────
  # Intel UHD 620 — VA-API hardware video acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver    # VA-API driver for Intel GPUs
      vaapiIntel            # Older Intel VA-API support
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # ── Display Tools ────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    greetd.tuigreet   # TUI greeter
    wlr-randr         # Monitor management on Wayland
    kanshi            # Auto display config switching
  ];

  # ── Night Light ──────────────────────────────────────────
  # Reduces blue light in the evening.
  # TODO: Pick between wlsunset or gammastep
  # services.wlsunset = {
  #   enable = true;
  #   latitude = "0.0";   # Set your latitude
  #   longitude = "0.0";  # Set your longitude
  # };

}
