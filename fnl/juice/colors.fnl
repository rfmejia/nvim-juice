(module colors
  {import-macros [[ac :aniseed.macros.autocmds]]})

(set vim.opt.termguicolors true)
(set vim.opt.background "dark")

(defn- color-attr [hl-group attribute]
  "Extract an attribute from an existing highlight group"
  (. (vim.api.nvim_get_hl 0 {:name hl-group}) attribute))

(def custom-colors {:default-bg :none
                    :linenr-fg :#3d3d3d
                    :linenr-bg :none
                    :cursor-fg :#ffffff
                    :cursor-bg :none
                    :spell-bad :#bb4466
                    :conceal-fg :#707070
                    :conceal-bg :none
                    :winsep-fg :#009000
                    :winsep-bg :none
                    :statusline-fg :#909090
                    :statusline-bg (color-attr :StatusLine :bg)
                    :statusline-error-fg (color-attr :DiagnosticError :fg)
                    :statusline-warn-fg (color-attr :DiagnosticWarn :fg)
                    })

; Note: make sure this is defined before the colorscheme is first set
(ac.augroup :colorscheme-group
            [:ColorScheme {:pattern "*"
                           :callback (fn []
                                       (when (= vim.o.background "dark")
                                         (local c custom-colors)
                                         (vim.api.nvim_set_hl 0 :Normal {:bg c.default-bg})
                                         (vim.api.nvim_set_hl 0 :NormalNC {:bg c.default-bg})
                                         (vim.api.nvim_set_hl 0 :NonText {:bg c.default-bg})
                                         (vim.api.nvim_set_hl 0 :MsgArea {:fg :#909090})
                                         (vim.api.nvim_set_hl 0 :CursorLine {:bg c.cursor-bg})
                                         (vim.api.nvim_set_hl 0 :MatchParen {:bg :blue})
                                         (vim.api.nvim_set_hl 0 :StatusLine {:fg c.statusline-fg :bg c.default-bg})
                                         (vim.api.nvim_set_hl 0 :VertSplit {:fg c.default-bg})
                                         (vim.api.nvim_set_hl 0 :Todo {:fg :yellow})

                                         (vim.api.nvim_set_hl 0 :CursorLineNr {:fg c.cursor-fg :bg c.cursor-bg})
                                         (vim.api.nvim_set_hl 0 :LineNr {:fg c.linenr-fg :bg c.cursor-bg})
                                         (vim.api.nvim_set_hl 0 :LineNrAbove {:fg c.linenr-fg :bg c.linenr-bg})
                                         (vim.api.nvim_set_hl 0 :LineNrBelow {:fg c.linenr-fg :bg c.linenr-bg})

                                         (vim.api.nvim_set_hl 0 :SpellBad {:fg c.spell-bad :undercurl true})

                                         (vim.api.nvim_set_hl 0 :Conceal {:fg c.conceal-fg :bg c.conceal-bg :italic true})
                                         (vim.api.nvim_set_hl 0 :WinSeparator {:fg c.winsep-fg :bg c.winsep-bg})
                                         )
                                       )}]

            ; Add special highlight groups for diagnostic counts on the statusline
            [:ColorScheme {:pattern :*
                           :callback (fn []
                                       (local c custom-colors)
                                       (vim.api.nvim_set_hl 0 :StatusLineError {:fg c.statusline-error-fg :bg c.statusline-bg})
                                       (vim.api.nvim_set_hl 0 :StatusLineWarn {:fg c.statusline-warn-fg :bg c.statusline-bg}))
                           }])

