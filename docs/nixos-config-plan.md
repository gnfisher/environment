# NixOS Configuration Plan

## Overview

This document outlines the plan for creating a transportable NixOS configuration for the `gnfisher/environment` repository. The configuration will support two primary deployment targets:

1. **WSL2** (Windows Subsystem for Linux 2) - For development on Windows machines
2. **VMware Fusion VM** - For development on macOS M2 (Apple Silicon) machines

The approach is inspired by [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config) and emphasizes portability, reproducibility, and maintainability.

## Goals

- **Transportability**: Configuration should work across different machines and environments with minimal changes
- **Reproducibility**: Declarative configuration ensures consistent environments
- **Modularity**: Shared configuration with platform-specific overrides
- **Integration**: Seamless integration with existing dotfiles (neovim, tmux, bash, etc.)
- **Ease of Use**: Simple setup process for new machines

## Architecture

### Directory Structure

```
nixos/
├── flake.nix                 # Main flake entry point with outputs
├── flake.lock                # Locked dependencies
├── README.md                 # Setup and usage instructions
├── machines/
│   ├── wsl/
│   │   └── configuration.nix # WSL2-specific configuration
│   └── vm/
│       └── configuration.nix # VMware Fusion VM configuration
├── modules/
│   ├── base.nix             # Shared base configuration
│   ├── development.nix      # Development tools and environment
│   ├── neovim.nix           # Neovim setup (integrating existing config)
│   └── shell.nix            # Shell configuration (bash, tmux)
└── users/
    └── gnfisher.nix         # User-specific configuration
```

## Design Choices

### 1. Flakes-Based Configuration

**Choice**: Use Nix Flakes for dependency management and configuration

**Rationale**:
- Modern approach to Nix configuration
- Better reproducibility with locked dependencies via `flake.lock`
- Cleaner interface for defining multiple system configurations
- Easier to understand and maintain than traditional channel-based approach
- Industry standard (used by mitchellh and many others)

**Implementation**:
```nix
# flake.nix structure
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager }: {
    nixosConfigurations = {
      wsl = { ... };    # WSL2 configuration
      vm = { ... };     # VM configuration
    };
  };
}
```

### 2. Platform-Specific Configurations

**Choice**: Separate machine configurations for WSL2 and VMware VM

**Rationale**:
- WSL2 requires specific modules (`nixos-wsl`) and kernel configurations
- VMware requires specific graphics and virtualization settings
- Each platform has different hardware capabilities (e.g., GPU, storage)
- Allows optimization for each environment while sharing common configuration

**WSL2-Specific Considerations**:
- Use `nixos-wsl` module for WSL integration
- Enable systemd (if available)
- Configure WSL-specific networking
- Set up Windows interoperability (e.g., accessing Windows filesystem)

**VMware VM-Specific Considerations**:
- Enable VMware guest tools
- Configure appropriate graphics drivers for Apple Silicon
- Set up shared folders for macOS integration
- Optimize for ARM64 architecture (M2 chip)

### 3. Home Manager Integration

**Choice**: Use Home Manager for user-level configuration

**Rationale**:
- Separates system-level from user-level configuration
- Better management of dotfiles and user applications
- Can be used standalone or integrated with NixOS
- Allows non-root configuration management

**Integration Points**:
- Neovim configuration (from `shared/.config/nvim/`)
- Tmux configuration (from `shared/.config/tmux.conf`)
- Bash/shell configuration
- Git configuration

### 4. Modular Configuration Approach

**Choice**: Split configuration into focused, reusable modules

**Rationale**:
- `base.nix`: Core system configuration (users, locale, timezone, basic packages)
- `development.nix`: Development tools (compilers, interpreters, build tools)
- `neovim.nix`: Editor configuration (maps to existing nvim config)
- `shell.nix`: Terminal and shell setup (bash, tmux, utilities)

