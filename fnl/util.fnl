(module util
  {autoload {a aniseed.core}})

(defn- make-opts [keys]
  "Produce a table with every `key = true`"
  (a.reduce
    (fn [acc key] (a.merge acc {key true}))
    {}
    keys))

(defn nmap [key map opts]
  "Defines a keymap in normal mode"
  (vim.keymap.set :n key map (make-opts opts)))

(defn imap [key map opts]
  "Defines a keymap in insert mode"
  (vim.keymap.set :i key map (make-opts opts)))

(defn vmap [key map opts]
  "Defines a keymap in visual mode"
  (vim.keymap.set :v key map (make-opts opts)))

(defn tmap [key map opts]
  "Defines a keymap in terminal mode"
  (vim.keymap.set :t key map (make-opts opts)))

(defn lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(defn lua-statusline [command]
  "Wraps a Lua command string in vim statusline string"
  (string.format "%%{luaeval(\"%s\")}" command))

(defn executable? [cmd]
  (= (vim.fn.executable cmd) 1))

(defn has? [cmd]
  (= (vim.fn.has cmd) 1))

(defn exists? [env]
  (= (vim.fn.exists env) 1))
