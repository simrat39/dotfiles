---@diagnostic disable: missing-parameter, param-type-mismatch
local M = {}
M._state = { commands = nil }

local function execute_rust_analyzer_command(action, ctx)
  local fn = vim.lsp.commands[action.command]
  if fn then
    fn(action, ctx)
  end
end

-- run the command under the cursor, if the thing under the cursor is not the
-- command then do nothing
local function run_command(ctx)
  local winnr = vim.api.nvim_get_current_win()
  local line = vim.api.nvim_win_get_cursor(winnr)[1]

  if line > #M._state.commands then
    return
  end

  local action = M._state.commands[line]

  vim.api.nvim_win_close(winnr, true)
  execute_rust_analyzer_command(action, ctx)
end

local function parse_commands()
  local prompt = {}

  for i, value in ipairs(M._state.commands) do
    if value.command == "rust-analyzer.gotoLocation" then
      table.insert(
        prompt,
        string.format("%d. Go to %s (%s)", i, value.title, value.tooltip)
      )
    elseif value.command == "rust-analyzer.showReferences" then
      table.insert(prompt, string.format("%d. %s", i, "Go to " .. value.title))
    else
      table.insert(prompt, string.format("%d. %s", i, value.title))
    end
  end

  return prompt
end

require("hover").register({
  name = "Rust Hover Actions",
  enabled = function()
    return true
  end,
  execute = function(done)
    local util = require("vim.lsp.util")
    local params = util.make_position_params()
    vim.lsp.buf_request(
      0,
      "textDocument/hover",
      params,
      function(_, result, ctx)
        if not result or not result.contents then
          done()
          return
        end

        M._state.commands = nil

        local lines = util.convert_input_to_markdown_lines(result.contents)
        if result.actions then
          M._state.commands = result.actions[1].commands
          local prompt = parse_commands()
          local l = {}

          for _, value in ipairs(prompt) do
            table.insert(l, value)
          end

          lines = vim.list_extend(l, lines)
        end

        lines = util.trim_empty_lines(lines)

        M._state.ctx = ctx

        if vim.tbl_isempty(lines) then
          done()
          return
        end

        done({ lines = lines, filetype = "markdown" })
      end
    )
  end,
  on_render = function(bufnr, winnr)
    if M._state.commands == nil then
      return
    end
    -- makes more sense in a dropdown-ish ui
    vim.api.nvim_win_set_option(winnr, "cursorline", true)

    -- run the command under the cursor
    vim.keymap.set("n", "<CR>", function()
      run_command(M._state.ctx)
    end, { buffer = bufnr, noremap = true, silent = true })
  end,
})

return M
