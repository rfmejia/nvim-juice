(local {: autoload} (require :nfnl.module))
(local {: merge : reduce : table?} (autoload :nfnl.core))

(fn make-opts [keys]
  "Produce a table with every `key = true`"
  (reduce (fn [acc key] (merge acc {key true})) {} keys))

(fn nmap [key map opts]
  "Defines a keymap in normal mode"
  (vim.keymap.set :n key map (make-opts opts)))

(fn imap [key map opts]
  "Defines a keymap in insert mode"
  (vim.keymap.set :i key map (make-opts opts)))

(fn vmap [key map opts]
  "Defines a keymap in visual mode"
  (vim.keymap.set :v key map (make-opts opts)))

(fn tmap [key map opts]
  "Defines a keymap in terminal mode"
  (vim.keymap.set :t key map (make-opts opts)))

(fn lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(fn lua-statusline [command]
  "Wraps a Lua command string in vim statusline string"
  (string.format "%%{luaeval(\"%s\")}" command))

(fn executable? [cmd]
  (= (vim.fn.executable cmd) 1))

(fn has? [cmd]
  (= (vim.fn.has cmd) 1))

(fn exists? [env]
  (= (vim.fn.exists env) 1))

(fn set-opts [options]
  (when (table? options)
    (each [k v (pairs options)]
      (tset vim.opt k v))))

(fn auto-setup [module]
  ((. (autoload module) :setup)))

{: nmap
 : imap
 : vmap
 : tmap
 : lua-cmd
 : lua-statusline
 : executable?
 : has?
 : exists?
 : set-opts
 : auto-setup
 :augroup vim.api.nvim_create_augroup
 :autocmd vim.api.nvim_create_autocmd
 :user-command vim.api.nvim_create_user_command}
