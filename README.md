# not-so-autopairs.nvim

Simple semi-automatic autopairs plugin

## Installation

Using Lazy:

```
"gzygmanski/not-so-autopairs.nvim"
    
```

## Usage

To use double tap opening symbol in insert mode, e.g. `{{`

- `<leader>a`: escape pair
- `<BS>`: when inside pair, removes also closing symbol
- `<CR>`: after opening symbol, moves to next line and adds closing symbol below (needs only opening symbol)
- `<Space>`: when inside pair, adds additional space after cursor

## Reasoning

Sometimes I need only opening bracket and my brain for some reason is unable to memorize key bind for that purpose. I always end up struggling to remove automatically added closing symbols (which in turn cost more time that it saves).

Ironically I end up with a problem when I want just spam opening symbols, so that is something I need to resolve in the future.
