# environment

Personal development environment managed with GNU Stow.

## Overview

This repository contains my personal dotfiles and configuration files for various tools and applications, managed using GNU Stow for easy deployment across different systems.

## Repository Layout

- `install/` - Setup scripts (e.g., `codespace-setup.sh`)
- `linux/` - Linux-specific configs (`.gnupg/`)
- `macos/` - macOS-specific configs (`.config/aerospace/`)
- `shared/` - Cross-platform configs stowed to `~`
- `resources/` - Fonts and other resources

## Usage

Apply shared configs:
```bash
stow -d ~/Development/gnfisher/environment -t ~ shared
```

Apply macOS configs:
```bash
stow -d ~/Development/gnfisher/environment -t ~ macos
```

Dry run:
```bash
stow -n -v -d ~/Development/gnfisher/environment -t ~ shared
```

## Copyright

Copyright (c) 2026 gnfisher

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
