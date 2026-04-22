# ============================================================
#  Decibel OS ? — Root Configuration
#  /etc/nixos/configuration.nix
#
#  This is the entry point for your entire system config.
#  It doesn't define anything itself, it just pulls in
#  all the other modules and lets them do their thing.
#
#  Think of this as the server list. Each import below
#  is like a channel with its own purpose.
# ============================================================

{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix  # Auto-generated during install, not suppose to touch this
    ./parlor.nix                  # visual, environments
    ./packages.nix                # Everything installed on your system
    ./users.nix                   # Your user accounts and permissions
    ./network.nix                 # Networking, firewall, Bluetooth
    ./audio.nix                   # Sound, Pipewire and friends
    ./display.nix                 # Compositor, greeter, display settings in general
    ./dev.nix                     # Development tools and environments
    ./services.nix                # Background daemons & system services
  ];

  # ── Nix's Identity ──────────────────────────────────────
  networking.hostName = "decibel";

  # ── Nix's Settings ─────────────────────────────────────────
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # ── Automatic Garbage Collection ─────────────────────────
  # Keeps your /nix/store from growing forever.
  # Runs weekly and removes generations older than 7 days.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # ── Bootloader ───────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Keep last 5 generations in the boot menu
  boot.loader.systemd-boot.configurationLimit = 5;

  # ── Time & Locale ─────────────────────────────────────────
  time.timeZone = "UTC"; # Change to your timezone
  i18n.defaultLocale = "en_US.UTF-8";

  # ── State Version ─────────────────────────────────────────
  # Do not change this after installation.
  # It tracks NixOS backwards compatibility for your system.
  system.stateVersion = "24.11";

}
