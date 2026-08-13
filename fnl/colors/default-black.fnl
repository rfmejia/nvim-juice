(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local colors (autoload :juice.colors))

(comment "Set italic in graphical terminals")
(local in-gui? (not= vim.env.WAYLAND_DISPLAY nil))

(local base {:StatusLineError {:fg :DarkRed}
             :StatusLineInfo {:fg :DarkCyan}
             :StatusLineWarn {:fg :DarkYellow}
             :Title {:fg :DarkCyan :bold true}})

(local flags {:Todo :bold
              :Comment :italic
              :DiagnosticVirtualTextError [:bold :italic]
              :DiagnosticVirtualTextHint :italic
              :DiagnosticVirtualTextInfo :italic
              :DiagnosticVirtualTextOk :italic
              :DiagnosticVirtualTextWarn :italic
              :LspInlayHint :italic})

(local cleared-bg-groups [:Normal :NormalFloat :CursorLine :Pmenu :StatusLine])

(fn compute-hl-groups []
  (let [hl-with-opts (icollect [k v (pairs flags)]
                       (colors.hl-with-opt k v))
        cleared-opts (core.map #{$ {:bg :NONE :force true}} cleared-bg-groups)
        all-opts (core.concat hl-with-opts cleared-opts)]
    (core.merge! base (table.unpack all-opts))))

(vim.cmd.colorscheme :default)
(colors.set-hl (compute-hl-groups))
(set vim.g.colors_name :default-black)

;; (local general {:Comment {:fg :Gray :ctermfg :DarkYellow :italic in-gui?}
;;                 :Constant {:fg :Green}
;;                 :CursorLine {:bg :NONE}
;;                 [:Delimiter :Operator :Special :Statement] {:fg :Gray}
;;                 [:LineNrAbove :LineNrBelow] {:fg :Gray}
;;                 :NonText {:fg :Black}
;;                 :Normal {:link :Normal}
;;                 :NormalFloat {:link :Normal}
;;                 :FloatBorder {:fg :DarkYellow}
;;                 :Pmenu {:bg :NONE}
;;                 :SpellBad {:fg :NvimLightRed :undercurl true}
;;                 :Title {:fg :DarkCyan :bold true}
;;                 :Todo {:fg :Yellow :bold true}
;;                 :Visual {:reverse true}
;;                 :WinSeparator {:fg :Gray}})
;;
;; (local diagnostic-virtual-text
;;        {:DiagnosticVirtualTextError {:fg :DarkRed :italic in-gui?}
;;         :DiagnosticVirtualTextHint {:fg :DarkBlue :italic in-gui?}
;;         :DiagnosticVirtualTextInfo {:fg :DarkCyan :italic in-gui?}
;;         :DiagnosticVirtualTextOk {:fg :DarkGreen :italic in-gui?}
;;         :DiagnosticVirtualTextWarn {:fg :DarkYellow :italic in-gui?}
;;         :LspInlayHint {:fg :Gray :italic in-gui?}})
;;
;; (local statusline {:StatusLine {:fg :Gray :bg :NONE}
;;                    :StatusLineError {:fg :DarkRed}
;;                    :StatusLineInfo {:fg :DarkCyan}
;;                    :StatusLineWarn {:fg :DarkYellow}})
;;
;; (core.map colors.set-hl [general diagnostic-virtual-text statusline])
