(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

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

(local cleared-bg-groups [:Normal :CursorLine :Pmenu :StatusLine])

(fn hl-with-opt [name keys]
  "Sets the option of `name` hl group to true"
  (let [group (or (vim.api.nvim_get_hl 0 {: name}) {})]
    (if (core.sequential? keys) {name (core.merge! group (core.->set keys))}
        (core.string? keys) {name (core.assoc group keys true)})))

(fn compute-hl-groups []
  (let [hl-with-opts (icollect [k v (pairs flags)]
                       (hl-with-opt k v))
        cleared-opts (core.map #{$ {:bg :NONE :force true}} cleared-bg-groups)
        all-opts (core.concat hl-with-opts cleared-opts)]
    (core.merge! base (table.unpack all-opts))))

(lambda set-hl [hi-options]
  "Helper function to set multiple highlight groups using a table"
  (each [group settings (pairs hi-options)]
    (if (core.sequential? group)
        (each [_ sub-group (ipairs group)]
          (vim.api.nvim_set_hl 0 sub-group settings))
        (core.string? group)
        (vim.api.nvim_set_hl 0 group settings))))

(fn set-colorscheme []
  (let [base-colors :default
        custom-groups (compute-hl-groups)]
    (vim.cmd.colorscheme :default)
    (set-hl custom-groups)))

(comment "TODO move to default-black (except setup, set-hl, other utilities)")

(fn setup []
  (let [on-background-change (fn []
                               "Must return nil - autocmd deleted if returns truthy (https://github.com/neovim/neovim/issues/39016)"
                               (set-colorscheme)
                               nil)]
    (set-colorscheme)
    (vim.api.nvim_create_autocmd :OptionSet
                                 {:pattern :background
                                  :callback on-background-change})))

{: setup : set-hl}