This separation allows:
- Easy customization per machine
- Clear organization and maintainability
- Reusability across different system configurations
- Easier debugging and updates

### 5. Dotfiles Integration Strategy

**Choice**: Integrate existing dotfiles via Home Manager's `xdg.configFile`

**Rationale**:
- Preserve existing, working neovim and tmux configurations
- Avoid duplicating configuration logic
- Use Nix to install dependencies, traditional dotfiles for configuration
- Gradual migration path (can Nix-ify configs over time if desired)

**Implementation Approach**:
```nix
# In neovim.nix or home-manager config
home.file.".config/nvim" = {
  source = ../shared/.config/nvim;
  recursive = true;
};
```

## Package Selection

### Core System Packages (base.nix)

```nix
environment.systemPackages = with pkgs; [
  # Essential utilities
  wget curl git vim
  
  # System tools
  htop btop
  killall
  
  # Archive tools
  unzip zip
  
  # Network tools
  dig
];
```

### Development Packages (development.nix)

```nix
environment.systemPackages = with pkgs; [
  # Version control
  git gh
  
  # Build tools
  gnumake gcc
  
  # Languages/runtimes
  nodejs_20
  go
  python3
  
  # Development utilities
  jq ripgrep fd
  tmux stow
  fuse
  
  # Neovim (latest)
  neovim
];
```

### Neovim Dependencies (neovim.nix)

The existing neovim configuration requires specific tools. Ensure these are installed:

```nix
environment.systemPackages = with pkgs; [
  # LSP servers
  nodePackages.vtsls          # TypeScript/JavaScript
  gopls                        # Go
  lua-language-server          # Lua
  
  # Required for neovim plugins
  git                          # lazy.nvim
  gcc                          # treesitter compilation
  nodejs                       # some plugins
  ripgrep                      # telescope
  fd                           # telescope
];
```

## Usage

### Initial Setup

#### For WSL2:

1. **Install WSL2** (if not already installed):
   ```powershell
   wsl --install --no-distribution
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   # Restart computer
   ```

2. **Download NixOS-WSL**:
   ```powershell
   # Download latest nixos-wsl.tar.gz from GitHub releases
   # https://github.com/nix-community/NixOS-WSL/releases
   
   wsl --import NixOS $env:USERPROFILE\NixOS nixos-wsl.tar.gz --version 2
   wsl -s NixOS
   ```

3. **Clone and apply configuration**:
   ```bash
   # Inside WSL
   git clone https://github.com/gnfisher/environment.git ~/environment
   cd ~/environment/nixos
   sudo nixos-rebuild switch --flake .#wsl
   ```

#### For VMware Fusion VM:

