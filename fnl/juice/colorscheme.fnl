(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(comment "Set italic in graphical terminals")
(local is-gui (not= vim.env.WAYLAND_DISPLAY nil))

(local general {:Comment {:fg :DarkYellow :ctermfg :DarkYellow :italic is-gui}
                :Constant {:fg :Green}
                :CursorLine {:bg :NONE}
                [:Delimiter :Operator :Special :Statement] {:fg :Gray}
                [:LineNrAbove :LineNrBelow] {:fg :Gray}
                :NonText {:fg :Black}
                :Normal {:bg :NONE}
                :SpellBad {:fg :NvimLightRed :undercurl true}
                :Title {:fg :DarkCyan :bold true}
                :Todo {:fg :Yellow :bold true}
                :Visual {:reverse true}
                :WinSeparator {:fg :Gray}})

(local diagnostic-virtual-text
       {:DiagnosticVirtualTextError {:fg :DarkRed :italic is-gui}
        :DiagnosticVirtualTextHint {:fg :DarkBlue :italic is-gui}
        :DiagnosticVirtualTextInfo {:fg :DarkCyan :italic is-gui}
        :DiagnosticVirtualTextOk {:fg :DarkGreen :italic is-gui}
        :DiagnosticVirtualTextWarn {:fg :DarkYellow :italic is-gui}
        :LspInlayHint {:fg :Gray :italic is-gui}})

(local statusline {:StatusLine {:fg :Gray :bg :NONE}
                   :StatusLineError {:fg :DarkRed}
                   :StatusLineInfo {:fg :DarkCyan}
                   :StatusLineWarn {:fg :DarkYellow}})

(lambda set-hl [hi-options]
  "Helper function to set multiple highlight groups using a table"
  (each [hi-group opts (pairs hi-options)]
    (if (core.sequential? hi-group)
        (each [_ sub-group (ipairs hi-group)]
          (vim.api.nvim_set_hl 0 sub-group opts))
        (core.string? hi-group)
        (vim.api.nvim_set_hl 0 hi-group opts))))

{:setup (fn []
          (vim.cmd.colorscheme :default)
          (core.map set-hl [general diagnostic-virtual-text statusline]))}
