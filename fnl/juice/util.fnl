(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(lambda lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(lambda executable? [cmd]
  (-> (vim.fn.executable cmd)
      (= 1)))

(lambda has? [cmd]
  (-> (vim.fn.has cmd)
      (= 1)))

(lambda set-keys [mappings]
  (each [_ mapping (ipairs mappings)]
    (vim.keymap.set (unpack mapping))))

(lambda assoc-in [t ...]
  "Given one or more tables of options, set each entry in the table as `<t>.<key> = <value>`"
  (each [_ options (ipairs [...])]
    (when (core.table? options)
      (each [k v (pairs options)]
        (core.assoc t k v)))))

(lambda auto-setup [...]
  (each [_ module (ipairs [...])]
    ((. (autoload module) :setup))))

{: lua-cmd : executable? : has? : set-keys : assoc-in : auto-setup}
