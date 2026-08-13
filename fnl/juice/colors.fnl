(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(fn hl-with-opt [name keys]
  "Sets the option of `name` hl group to true"
  (let [group (or (vim.api.nvim_get_hl 0 {: name}) {})]
    (if (core.sequential? keys) {name (core.merge! group (core.->set keys))}
        (core.string? keys) {name (core.assoc group keys true)})))

(lambda set-hl [hi-options]
  "Helper function to set multiple highlight groups using a table"
  (each [group settings (pairs hi-options)]
    (if (core.sequential? group)
        (each [_ sub-group (ipairs group)]
          (vim.api.nvim_set_hl 0 sub-group settings))
        (core.string? group)
        (vim.api.nvim_set_hl 0 group settings))))

(fn on-background-change []
  "Must return nil - autocmd deleted if returns truthy (https://github.com/neovim/neovim/issues/39016)"
  (vim.cmd.colorscheme :default-black)
  nil)

(fn setup []
  (vim.api.nvim_create_autocmd :OptionSet
                               {:pattern :background
                                :callback on-background-change})
  (vim.cmd.colorscheme :default-black))

{: setup : set-hl : hl-with-opt}
