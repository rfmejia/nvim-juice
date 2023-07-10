(module colors
  {import-macros [[ac :aniseed.macros.autocmds]]})

(set vim.opt.termguicolors true)
(set vim.opt.background "dark")

; (vim.cmd "hi CursorLine cterm=NONE ctermbg=234 guibg=#1c1c1c")
; (vim.cmd "hi StatusLine ctermbg=NONE ctermfg=white guibg=NONE guifg=white")

; Note: make sure this is defined before the colorscheme is first set
(ac.augroup :colorscheme-group
            [:ColorScheme {:pattern "*"
                           :callback (fn []
                                       (when (= vim.o.background "dark")
                                         (vim.api.nvim_set_hl 0 "Normal" {:bg "black"})
                                         (vim.api.nvim_set_hl 0 "MsgArea" {:fg "#909090"})
                                         (vim.api.nvim_set_hl 0 "CursorLine" {:bg "#0c0c0f"})
                                         (vim.api.nvim_set_hl 0 "MatchParen" {:fg "black" :bg "yellow"})
                                         (vim.api.nvim_set_hl 0 "StatusLine" {:fg "#909090" :bg "black"})
                                         (vim.api.nvim_set_hl 0 "VertSplit" {:fg "black"})
                                         (vim.api.nvim_set_hl 0 "Todo" {:fg "yellow"}))
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

