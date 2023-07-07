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

(defn map-key [mode key map opts]
  "Merge mapping options and call Lua keymap API"
  (let [merged (merge-tables opts)]
    (vim.api.nvim_set_keymap mode key map merged)))

(defn nmap [key map opts]
  "Defines a keymap in normal mode"
  (map-key :n key map opts))

(defn imap [key map opts]
  "Defines a keymap in insert mode"
  (map-key :i key map opts))

(defn vmap [key map opts]
  "Defines a keymap in visual mode"
  (map-key :v key map opts))

(defn lua-cmd [str]
  "Wraps a Lua command string in a viml command string"
  (string.format "<cmd>lua %s<cr>" str))
