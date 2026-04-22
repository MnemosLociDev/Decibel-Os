# ============================================================
#  Decibel OS — Packages
#  /etc/nixos/packages.nix
#
#  Everything installed on your system lives here.
#  Add a package name, rebuild, it's installed.
#  Remove it, rebuild, it's gone. Clean and simple.
#
#  Find packages at: https://search.nixos.org/packages
#  Or run: nix search nixpkgs <packagename>
# ============================================================

{ config, pkgs, ... }: {

  # ── Allow Unfree Packages ────────────────────────────────
  # Required for things like Discord, Obsidian etc.
  # Decibel OS philosophy: open source preferred but
  # proprietary software that genuinely supports Linux is welcome.
  nixpkgs.config.allowUnfree = true;

  # ── Core System Packages ─────────────────────────────────
  environment.systemPackages = with pkgs; [

    # ── Terminal & Shell ───────────────────────────────────
    wezterm          # Default terminal, Rust-based, multiplexing built-in
    ghostty          # ALternative terminal
    zsh              # Default shell
    zinit
    starship         # Cross-shell prompt, Rust-based
    zellij           # Terminal multiplexer (optional but available)

    # ── CLI Essentials ─────────────────────────────────────
    fastfetch        # Fetch tool
    git              # Version control — non-negotiable
    eza              # Modern ls replacement with icons and color
    bat              # cat with syntax highlighting
    zoxide           # Smarter cd — learns your habits
    ripgrep          # Faster grep — Rust-based
    fzf              # Fuzzy finder — transforms your workflow
    fd               # Faster find
    btop             # Modern system monitor
    wget
    curl
    unzip
    zip

    # ── Editors ────────────────────────────────────────────
    zed-editor       # Primary GUI editor fast, Rust-based
    neovim           # Terminal editor, for when you go full terminal

    # ── Browser ────────────────────────────────────────────
    brave     # Chromium Based Web Browser
    zen-browser # Fork of mozilla firefox, better privacy based features

    # ── Chat ───────────────────────────────────────────────
    vesktop          # Better Discord client, fixes screensharing on Linux

    # ── File Management ────────────────────────────────────
    nemo             # GUI file manager — clean and not bloated
    yazi             # Terminal file manager — Power User territory

    # ── Wayland Utilities ──────────────────────────────────
    waybar           # Status bar
    fuzzel           # App launcher — minimal and fast
    mako             # Notification daemon
    grimblast        # Screenshot tool — Niri/Wayland native
    cliphist         # Clipboard manager
    wl-clipboard     # Wayland clipboard CLI tools
    swaylock         # Screen locker

    # ── Fonts (see parlor.nix for font config) ─────────────
    # Font packages are declared in parlor.nix

    # ── System Tools ───────────────────────────────────────
    gparted          # Disk partition manager
    timeshift        # System snapshots and restore points
    filelight        # Directory based disk analyzer
    popsicle         # ISO Image Write



  ];

  # ── Flatpak Support ──────────────────────────────────────
  # Secondary package layer for apps not in nixpkgs.
  # Magpie will eventually abstract over this.
  services.flatpak.enable = true;

  # ── Zsh as Default Shell ─────────────────────────────────
  programs.zsh.enable = true;

}
