# ============================================================
#  Decibel OS — Parlor
#  /etc/nixos/parlor.nix
#
#  Your visual environment. This is the best place to start
#  if you're new to Decibel OS. Change things here and run
#  `sudo nixos-rebuild switch` to see results immediately.
#
#  Low risk. High reward. Break something? Just roll back.
#  Nothing here touches your system's core functionality.
# ============================================================

{ config, pkgs, ... }: {

  # ── Compositor ───────────────────────────────────────────
  # Niri is a scrollable tiling Wayland compositor.
  # Written in Rust. Fast, minimal, and very riced.
  programs.niri = {
    enable = true;
  };

  # ── Fonts ────────────────────────────────────────────────
  # JetBrains Mono Nerd Font is the default coding font.
  # Nerd Fonts patch in icons so your terminal looks great.
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono    # Default coding font
      nerd-fonts.fira-code         # Alternative coding font
      inter                        # UI font
    ];
    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Inter" ];
    };
  };

  # ── GTK Theme ────────────────────────────────────────────
  # Controls how GTK apps (most Linux apps) look.
  # TODO: Define Decibel OS custom theme
  programs.dconf.enable = true;

  # ── Cursor ───────────────────────────────────────────────
  # TODO: Define Decibel OS custom cursor theme
  environment.variables = {
    XCURSOR_SIZE = "24";
  };

  # ── Color Scheme ─────────────────────────────────────────
  # Decibel OS color palette — dark purple base.
  # These variables are available system-wide.
  # TODO: Finalize full palette
  environment.variables = {
    DECIBEL_ACCENT     = "#7289DA";   # Discord-nodding purple
    DECIBEL_BACKGROUND = "#1E1E2E";   # Deep dark base
    DECIBEL_SURFACE    = "#2A2A3E";   # Slightly lighter surface
    DECIBEL_TEXT       = "#CDD6F4";   # Soft white text
    DECIBEL_BORDER     = "#45475A";   # Subtle borders
  };

  # ── Wayland Environment Variables ────────────────────────
  # Makes sure apps know they're running on Wayland.
  environment.sessionVariables = {
    NIXOS_OZONE_WL      = "1";        # Electron apps use Wayland
    WLR_NO_HARDWARE_CURSORS = "1";    # Fix cursor issues on some hardware
    MOZ_ENABLE_WAYLAND  = "1";        # Firefox/Librewolf Wayland support
  };

}
