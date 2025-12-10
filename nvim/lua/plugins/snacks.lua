return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = "cmatrix -u 7",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    picker = {
      enabled = true,
      formatters = {
        file = {
          truncate = 80, -- truncate the file path to (roughly) this length
        },
      },
    },
    scratch = {
      ft = "markdown",
      filekey = {
        cwd = true, -- use current working directory
        branch = false, -- use current branch name
        count = true, -- use vim.v.count1
      },
    },
  },
  keys = {
    {
      "<leader>sf",
      function()
        -- Wrapper to add Python path support directly in the picker
        local original_pick = require("snacks.picker").pick
        local picker

        -- Temporarily override the pick function to hook into the input
        require("snacks.picker").pick = function(...)
          picker = original_pick(...)

          if picker and picker.input then
            -- Store the original get method
            local original_get = picker.input.get

            -- Override to transform Python paths to file paths
            picker.input.get = function(self)
              local text = original_get(self)

              -- If text contains dots but no slashes, convert to file path
              if text and text:match("%.") and not text:match("/") and not text:match("%s") then
                return text:gsub("%.", "/")
              end

              return text
            end
          end

          return picker
        end

        -- Call smart picker with enhanced options
        Snacks.picker.smart({
          hidden = false, -- Set to true to include hidden files (like .env, .gitignore)
          ignored = false, -- Set to true to include files ignored by .gitignore
          follow = true, -- Follow symlinks
          cwd_bonus = true,
        })

        -- Restore original pick function
        require("snacks.picker").pick = original_pick
      end,
      desc = "[S]earch [F]iles (type dots for Python)",
    },
  },
}
