(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

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

(lambda assoc-in [t ...]
  "Given one or more tables of options, set each entry in the table as `<t>.<key> = <value>`"
  (each [_ options (ipairs [...])]
    (when (core.table? options)
      (each [k v (pairs options)]
        (core.assoc t k v)))))

(lambda call [plugin func ...]
  "Autoload and call a plugin function with optional args"
  ((. (autoload plugin) func) ...))

(lambda call-setup [...]
  (each [_ module (ipairs [...])]
    (call module :setup)))

(lambda insert-lines [...]
  "Insert text at the current cursor position"
  (let [buf (vim.api.nvim_get_current_buf)
        (row col) (unpack (vim.api.nvim_win_get_cursor 0))
        _row (- row 1)]
    (vim.api.nvim_buf_set_lines buf _row (+ _row 1) false [...])))

{: lua-cmd
 : executable?
 : has?
 : set-keys
 : assoc-in
 : call
 : call-setup
 : insert-lines}
