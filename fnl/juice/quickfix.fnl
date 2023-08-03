(module quickfix)

(defn toggle-window []
  (let [count-win (fn [] (vim.fn.winnr "$"))
        current (count-win)]
    (vim.cmd "copen")
    (when (= current (count-win))
      (vim.cmd "cclose"))
    ))
