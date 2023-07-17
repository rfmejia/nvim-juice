(module util
  {autoload {a aniseed.core}})

(def noremap {:noremap true})
(def silent {:silent true})
(def nowait {:nowait true})

(defn- merge-tables [ts]
  "Flattens a list of tables"
  (a.reduce
    (fn [acc t] (a.merge acc t))
    {}
    ts))

(defn nmap [key map opts]
  "Defines a keymap in normal mode"
  (vim.api.nvim_set_keymap :n key map (merge-tables opts)))

(defn imap [key map opts]
  "Defines a keymap in insert mode"
  (vim.api.nvim_set_keymap :i key map (merge-tables opts)))

(defn vmap [key map opts]
  "Defines a keymap in visual mode"
  (vim.api.nvim_set_keymap :v key map (merge-tables opts)))

(defn tmap [key map opts]
  "Defines a keymap in terminal mode"
  (vim.api.nvim_set_keymap :t key map (merge-tables opts)))

(defn lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))

(defn lua-statusline [command]
  "Wraps a Lua command string in vim statusline string"
  (string.format "%%{luaeval(\"%s\")}" command))

(defn executable? [cmd]
  (= (vim.fn.executable cmd) 1))

