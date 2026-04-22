# Decibel OS — Config Structure

Welcome to your system config. This is where Decibel OS lives.

Unlike stock NixOS which dumps everything into one massive `configuration.nix`, Decibel OS splits your config into focused modules. Each file has one job. Find what you want to change, change it, rebuild. Simple.

---

## How It Works

Every file in this folder is a NixOS module. They all get pulled into `configuration.nix` via imports and merged together when you rebuild your system.

To apply any change you make:

```bash
sudo nixos-rebuild switch
```

To roll back to the previous version if something breaks:

```bash
sudo nixos-rebuild switch --rollback
```

Or just reboot and pick a previous generation from the boot menu. NixOS keeps your last 5 generations by default. You can always go back.

---

## The Files

### `configuration.nix`
The root. Doesn't define anything itself — just imports all the other modules. You rarely need to touch this.

### `parlor.nix` ← Start here
Your visual environment. Fonts, colors, compositor, Wayland settings. This is the lowest-risk file to experiment with. Change something, rebuild, see what happens. Nothing here can break your system's core functionality.

### `packages.nix`
Everything installed on your system. Add a package name, rebuild, it's installed. Remove it, rebuild, it's gone. Find package names at [search.nixos.org](https://search.nixos.org/packages).

### `users.nix`
Your user account and what it's allowed to do. Change your username here before first install. Set your actual password after install with `passwd <username>`.

### `network.nix`
WiFi, ethernet, firewall, Bluetooth. Mostly works out of the box. Come here if you need to open firewall ports or configure Bluetooth behavior.

### `audio.nix`
Pipewire and sound. Fitting for an OS named after a unit of sound. Handles system audio, Bluetooth audio, and pro audio setups. Uncomment the low-latency config if you're doing music production.

### `display.nix`
Display server, greeter, and hardware acceleration. Intel VA-API is configured for the EliteBook 830 G5 by default. Come here for monitor configuration and night light settings.

### `dev.nix`
Development tools. Rust ships by default. Docker, Distrobox, and dev utilities are here. Shell aliases and Starship prompt config live here too.

### `services.nix`
Background daemons. Power management, D-Bus, XDG portals, automatic mounting. You rarely need to touch this. It just keeps things running.

---

## Quick Reference

| Task | File | Command |
|------|------|---------|
| Change fonts | `parlor.nix` | `sudo nixos-rebuild switch` |
| Install an app | `packages.nix` | `sudo nixos-rebuild switch` |
| Add a user | `users.nix` | `sudo nixos-rebuild switch` |
| Open a port | `network.nix` | `sudo nixos-rebuild switch` |
| Fix audio | `audio.nix` | `sudo nixos-rebuild switch` |
| Change greeter | `display.nix` | `sudo nixos-rebuild switch` |
| Add a dev tool | `dev.nix` | `sudo nixos-rebuild switch` |
| Enable a service | `services.nix` | `sudo nixos-rebuild switch` |
| Roll back | anywhere | `sudo nixos-rebuild switch --rollback` |

---

## Finding Packages

```bash
# Search from terminal
nix search nixpkgs firefox

# Or visit
# https://search.nixos.org/packages
```

## Useful Commands

```bash
# Apply your config changes
sudo nixos-rebuild switch

# Test changes without making them permanent
sudo nixos-rebuild test

# Roll back to previous generation
sudo nixos-rebuild switch --rollback

# Clean up old generations (free up disk space)
sudo nix-collect-garbage -d

# Show current and past generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Update all packages
sudo nix flake update
sudo nixos-rebuild switch
```

---

## The Decibel OS Philosophy

**Freedom through structure.** NixOS gives you total control but that control can be overwhelming. Decibel OS gives that control a shape, each file knows its job, beginners know where to start, power users know where to dig & die.

You start in `parlor.nix`. You make it yours. You get curious. You explore the other files. Before you know it you understand your whole system. That's the path.

**Reproducible by default.** Your entire OS is defined in these files. Back them up and you can recreate your exact system anywhere. Share a module and someone else gets your exact setup for that part of their system.

**Roll back everything.** Broke something? It's fine. NixOS keeps your previous generations. Reboot, pick an older one, you're back. No reinstalling. No panic. Just learning.

---

*Decibel OS — where the system has good acoustics, an operating system with a voice.* 🎵
