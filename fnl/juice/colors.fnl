(module colors
  {import-macros [[ac :aniseed.macros.autocmds]]})

(defn- color-attr [hl-group attribute]
  "Extract an attribute from an existing highlight group"
  (. (vim.api.nvim_get_hl 0 {:name hl-group}) attribute))

(def- custom-colors {:normal-bg (color-attr :Normal :bg)
                     :normal-fg (color-attr :Normal :fg)
                     :error-fg (color-attr :DiagnosticError :fg)
                     :warn-fg (color-attr :DiagnosticWarn :fg)
                     :statusline-bg (color-attr :StatusLine :bg)
                     :bright-yellow :#eeee00
                     :dark-gray :#3d3d3d
                     :dark-green :#009000
                     :light-gray :#707070
                     })

(local c custom-colors)
(def- groups {:Comment {:fg c.light-gray :style :italic}
              :Conceal {:link :Comment}
              :CursorLine {:bg c.normal-bg}
              :CursorLineNr {:fg c.normal-fg :bg c.normal-bg}
              :DiagnosticVirtualTextError {:fg c.error-fg :style :italic}
              :DiagnosticVirtualTextWarn {:fg c.warn-fg :style :italic}
              :ExtraWhitespace {:fg c.error-fg :undercurl true}
              :LineNr {:fg c.dark-gray :bg c.cursor-bg}
              :LineNrAbove {:fg c.dark-gray :bg c.normal-bg}
              :LineNrBelow {:fg c.dark-gray :bg c.normal-bg}
              :MsgArea {:fg c.light-gray}
              :SpellBad {:fg c.warn-fg :style :undercurl}
              :StatusLine {:fg c.light-gray :bg c.normal-bg}
              :StatusLineError {:fg c.error-fg :bg c.statusline-bg}
              :StatusLineWarn {:fg c.warn-fg :bg c.statusline-bg}
              :Todo {:fg c.bright-yellow}
              :WinSeparator {:fg c.dark-green :bg c.normal-bg}
              })

(defn show-extra-whitespace []
  (vim.api.nvim_set_hl 0 :ExtraWhitespace groups.ExtraWhitespace))

(defn setup []
  (let [theme (require :github-theme)
        options {:transparent true}]
    (theme.setup {: options :groups {:all groups}})
    (set vim.opt.termguicolors true)
    (set vim.opt.background "dark")
    (vim.cmd "colorscheme github_dark")))
