(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local str (autoload :nfnl.string))

(local general {:Comment {:fg :Gray :ctermfg :Gray :italic true}
                :Constant {:fg :Green}
                :CursorLine {:bg :NONE}
                [:Delimiter :Operator :Special :Statement] {:fg :Gray}
                [:LineNrAbove :LineNrBelow] {:fg :Gray}
                :NonText {:fg :Black}
                :Normal {:bg :NONE}
                :Title {:fg :DarkCyan :bold true}
                :Todo {:fg :Yellow :bold true}
                :WinSeparator {:fg :Gray}})

(local diagnostic-virtual-text
       {:DiagnosticVirtualTextError {:fg :DarkRed :italic true}
        :DiagnosticVirtualTextHint {:fg :DarkBlue :italic true}
        :DiagnosticVirtualTextInfo {:fg :DarkCyan :italic true}
        :DiagnosticVirtualTextOk {:fg :DarkGreen :italic true}
        :DiagnosticVirtualTextWarn {:fg :DarkYellow :italic true}})

(local statusline {:StatusLine {:fg :Gray :bg :NONE}
                   :StatusLineError {:fg :DarkRed}
                   :StatusLineInfo {:fg :DarkCyan}
                   :StatusLineWarn {:fg :DarkYellow}})

(local telescope {:TelescopeSelection {:fg :White}
                  :TelescopeNormal {:fg :Gray}})

(lambda set-hl [hi-options]
  (each [hi-group opts (pairs hi-options)]
    (if (core.sequential? hi-group)
        (each [_ sub-group (ipairs hi-group)]
          (vim.api.nvim_set_hl 0 sub-group opts))
        (core.string? hi-group)
        (vim.api.nvim_set_hl 0 hi-group opts))))

(fn setup []
  (vim.cmd.colorscheme :default)
  (core.map set-hl [general diagnostic-virtual-text statusline telescope]))

{: setup}
