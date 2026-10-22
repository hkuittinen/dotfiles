# Codex

Keep the active config as a local copy. Codex stores project trust decisions and
local paths there.

For a new installation (preserves an existing config):

```sh
mkdir -p ~/.codex
cp -n ~/projects/dotfiles/codex/config.toml ~/.codex/config.toml
```

Apply later preference changes to both files manually. Keep `[projects."..."]`
entries only in `~/.codex/config.toml`.
