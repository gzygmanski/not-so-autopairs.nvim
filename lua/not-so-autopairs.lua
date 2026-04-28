local M = {}

local d_pairs = { "()", "{}", "[]", "<>", "''", '""', "``" }

M.is_empty_pair = function(str)
  for _, val in ipairs(d_pairs) do
    if str == val then
      return 1
    end
  end
end

M.is_within_empty_pair = function()
  local current = vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 2, 2)
  return M.is_empty_pair(current)
end

M.handle_backtick = function()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  local prev_char = vim.fn.strpart(line, col - 2, 1)
  local next_char = vim.fn.strpart(line, col - 1, 1)

  if prev_char == "`" and next_char == "`" then
    return "``<CR>``<esc>kA"
  elseif prev_char == "`" then
    return "`<left>"
  end
  return "`"
end

local map_pairs = function()
  for _, val in ipairs(d_pairs) do
    if val ~= "``" then
      local left = string.sub(val, 1, 1)
      local right = string.sub(val, 2, 2)

      vim.keymap.set(
        { "i", "s" },
        string.rep(left, 2),
        val .. "<left>",
        { noremap = true, silent = true }
      )

      vim.keymap.set(
        { "i", "s" },
        left .. "<CR>",
        left .. "<CR>" .. right .. "<esc>ko",
        { noremap = true, silent = true }
      )
    end
  end
end

M.setup = function()
  map_pairs()

  -- backtick: context-aware (literal | autopair | fence)
  vim.keymap.set({ "i", "s" }, "`", function()
    return require("not-so-autopairs").handle_backtick()
  end, { expr = true, replace_keycodes = true, noremap = true, silent = true })

  -- escape pair
  vim.keymap.set(
    "i",
    "<leader>a",
    '<left><CMD>call search("\\\\%" . line(".") . "l\\\\()\\\\|}\\\\|]\\\\|>\\\\|\'\\\\|\\"\\\\|`\\\\)", "We")<CR><right>',
    { noremap = true, silent = true }
  )

  -- remove pair
  vim.keymap.set(
    "i",
    "<BS>",
    "v:lua.require('not-so-autopairs').is_within_empty_pair() ? '<C-o>a<C-H><C-H>' : '<C-H>'",
    { expr = true, noremap = true, silent = true }
  )

  -- move to next line
  vim.keymap.set(
    "i",
    "<CR>",
    "v:lua.require('not-so-autopairs').is_within_empty_pair() ? '<CR><C-o>O<Tab>' : '<CR>'",
    { expr = true, noremap = true, silent = true }
  )

  -- make space inside
  vim.keymap.set(
    "i",
    "<Space>",
    "v:lua.require('not-so-autopairs').is_within_empty_pair() ? '<Space><Space><C-o>h' : '<Space>'",
    { expr = true, noremap = true, silent = true }
  )
end

return M
