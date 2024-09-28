(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local str (autoload :nfnl.string))

(local cterm-opts {:Comment {:ctermfg :DarkGray :italic true}
                   :Constant {:ctermfg :Green}
                   :CursorLineNr {:ctermfg :White}
                   [:Delimiter :Operator :Special :Statement] {:ctermfg :Gray}
                   [:LineNrAbove :LineNrBelow] {:ctermfg :DarkGray}
                   [:NonText :WinSeparator] {:ctermfg :Black}
                   :Title {:ctermfg :DarkCyan :bold true}
                   :Todo {:ctermfg :Yellow :bold true}})

(local diagnostic-virtual-text
       {:DiagnosticVirtualTextError {:ctermfg :DarkRed :italic true}
        :DiagnosticVirtualTextHint {:ctermfg :DarkBlue :italic true}
        :DiagnosticVirtualTextInfo {:ctermfg :DarkCyan :italic true}
        :DiagnosticVirtualTextOk {:ctermfg :DarkGreen :italic true}
        :DiagnosticVirtualTextWarn {:ctermfg :DarkYellow :italic true}})

(local statusline {:StatusLine {:ctermfg :DarkGray :ctermbg :NONE}
                   :StatusLineError {:ctermfg :DarkRed}
                   :StatusLineInfo {:ctermfg :DarkCyan}
                   :StatusLineWarn {:ctermfg :DarkYellow}})

(local telescope {:TelescopeSelection {:ctermfg :White}
                  :TelescopeNormal {:ctermfg :Gray}})

(lambda set-hl [hi-options]
  (each [hi-group opts (pairs hi-options)]
    (if (core.sequential? hi-group)
        (each [_ sub-group (ipairs hi-group)]
          (vim.api.nvim_set_hl 0 sub-group opts))
        (core.string? hi-group)
        (vim.api.nvim_set_hl 0 hi-group opts))))

(fn setup []
  (vim.cmd.colorscheme :default)
  (vim.cmd "set notermguicolors")
  (core.map set-hl [cterm-opts diagnostic-virtual-text statusline telescope]))

{: setup}
