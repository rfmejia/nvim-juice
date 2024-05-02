(local {: autoload} (require :nfnl.module))
(local {: merge : reduce : table?} (autoload :nfnl.core))

(lambda make-opts [?opts ?desc ?bufnr]
  "Produce a table with every `key = true`"
  (let [init {:desc ?desc :buffer ?bufnr}
        reducer (fn [acc opt] (merge acc {opt true}))]
    (reduce reducer init ?opts)))

(comment "TODO optionally add a top-level string for comments")
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

(lambda nmap [mappings]
  "Defines keymaps in normal mode"
  (map {:n mappings}))

(lambda imap [key map ?opts ?desc ?bufnr]
  "Defines a keymap in insert mode"
  (vim.keymap.set :i key map (make-opts ?opts ?desc ?bufnr)))

(lambda vmap [key map ?opts ?desc ?bufnr]
  "Defines a keymap in visual mode"
  (vim.keymap.set :v key map (make-opts ?opts ?desc ?bufnr)))

(lambda tmap [key map ?opts ?desc ?bufnr]
  "Defines a keymap in terminal mode"
  (vim.keymap.set :t key map (make-opts ?opts ?desc ?bufnr)))

(lambda lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(lambda lua-statusline [command]
  "Wraps a Lua command string in vim statusline string"
  (string.format "%%{luaeval(\"%s\")}" command))

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

{: nmap
 : imap
 : vmap
 : tmap
 : map
 : bufmap
 : lua-cmd
 : lua-statusline
 : executable?
 : has?
 : set-opts
 : auto-setup
 :augroup vim.api.nvim_create_augroup
 :autocmd vim.api.nvim_create_autocmd}
