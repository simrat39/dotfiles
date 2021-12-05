local vi_mode_provider = require("feline.providers.vi_mode")
local git_provider = require("feline.providers.git")
local lsp_provider = require("feline.providers.lsp")

local dracula = {
  background = "#1E1F29",
  current_line = "#282a36",
  selection = "#282a36",
  foreground = "#f8f8f2",
  comment = "#6272a4",
  cyan = "#8be9fd",
  green = "#50fa7b",
  orange = "#ffb86c",
  pink = "#ff79c6",
  purple = "#bd93f9",
  red = "#ff5555",
  yellow = "#f1fa8c",
}

local components = {
  inactive = {},
  active = {
    -- left
    -- vi mode
    {
      {
        provider = function()
          return " " .. (vi_mode_provider.get_vim_mode() or "term") .. " "
        end,
        left_sep = {
          str = "",
          hl = function()
            return {
              name = vi_mode_provider.get_mode_highlight_name(),
              fg = dracula.selection,
            }
          end,
        },
        right_sep = {
          str = "",
          hl = function()
            return {
              name = vi_mode_provider.get_mode_highlight_name(),
              fg = dracula.selection,
            }
          end,
        },
        hl = function()
          return {
            fg = vi_mode_provider.get_mode_color(),
            bg = dracula.selection,
            style = "bold",
          }
        end,
      },

      -- folder name
      {
        left_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        right_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.yellow,
          style = "bold",
        },
        provider = function()
          local name = vim.fn.getcwd()
          return string.format(" %s %s ", "", vim.fn.fnamemodify(name, ":t"))
        end,
      },

      -- file name
      {
        left_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        right_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.red,
          style = "bold",
        },
        enabled = function()
          local name = vim.api.nvim_buf_get_name(0)
          return name and name ~= ""
        end,
        provider = function()
          local name = vim.api.nvim_buf_get_name(0)
          local ext = vim.fn.fnamemodify(name, ":e")
          local icon_str = require("nvim-web-devicons").get_icon_color(
            name,
            ext,
            { default = true }
          )
          return string.format(
            " %s %s ",
            icon_str,
            vim.fn.fnamemodify(name, ":t")
          )
        end,
      },
    },

    -- middle
    {
      -- git branch
      {
        left_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        right_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.pink,
          style = "bold",
        },
        enabled = git_provider.git_info_exists,
        provider = function()
          local branch, icon = git_provider.git_branch()
          return string.format(" %s%s ", icon, branch)
        end,
      },

      -- git changed
      {
        left_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.cyan,
          style = "bold",
        },
        enabled = git_provider.git_info_exists,
        provider = function()
          local changed, icon = git_provider.git_diff_changed()
          if changed == "" then
            changed = 0
          end
          return string.format("%s%s", icon, changed)
        end,
      },

      -- git added
      {
        hl = {
          bg = dracula.selection,
          fg = dracula.green,
          style = "bold",
        },
        enabled = git_provider.git_info_exists,
        provider = function()
          local added, icon = git_provider.git_diff_added()
          if added == "" then
            added = 0
          end
          return string.format("%s%s", icon, added)
        end,
      },

      -- git removed
      {
        right_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.orange,
          style = "bold",
        },
        enabled = git_provider.git_info_exists,
        provider = function()
          local removed, icon = git_provider.git_diff_removed()
          if removed == "" then
            removed = 0
          end
          return string.format("%s%s ", icon, removed)
        end,
      },
    },

    -- right
    {

      -- lsp errors
      {
        left_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.red,
          style = "bold",
        },
        enabled = lsp_provider.is_lsp_attached,
        provider = function()
          local errors, icon = lsp_provider.diagnostic_errors()
          if errors == "" then
            errors = "0"
          end
          return string.format("%s%s", icon, errors)
        end,
      },

      -- lsp warnings
      {
        hl = {
          bg = dracula.selection,
          fg = dracula.orange,
          style = "bold",
        },
        enabled = lsp_provider.is_lsp_attached,
        provider = function()
          local warnings, icon = lsp_provider.diagnostic_warnings()
          if warnings == "" then
            warnings = "0"
          end
          return string.format("%s%s", icon, warnings)
        end,
      },

      -- lsp info
      {
        hl = {
          bg = dracula.selection,
          fg = dracula.foreground,
          style = "bold",
        },
        enabled = lsp_provider.is_lsp_attached,
        provider = function()
          local info, icon = lsp_provider.diagnostic_info()
          if info == "" then
            info = "0"
          end
          return string.format("%s%s", icon, info)
        end,
      },

      -- lsp hints
      {
        right_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.cyan,
          style = "bold",
        },
        enabled = lsp_provider.is_lsp_attached,
        provider = function()
          local hints, icon = lsp_provider.diagnostic_hints()
          if hints == "" then
            hints = "0"
          end
          return string.format("%s%s ", icon, hints)
        end,
      },

      -- language server names
      {
        left_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        right_sep = {
          str = "",
          hl = {
            fg = dracula.selection,
          },
        },
        hl = {
          bg = dracula.selection,
          fg = dracula.foreground,
          style = "bold",
        },
        enabled = lsp_provider.is_lsp_attached,
        provider = function()
          local names, icon = lsp_provider.lsp_client_names()
          return string.format(" %s%s ", icon, names)
        end,
      },
    },
  },
}

local disabled = { "NvimTree", "Outline" }

R("feline").setup({
  components = components,
  theme = {
    fg = dracula.foreground,
    cyan = dracula.cyan,
    green = dracula.green,
    orange = dracula.orange,
    red = dracula.red,
    magenta = dracula.pink,
    violet = dracula.violet,
    yellow = dracula.yellow,
  },
  force_inactive = { filetypes = disabled },
})

vim.cmd(string.format("hi StatusLineNC guibg=%s", dracula.background))
vim.cmd(
  string.format(
    "hi NvimTreeStatusLine guibg=%s guifg=%s",
    dracula.background,
    dracula.background
  )
)
vim.cmd(string.format("hi NvimTreeStatusLineNC guibg=%s", dracula.background))
