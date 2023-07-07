(module util
  {autoload {a aniseed.core}})

(def noremap {:noremap true})
(def silent {:silent true})
(def nowait {:nowait true})

(defn- merge-tables [ts]
  (a.reduce
    (lambda [acc t] (a.merge acc t))
    {}
    ts))

(defn map-key [mode key map opts]
  (let [merged (merge-tables opts)]
    (vim.api.nvim_set_keymap mode key map merged)))

(defn nmap [key map opts]
  (map-key :n key map opts))

(defn imap [key map opts]
  (map-key :i key map opts))

(defn vmap [key map opts]
  (map-key :v key map opts))

(defn lua-cmd [str]
  (string.format "<cmd>lua %s<cr>" str))
