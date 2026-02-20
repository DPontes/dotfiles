-- markdown.lua — Markdown Renderer
-- Renders markdown inline in Neovim buffers — styled checkboxes, headings, etc.
-- Checkbox rendering: ✘ unchecked, ✔ checked (with strikethrough), ◯ todo.
-- No keymaps — activates automatically when viewing .md files.
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', { 'echasnovski/mini.icons', version = '*' } },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require('mini.icons').setup()
      require('render-markdown').setup({
        checkbox = {
          unchecked = { icon = '✘ ' },
          checked = { icon = '✔ ', scope_highlight = '@markup.strikethrough' },
          custom = { todo = { rendered = '◯ ' } },
        },
        indent = {
          enabled = false,
          per_level = 2,
          skip_level = 1,
          skip_heading = true,
        },
      })
    end
  }
}
