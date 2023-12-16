(module colors
  {import-macros [[ac :aniseed.macros.autocmds]]})

(set vim.opt.termguicolors true)
(set vim.opt.background "dark")

(def custom-colors {:default-bg :black
                    :linenr-fg "#3d3d3d"
                    :linenr-bg "#000000"
                    :cursor-fg "#ffffff"
                    :cursor-bg "#000000"
                    :spell-bad "#bb4466"
                    })

; Note: make sure this is defined before the colorscheme is first set
(ac.augroup :colorscheme-group
            [:ColorScheme {:pattern "*"
                           :callback (fn []
                                       (when (= vim.o.background "dark")
                                         (local c custom-colors)
                                         (vim.api.nvim_set_hl 0 "Normal" {:bg c.default-bg})
                                         (vim.api.nvim_set_hl 0 "MsgArea" {:fg "#909090"})
                                         (vim.api.nvim_set_hl 0 "CursorLine" {:bg c.cursor-bg})
                                         (vim.api.nvim_set_hl 0 "MatchParen" {:bg "blue"})
                                         (vim.api.nvim_set_hl 0 "StatusLine" {:fg "#909090" :bg c.default-bg})
                                         (vim.api.nvim_set_hl 0 "VertSplit" {:fg c.default-bg})
                                         (vim.api.nvim_set_hl 0 "Todo" {:fg "yellow"})

                                         (vim.api.nvim_set_hl 0 "CursorLineNr" {:fg c.cursor-fg :bg c.cursor-bg})
                                         (vim.api.nvim_set_hl 0 "LineNr" {:fg c.linenr-fg :bg c.cursor-bg})
                                         (vim.api.nvim_set_hl 0 "LineNrAbove" {:fg c.linenr-fg :bg c.linenr-bg})
                                         (vim.api.nvim_set_hl 0 "LineNrBelow" {:fg c.linenr-fg :bg c.linenr-bg})

                                         (vim.api.nvim_set_hl 0 "SpellBad" {:fg c.spell-bad :undercurl true})
                                         )
                                       )}]

            ; Add special highlight groups for diagnostic counts on the statusline
            [:ColorScheme {:pattern "*"
                           :callback (fn []
                                       (let [color-attr (lambda [hl-group attr]
                                                          (. (vim.api.nvim_get_hl 0 {:name hl-group}) attr))
                                             error-fg (color-attr "DiagnosticError" "fg")
                                             warn-fg (color-attr "DiagnosticWarn" "fg")
                                             statusline-bg (color-attr "StatusLine" "bg")]
                                         (vim.api.nvim_set_hl 0 "StatusLineError" {:fg error-fg :bg statusline-bg})
                                         (vim.api.nvim_set_hl 0 "StatusLineWarn" {:fg warn-fg :bg statusline-bg})))
                           }])

