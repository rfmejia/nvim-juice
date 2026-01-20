(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(comment "Set italic in graphical terminals")
(local in-gui? (not= vim.env.WAYLAND_DISPLAY nil))

(local general {:Comment {:fg :DarkYellow :ctermfg :DarkYellow :italic in-gui?}
                :Constant {:fg :Green}
                :CursorLine {:bg :NONE}
                [:Delimiter :Operator :Special :Statement] {:fg :Gray}
                [:LineNrAbove :LineNrBelow] {:fg :Gray}
                :NonText {:fg :Black}
                :Normal {:link :Normal}
                :NormalFloat {:link :Normal}
                :FloatBorder {:fg :DarkYellow}
                :SpellBad {:fg :NvimLightRed :undercurl true}
                :Title {:fg :DarkCyan :bold true}
                :Todo {:fg :Yellow :bold true}
                :Visual {:reverse true}
                :WinSeparator {:fg :Gray}})

(local diagnostic-virtual-text
       {:DiagnosticVirtualTextError {:fg :DarkRed :italic in-gui?}
        :DiagnosticVirtualTextHint {:fg :DarkBlue :italic in-gui?}
        :DiagnosticVirtualTextInfo {:fg :DarkCyan :italic in-gui?}
        :DiagnosticVirtualTextOk {:fg :DarkGreen :italic in-gui?}
        :DiagnosticVirtualTextWarn {:fg :DarkYellow :italic in-gui?}
        :LspInlayHint {:fg :Gray :italic in-gui?}})

(local statusline {:StatusLine {:fg :Gray :bg :NONE}
                   :StatusLineError {:fg :DarkRed}
                   :StatusLineInfo {:fg :DarkCyan}
                   :StatusLineWarn {:fg :DarkYellow}})

(lambda set-hl [hi-options]
  "Helper function to set multiple highlight groups using a table"
  (each [group settings (pairs hi-options)]
    (if (core.sequential? group)
        (each [_ sub-group (ipairs group)]
          (vim.api.nvim_set_hl 0 sub-group settings))
        (core.string? group)
        (vim.api.nvim_set_hl 0 group settings))))

(core.map set-hl [general diagnostic-virtual-text statusline])
(set vim.g.colors_name :default-black)
