# Auto Kill Terminal — Dev Container Feature

A [dev container feature](https://containers.dev/features) that automatically adds terminal management rules to your AI agent instruction files when the container is created.

## Usage

Add to your `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/nirholas/auto-kill-terminal/auto-kill-terminal:1": {}
  }
}
```

### Options

| Option | Default | Description |
|---|---|---|
| `agents` | `"all"` | Which agent files to create. Options: `all`, `copilot`, `claude`, `gemini`, `cursor` |

### Examples

All agents (default):
```json
{
  "features": {
    "ghcr.io/nirholas/auto-kill-terminal/auto-kill-terminal:1": {}
  }
}
```

Copilot only:
```json
{
  "features": {
    "ghcr.io/nirholas/auto-kill-terminal/auto-kill-terminal:1": {
      "agents": "copilot"
    }
  }
}
```

## What it does

When the dev container is created, this feature:
1. Checks if agent instruction files already exist
2. If they exist, appends the terminal management rules (unless already present)
3. If they don't exist, creates them with the rules

Files created/updated depend on the `agents` option:
- `all`: `.github/copilot-instructions.md`, `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `.cursorrules`
- `copilot`: `.github/copilot-instructions.md`
- `claude`: `CLAUDE.md`
- `gemini`: `GEMINI.md`
- `cursor`: `.cursorrules`

