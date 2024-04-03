(fn make-opts [keys]
  "Produce a table with every `key = true`"
  (local a (require :nfnl.core))
  (a.reduce
    (fn [acc key] (a.merge acc {key true}))
    {}
    keys))

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

{: nmap
 : imap
 : vmap
 : tmap
 : lua-cmd
 : lua-statusline
 : executable?
 : has?
 : exists?}
