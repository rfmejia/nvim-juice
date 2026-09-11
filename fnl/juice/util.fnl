(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local inspect (autoload :vim.inspect))

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

(lambda call [module func ...]
  "Autoload and call a module function with optional args"
  ((. (autoload module) func) ...))

(lambda call-setup [modules]
  (if (core.string? modules) (call modules :setup)
      (core.sequential? modules) (each [_ module (ipairs modules)]
                                   (call module :setup))))

(lambda index-of [seq-table value]
  "Returns the index of `value` in a given a sequential table, or nil if it does
not exist. Uses `vim.inspect` to compare state values"
  (fn loop [states idx target]
    (if (core.nil? (. states idx)) nil
        (= (inspect (. states idx)) target) idx
        :else (loop states (core.inc idx) target)))

  (loop seq-table 1 (inspect value)))

(lambda next-state [states state ?fallback]
  "Return the next state given a sequential table of `states` transitions and a
current `state`. If the state does not exist, returns `?fallback` (if supplied)
or first state."
  (let [new-state (-?>> state
                        (index-of states)
                        core.inc
                        (. states))]
    (or new-state ?fallback (. states 1))))

{: lua-cmd
 : executable?
 : has?
 : set-keys
 : call
 : call-setup
 : index-of
 : next-state}
