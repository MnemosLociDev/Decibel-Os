# ============================================================
#  Decibel OS — Users
#  /etc/nixos/users.nix
#
#  Your user accounts and what they're allowed to do.
#  Change your username here before first install.
#
#  Note: Passwords are NOT set here for security reasons.
#  Set your password after install with: passwd <username>
# ============================================================

{ config, pkgs, ... }: {

  # ── Primary User ─────────────────────────────────────────
  users.users.decibel = {           # Change "decibel" to your username
    isNormalUser = true;
    description  = "Decibel OS User";
    shell        = pkgs.zsh;        # Zsh as default shell

    # Groups define what your user is allowed to do.
    # Don't remove existing ones — they're here for a reason.
    extraGroups  = [
      "wheel"         # Allows sudo — you need this
      "networkmanager" # Manage network connections
      "audio"         # Access to audio devices
      "video"         # Access to video/GPU
      "input"         # Access to input devices (keyboard, mouse)
      "storage"       # Access to storage devices
      "docker"        # Run Docker containers without sudo
      "gamemode"      # GameMode optimizations for gaming
    ];
  };

  # ── Sudo Configuration ───────────────────────────────────
  # Wheel group members can use sudo.
  security.sudo.wheelNeedsPassword = true;  # Always require password for sudo

  # ── Root Account ─────────────────────────────────────────
  # Root login is disabled by default for security.
  # Use sudo instead.
  users.users.root.hashedPassword = "!";

}
