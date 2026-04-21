# ============================================================
#  Decibel OS — Audio
#  /etc/nixos/audio.nix
#
#  Sound configuration. Decibel OS runs Pipewire —
#  the modern Linux audio server that handles everything:
#  system audio, Bluetooth audio, pro audio, screen capture.
#
#  Fitting for an OS named after a unit of sound. 🎵
# ============================================================

{ config, pkgs, ... }: {

  # ── Disable Old Audio Servers ────────────────────────────
  # PulseAudio and JACK are replaced by Pipewire.
  # Pipewire emulates both so your apps still work.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;     # Allows Pipewire real-time priority

  # ── Pipewire ─────────────────────────────────────────────
  services.pipewire = {
    enable = true;
    alsa.enable = true;             # ALSA compatibility
    alsa.support32Bit = true;       # 32-bit app support (games)
    pulse.enable = true;            # PulseAudio compatibility
    jack.enable = true;             # JACK compatibility (pro audio)

    # Low latency config — good for music production
    # Uncomment if you're doing pro audio work
    # extraConfig.pipewire."92-low-latency" = {
    #   context.properties = {
    #     default.clock.rate = 48000;
    #     default.clock.quantum = 32;
    #     default.clock.min-quantum = 32;
    #     default.clock.max-quantum = 32;
    #   };
    # };
  };

  # ── Audio Tools ──────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    pwvucontrol      # Pipewire volume control GUI — clean and modern
    helvum           # Pipewire patchbay — visualize audio routing
    easyeffects      # Audio effects and equalizer
  ];

}
