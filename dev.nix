# ============================================================
#  Decibel OS — Development
#  /etc/nixos/dev.nix
#
#  Development tools and environments.
#  Rust ships by default — it's the language Decibel OS
#  itself is being built with.
#
#  Other runtimes are available but opt-in — install what
#  you need, not everything.
# ============================================================

{ config, pkgs, ... }: {

  # ── Rust ─────────────────────────────────────────────────
  # Ships with Decibel OS by default.
  # Rust is the primary language of the Decibel OS ecosystem.
  environment.systemPackages = with pkgs; [

    # ── Rust ───────────────────────────────────────────────
    rustup            # Rust toolchain manager — installs rustc and cargo
    # After install run: rustup default stable

    # ── Build Tools ────────────────────────────────────────
    gcc               # C compiler — needed for many build scripts
    gnumake           # Make build system
    pkg-config        # Helps find system libraries
    openssl           # SSL library — needed by many Rust crates

    # ── Container & Virtualization ─────────────────────────
    docker            # Container runtime
    docker-compose    # Multi-container orchestration
    distrobox         # Run any Linux distro in a container
                      # Gives access to apt, dnf, etc. from NixOS

    # ── Dev Utilities ──────────────────────────────────────
    jq                # JSON processor — essential for scripting
    httpie            # Friendly HTTP client
    bruno             # API testing — open source Postman alternative
    sqlite            # Lightweight database

    # ── Optional Runtimes ──────────────────────────────────
    # Uncomment what you need or install via Magpie later

    # nodejs_20       # JavaScript/TypeScript runtime
    # python3         # Python
    # go              # Golang
    # jdk17           # Java

  ];

  # ── Docker Service ───────────────────────────────────────
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;           # Start Docker only when needed
    autoPrune = {
      enable = true;
      dates = "weekly";             # Clean up unused images weekly
    };
  };

  # ── Nix Development Shell ────────────────────────────────
  # nix-direnv integrates Nix shells with your shell automatically
  # Enter a directory with a shell.nix and it activates instantly
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ── Shell Configuration ──────────────────────────────────
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      # Eza aliases — replace ls with something beautiful
      ls    = "eza --icons";
      ll    = "eza --icons --long";
      la    = "eza --icons --long --all";
      lt    = "eza --icons --tree";

      # Git shortcuts
      gs    = "git status";
      ga    = "git add";
      gc    = "git commit";
      gp    = "git push";
      gl    = "git log --oneline --graph";

      # Decibel OS rebuild shortcut
      rebuild = "sudo nixos-rebuild switch";
      rollback = "sudo nixos-rebuild switch --rollback";

      # Bat as cat
      cat   = "bat";
    };
  };

  # ── Starship Prompt ──────────────────────────────────────
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$rust$nodejs$python$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](bold purple)";
        error_symbol   = "[❯](bold red)";
      };
      directory = {
        style = "bold cyan";
        truncate_to_repo = true;
      };
      rust = {
        symbol = "🦀 ";
        style  = "bold orange";
      };
      git_branch = {
        style  = "bold purple";
        symbol = " ";
      };
    };
  };

}
