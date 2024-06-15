(local {: autoload} (require :nfnl.module))
(local {: merge : reduce : table?} (autoload :nfnl.core))

(lambda make-opts [?opts ?desc ?bufnr]
  "Produce a table with every `key = true`"
  (let [init {:desc ?desc :buffer ?bufnr}
        reducer (fn [acc opt] (merge acc {opt true}))]
    (reduce reducer init ?opts)))

(lambda map [mappings]
  (each [mode maps (pairs mappings)]
    (each [key params (pairs maps)]
      (let [(action flags desc bufnr) (unpack params)
            opts (make-opts flags desc bufnr)]
        (vim.keymap.set mode key action opts)))))

(lambda bufmap [bufnr mappings]
  (each [mode maps (pairs mappings)]
    (each [key params (pairs maps)]
      (let [(action flags desc) (unpack params)
            opts (make-opts flags desc bufnr)]
        (vim.keymap.set mode key action opts)))))

(lambda lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(lambda executable? [cmd]
  (-> (vim.fn.executable cmd)
      (= 1)))

(lambda has? [cmd]
  (-> (vim.fn.has cmd)
      (= 1)))

(lambda set-opts [options]
  "Given an `options` table, set each pair as `vim.opt.<key> = <value>`"
  (when (table? options)
    (each [k v (pairs options)]
      (tset vim.opt k v))))

(lambda auto-setup [module]
  ((-> (autoload module)
       (. :setup))))

{: map
 :nmap #(map {:n $1})
 :imap #(map {:i $1})
 :vmap #(map {:v $1})
 : bufmap
 : lua-cmd
 : executable?
 : has?
 : set-opts
 : auto-setup}
