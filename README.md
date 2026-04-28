# not-so-autopairs.nvim

Simple semi-automatic autopairs plugin.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "gzygmanski/not-so-autopairs.nvim" }
```

## Supported pairs

`()`, `{}`, `[]`, `<>`, `''`, `""`, `` ` ` ``

## Usage

Double-tap an opening symbol in insert mode to insert a pair, e.g. `{{` → `{|}`.

- `<leader>a` — escape pair (jump past closing symbol)
- `<BS>` — when inside an empty pair, removes both opening and closing symbols
- `<CR>` — after an opening symbol, splits to next line and adds closing symbol below
- `<Space>` — when inside an empty pair, adds an extra space and centers the cursor
- Triple-tap `` ` `` — opens a fenced code block; cursor returns to the opener so a language tag can be typed

## Reasoning

Sometimes I need only the opening bracket and my brain refuses to memorize a key bind for that purpose. I always ended up struggling to remove the auto-inserted closing symbol — which cost more time than it saved.
