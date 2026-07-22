# Environment

macOS development environment managed with Homebrew, GNU Stow, and mise.

This repository contains both generally useful personal configuration and
GitHub work-specific tooling. It is not currently a one-command bootstrap and
the `Brewfile` is a curated package list rather than a complete inventory of
everything installed on the machine.

## What It Manages

- `Brewfile` - command-line tools and selected application casks
- `home/` - files linked into the home directory with GNU Stow
- `home/.config/` - Ghostty, Neovim, mise, GitHub CLI, Herdr, and OpenCode
- `home/.copilot/` - Copilot CLI settings, hooks, agents, and skills
- `home/.local/bin/` - local command-line utilities
- `home/.local/share/raycast-scripts/` - Raycast script commands

The repository assumes macOS, zsh, Apple silicon Homebrew when available, and
repositories checked out under `~/Development/<owner>/<repo>`.

## Fresh Mac Setup

There is no `install.sh`. Set up a new Mac in stages:

1. Install the Xcode Command Line Tools and Homebrew.
2. Authenticate with GitHub and clone this repository:

   ```bash
   mkdir -p ~/Development/gnfisher
   git clone git@github.com:gnfisher/environment.git \
     ~/Development/gnfisher/environment
   cd ~/Development/gnfisher/environment
   ```

3. Install the declared Homebrew software:

   ```bash
   brew bundle
   ```

4. Preview the Stow operation before creating links:

   ```bash
   stow --simulate --verbose --target="$HOME" home
   ```

5. Resolve any reported conflicts, then create the links:

   ```bash
   stow --target="$HOME" home
   ```

6. Install the language runtimes declared in mise:

   ```bash
   mise install
   ```

Stow requires an existing target file to be removed or merged before it can
replace that file with a link. Do not use `stow --adopt` without reviewing the
result because it can overwrite the repository copy.

Copilot CLI can rewrite `~/.copilot/settings.json` and
`~/.copilot/mcp-config.json`. On an existing machine, compare those files with
the repository versions before restowing them.

## Homebrew

The committed `Brewfile` intentionally records selected tools and applications,
not every Homebrew dependency or every GUI application installed on the Mac.

Use the helper to install a package and append it to the committed file:

```bash
brew-install bat
brew-install --cask ghostty
brew-install --tap owner/tap
```

The helper only adds entries. Removing a package with Homebrew does not remove
its line from the `Brewfile`.

Check whether the current machine satisfies the committed manifest without
requiring upgrades:

```bash
brew bundle check --no-upgrade
```

Check Herdr, Homebrew, upstream, and skill versions:

```bash
update-herdr
update-herdr --diff
```

After finishing active Herdr work and stopping its server, update the Homebrew
package and synchronize the skill to the exact installed release:

```bash
update-herdr --apply
```

The updater refuses to change Herdr while its server is running because a
Homebrew upgrade cannot hand off the active server and stopping it terminates
its panes.

## Private and Machine-Local Configuration

The shell loads these files when present:

- `~/.config/environment/private.zsh`
- `~/.config/environment/splunk-token.zsh`

They are intentionally not tracked. Keep credentials and license material in
1Password rather than this repository or iCloud.

`refresh-splunk-token` reads an `op://` reference and creates local,
permission-restricted shell and Docker environment files. The generated files
must remain untracked.

## Included Utilities

| Command | Purpose |
| --- | --- |
| `brew-install` | Installs a Homebrew item and records it in the `Brewfile` |
| `update-herdr` | Checks or updates Herdr and its version-matched Copilot skill |
| `ws` | Creates, opens, lists, and removes managed Copilot worktrees |
| `ws-pick` | Opens the interactive worktree picker |
| `rubber-duck` | Starts the configured Copilot critic agent |
| `gh-reauth` | Reauthenticates GitHub CLI from a local token source |
| `refresh-splunk-token` | Generates local Splunk environment files from 1Password |
| `parse_debug` | Processes local debug output |

Raycast scripts provide shortcuts for opening repositories and worktrees,
asking Copilot, and searching GitHub.

## Work-Specific Configuration

The repository currently includes GitHub-specific Go module settings,
repository aliases, GitHub CLI commands, Copilot MCP servers, and worktree
conventions. These require GitHub network access and supporting credentials.

Do not copy work credentials, VPN profiles, tokens, or employer-owned licenses
into this repository or a personal iCloud folder.

## Updating Linked Files

Most managed files in the home directory are symbolic links into `home/`, so
editing either path changes the repository working copy. Review changes before
committing:

```bash
git status --short
git diff
```

Runtime cache and mise state beneath `home/` are ignored by both Git and Stow.
They are local artifacts, not configuration.
