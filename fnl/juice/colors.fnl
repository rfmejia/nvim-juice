(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(lambda set-hl [hi-options]
  "Helper function to set multiple highlight groups using a table"
  (each [group settings (pairs hi-options)]
    (if (core.sequential? group)
        (each [_ sub-group (ipairs group)]
          (vim.api.nvim_set_hl 0 sub-group settings))
        (core.string? group)
        (vim.api.nvim_set_hl 0 group settings))))

{: set-hl}
