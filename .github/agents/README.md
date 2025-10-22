# Subagents

This directory contains custom subagent definitions for GitHub Copilot. Subagents are specialized AI assistants that can help with specific tasks related to this dotfiles repository.

## Available Subagents

### Dotfiles Curator

**File:** `dotfiles-curator.md`

**Description:** Expert dotfiles curator specializing in maintaining high-quality, cross-platform configuration files. Masters organization, security, best practices, and ensuring dotfiles remain modern, consistent, and well-documented across Linux and macOS environments.

**Use Cases:**
- Reviewing and improving shell configurations (.bashrc, .bash_profile)
- Optimizing Neovim/editor configurations
- Maintaining tmux and terminal multiplexer setups
- Ensuring Git configuration best practices
- Cross-platform compatibility checks (Linux/macOS)
- Security audits (checking for hardcoded secrets, proper permissions)
- Performance optimization of startup scripts
- Documentation and commenting improvements
- Installation script validation
- Modern tool adoption and recommendations

**When to Invoke:**
- When making changes to any configuration files
- Before adding new tools or dependencies
- When experiencing performance issues with shell or editor startup
- When setting up on a new machine or platform
- For security reviews of configuration files
- When refactoring or reorganizing dotfiles structure

**Example Invocations:**
```
@dotfiles-curator review my .bashrc for performance issues and best practices

@dotfiles-curator help me add XDG Base Directory compliance to my configs

@dotfiles-curator audit my dotfiles for security issues and hardcoded secrets

@dotfiles-curator suggest modern alternatives to my current tool configurations

@dotfiles-curator help ensure my Neovim config works on both Linux and macOS
```

## How Subagents Work

Subagents are markdown files with YAML frontmatter that define:
- **name**: The identifier for the subagent
- **description**: A brief description of the subagent's expertise

The body of the file contains the prompt/instructions that define the subagent's behavior, knowledge areas, and working style.

## Creating New Subagents

To create a new subagent:

1. Create a new `.md` file in this directory
2. Add YAML frontmatter with `name` and `description`
3. Write a comprehensive prompt defining the subagent's:
   - Expertise areas
   - Working methodology
   - Quality standards
   - Integration with other agents
   - Best practices and patterns

See `dotfiles-curator.md` as an example of a well-structured subagent definition.

## Best Practices

- Keep subagent definitions focused on specific domains
- Include comprehensive checklists and quality criteria
- Define clear working methodologies
- Specify integration points with other potential subagents
- Document common patterns and anti-patterns
- Keep descriptions updated as the repository evolves
