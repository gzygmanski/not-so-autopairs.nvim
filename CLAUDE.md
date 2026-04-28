# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Neovim plugin (Lua). Semi-automatic autopairs: pair only inserted on double-tap of opening symbol (e.g. `{{` → `{}`). No build, lint, or test tooling — manual testing in Neovim only.

## Architecture

Two files, one runtime entry point.

- `plugin/init.lua` — auto-loaded by Neovim on startup, calls `require("not-so-autopairs").setup {}`. Always runs; no opt-in.
- `lua/not-so-autopairs.lua` — module `M`. `setup()` registers all insert-mode keymaps. `d_pairs` table is the single source of truth for supported pairs: `()`, `{}`, `[]`, `<>`, `''`, `""`, `` `` ``. Adding a pair = appending one entry there.

Keymap mechanics (all insert mode):
- `{{` style double-opening → inserts pair + `<left>` (per-pair, generated in `map_pairs`).
- `{<CR>` → opens block: newline, closing symbol below, cursor on indented middle line (per-pair, generated in `map_pairs`).
- `<BS>`, `<CR>`, `<Space>` are context-sensitive via `expr = true` — they call `is_within_empty_pair()` which inspects the 2 chars around cursor (`strpart(getline("."), col(".") - 2, 2)`) and matches against `d_pairs`. Inside an empty pair: BS deletes both sides, CR splits to new line, Space pads with two spaces and centers cursor.
- `<leader>a` — escape pair via `search()` regex jumping to next closing symbol on same line.

Because `is_within_empty_pair` keys off `d_pairs`, behavior of BS/CR/Space auto-extends when new pairs are added there.

## Manual test

Open Neovim with plugin on runtimepath, enter insert mode, exercise: `{{`, `{<CR>`, BS inside `{}`, Space inside `{}`, `<leader>a` to jump out. No automated harness exists.