1. **Create VM**:
   - Download NixOS ARM64 ISO from [Hydra](https://hydra.nixos.org/)
   - Create new VM in VMware Fusion
   - Select ARM64 architecture
   - Allocate 4GB+ RAM, 20GB+ disk
   - Enable UEFI boot

2. **Install NixOS**:
   ```bash
   # Boot from ISO
   sudo su
   
   # Partition disk (example with UEFI)
   parted /dev/sda -- mklabel gpt
   parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
   parted /dev/sda -- set 1 boot on
   parted /dev/sda -- mkpart primary 512MiB 100%
   
   # Format partitions
   mkfs.fat -F 32 -n boot /dev/sda1
   mkfs.ext4 -L nixos /dev/sda2
   
   # Mount
   mount /dev/disk/by-label/nixos /mnt
   mkdir -p /mnt/boot
   mount /dev/disk/by-label/boot /mnt/boot
   
   # Clone repo and use config
   nix-shell -p git
   git clone https://github.com/gnfisher/environment.git /mnt/etc/nixos/environment
   cd /mnt/etc/nixos/environment/nixos
   
   # Install
   nixos-install --flake .#vm
   ```

### Updating Configuration

```bash
# Pull latest changes
cd ~/environment
git pull

# Rebuild system
sudo nixos-rebuild switch --flake ./nixos#wsl   # or #vm
```

### Adding New Packages

1. **System-wide packages**: Add to appropriate module in `nixos/modules/`
2. **User packages**: Add to `nixos/users/gnfisher.nix` using Home Manager
3. Rebuild: `sudo nixos-rebuild switch --flake ./nixos#<target>`

### Testing Changes

```bash
# Test configuration without switching
sudo nixos-rebuild test --flake ./nixos#wsl

# Build but don't activate (useful for CI/testing)
sudo nixos-rebuild build --flake ./nixos#wsl
```

## Configuration Details

### Base Configuration (base.nix)

**System Settings**:
- Locale: `en_US.UTF-8`
- Timezone: `America/Los_Angeles` (or make configurable per-machine)
- Enable flakes and nix-command
- Allow unfree packages (if needed, e.g., for some proprietary tools)

**User Setup**:
- Create user `gnfisher`
- Add to appropriate groups (wheel, docker, etc.)
- Set up home directory

**Security**:
- Enable sudo
- Configure firewall (conservative defaults)

### Development Configuration (development.nix)

**Core Development Tools**:
- Git with default configuration
- GitHub CLI (gh)
- Modern Unix tools: ripgrep, fd, jq
- Build essentials: make, gcc/clang

**Language Support**:
- Node.js (LTS version)
- Go (latest stable)
- Python 3 (with pip)
- Rust (via rustup or direct package)

**Development Utilities**:
- tmux (for terminal multiplexing)
- stow (for dotfile management, if still needed)
- Docker (if needed for containerization)

### Neovim Configuration (neovim.nix)

**Package Installation**:
- Install neovim package (latest stable or unstable)
- Install all LSP servers used in config
- Install tools required by plugins (ripgrep, fd, git)

**Configuration Integration**:
- Symlink existing neovim config from `shared/.config/nvim/`
- Ensure all Lua plugins can be loaded
- Set up lazy.nvim for plugin management (already in existing config)

**Dependencies**:
- Tree-sitter CLI (for syntax highlighting)
- Node.js (for some plugins)
- Python 3 with pynvim (for Python plugins)

### Shell Configuration (shell.nix)

**Bash Setup**:
- Use existing `.bashrc` from `shared/`
- Configure bash-completion
- Set up aliases and functions

**Tmux Setup**:
- Use existing `tmux.conf` from `shared/.config/`
- Ensure clipboard integration works (x11 for VM, Windows clipboard for WSL)

**Utilities**:
- fzf (fuzzy finder)
- bat (better cat)
- exa/eza (better ls)
- zoxide (smart cd)

### User Configuration (users/gnfisher.nix)

**Home Manager Configuration**:
```nix
home-manager.users.gnfisher = { pkgs, ... }: {
  home.stateVersion = "24.05";
  
  # Link dotfiles
  home.file.".config/nvim".source = ../../shared/.config/nvim;
  home.file.".config/tmux.conf".source = ../../shared/.config/tmux.conf;
  
  # User packages
  home.packages = with pkgs; [
    # Add user-specific packages here
  ];
  
  # Git configuration
  programs.git = {
    enable = true;
    userName = "Greg Fisher";
    userEmail = "gnfisher@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
};
```

## Platform-Specific Details

### WSL2 Configuration (machines/wsl/configuration.nix)

**WSL-Specific Settings**:
```nix
{
  imports = [
    "${nixos-wsl}/modules"
    ../../modules/base.nix
    ../../modules/development.nix
    ../../modules/neovim.nix
    ../../modules/shell.nix
  ];
  
  wsl = {
    enable = true;
    defaultUser = "gnfisher";
    startMenuLaunchers = true;
    
    # Enable systemd (if supported)
    nativeSystemd = true;
    
    # WSL-specific features
    interop.enable = true;  # Windows interop
    wslConf = {
      network.generateResolvConf = true;
    };
  };
  
  # Other WSL-specific settings
}
```

**Considerations**:
- Windows PATH integration (optional)
- Windows drive mounting (`/mnt/c`)
- Network configuration (use Windows DNS)
- SystemD availability

### VMware VM Configuration (machines/vm/configuration.nix)

**VM-Specific Settings**:
```nix
{
  imports = [
    ../../modules/base.nix
    ../../modules/development.nix
    ../../modules/neovim.nix
    ../../modules/shell.nix
  ];
  
  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # VMware guest support
  virtualisation.vmware.guest.enable = true;
  
  # Graphics (for ARM64/Apple Silicon)
  hardware.opengl.enable = true;
  
  # Networking
  networking.hostName = "nixos-dev";
  networking.networkmanager.enable = true;
  
  # SSH for remote access
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };
}
```

**Considerations**:
- ARM64 architecture (aarch64-linux)
- VMware tools for better integration
- Shared folders with macOS host
- Graphics performance optimization
- Network configuration (bridged vs NAT)

## Migration Path

### Phase 1: Initial Setup (This Plan)
- ✅ Write comprehensive plan document
- Create basic directory structure
- Document usage and design decisions

### Phase 2: Core Implementation (Next Steps)
- Create `flake.nix` with basic structure
- Implement `base.nix` module
- Create WSL2 configuration
- Test on WSL2 environment

### Phase 3: VM Support
- Create VM configuration
- Test on VMware Fusion with M2
- Optimize for ARM64

### Phase 4: Enhancement
- Add Home Manager integration
- Migrate more dotfile configuration to Nix
- Add development.nix with all tools
- Create helper scripts for common tasks

### Phase 5: Documentation
- Write detailed README in nixos/
- Add troubleshooting guide
- Document common tasks and workflows

## Benefits of This Approach

1. **Reproducibility**: Exact same environment on any machine
2. **Version Control**: All system configuration in git
3. **Atomic Upgrades**: Can rollback if something breaks
4. **Declarative**: State what you want, not how to get there
5. **Portable**: Works on WSL2, VMs, bare metal
6. **Maintainable**: Modular structure makes updates easy
7. **Integration**: Seamlessly works with existing dotfiles

## Potential Challenges & Solutions

### Challenge 1: ARM64 Package Availability
**Issue**: Some packages may not be available or tested on aarch64-linux  
**Solution**: Use `nixpkgs` unstable channel which has better ARM support, fallback to x86_64 emulation if needed

### Challenge 2: WSL-Specific Quirks
**Issue**: WSL2 has some limitations compared to native Linux  
**Solution**: Use well-maintained `nixos-wsl` module, document known limitations

### Challenge 3: Learning Curve
**Issue**: Nix/NixOS has a steep learning curve  
**Solution**: Start with simple configuration, iteratively add features, document everything

### Challenge 4: Neovim Plugin Management
**Issue**: Some neovim plugins expect certain tools to be available  
**Solution**: Explicitly declare all dependencies in neovim.nix

### Challenge 5: Existing Dotfiles
**Issue**: Integration with existing non-Nix dotfiles  
**Solution**: Use Home Manager's file management to symlink existing configs, migrate gradually

## Additional Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Flakes Guide](https://nixos.wiki/wiki/Flakes)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS-WSL Documentation](https://github.com/nix-community/NixOS-WSL)
- [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config) - Inspiration and reference
- [NixOS on ARM/Apple Silicon](https://nixos.wiki/wiki/NixOS_on_ARM/Apple_Silicon_Macs)

## Next Steps

1. Review and approve this plan
2. Create initial `flake.nix` and basic module structure
3. Test WSL2 configuration
4. Test VM configuration
5. Iterate based on real-world usage
6. Document any issues or deviations from the plan

---

**Note**: This is a living document. As we implement the configuration, we may discover better approaches or encounter unexpected challenges. The plan should be updated to reflect our learnings and actual implementation decisions.
