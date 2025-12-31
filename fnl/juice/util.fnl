(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(lambda lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(lambda executable? [cmd]
  (= (vim.fn.executable cmd) 1))

(lambda has? [cmd]
  (= (vim.fn.has cmd) 1))

(lambda set-keys [mappings]
  (each [_ mapping (ipairs mappings)]
    (vim.keymap.set (unpack mapping))))

(lambda call [module func ...]
  "Autoload and call a module function with optional args"
  ((. (autoload module) func) ...))

(lambda call-setup [modules]
  (if (core.string? modules) (call modules :setup)
      (core.sequential? modules) (each [_ module (ipairs modules)]
                                   (call module :setup))))

{: lua-cmd : executable? : has? : set-keys : call : call-setup}
