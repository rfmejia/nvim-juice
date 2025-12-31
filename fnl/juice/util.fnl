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

(lambda apply [f params]
  "Applies function `f` to params, where params can be"
  (if (and (core.sequential? params) (core.sequential? (core.first params)))
      (each [_ subparams (ipairs params)]
        (core.pr {: subparams})
        (if (not (core.nil? subparams))
            (f (unpack subparams))))
      (core.sequential? params)
      (f (unpack params))
      :else
      (f params)))

(comment (apply vim.print :single)
  (apply vim.print [:a :b])
  (apply core.println [[1 2] [3 4]])
  (apply core.println [[1 2] nil [3 4]]))

(lambda call [module func ...]
  "Autoload and call a module function with optional args"
  ((. (autoload module) func) ...))

(lambda call-setup [modules]
  (if (core.string? modules) (call modules :setup)
      (core.sequential? modules) (each [_ module (ipairs modules)]
                                   (call module :setup))))

{: lua-cmd : executable? : has? : set-keys : call : call-setup}
