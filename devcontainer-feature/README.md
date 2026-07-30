# Auto Kill Terminal — Dev Container Feature

A [dev container feature](https://containers.dev/features) that automatically adds terminal management rules to your AI agent instruction files when the container is created.

## Status

The feature is **not published to a container registry yet**, so the
`ghcr.io/nirholas/auto-kill-terminal/...` reference below will fail to resolve
today. Until it is published, use one of the two working options:

1. The `postCreateCommand` one-liner (works right now, no registry needed):

```json
{
  "postCreateCommand": "curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --all"
}
```

2. A local feature: copy this `devcontainer-feature/` directory into your
   project as `.devcontainer/auto-kill-terminal/` and reference it by path:

```json
{
  "features": {
    "./auto-kill-terminal": {}
  }
}
```

## Usage (once published)

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

Feature install scripts run while the image is built, before your workspace
folder is mounted, so `install.sh` cannot edit the project files directly. It
installs `/usr/local/share/auto-kill-terminal/apply.sh` and records the `agents`
option. The feature's `postCreateCommand` then runs `apply.sh` inside the
workspace folder once the container exists, which:

1. Checks if agent instruction files already exist
2. If they exist, appends the terminal management rules (unless already present)
3. If they don't exist, creates them with the rules

Re-running is safe: files that already contain the rules are left untouched.

Files created/updated depend on the `agents` option:
- `all`: `.github/copilot-instructions.md`, `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `.cursorrules`
- `copilot`: `.github/copilot-instructions.md`
- `claude`: `CLAUDE.md`
- `gemini`: `GEMINI.md`
- `cursor`: `.cursorrules`

