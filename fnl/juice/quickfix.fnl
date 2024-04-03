(fn toggle-window [toggle-qf?]
  (let [count-win (fn [] (vim.fn.winnr "$"))
        current (count-win)
        open-cmd (if toggle-qf? "copen" "lopen")
        close-cmd (if toggle-qf? "cclose" "lclose")]
    (vim.cmd open-cmd)
    (when (= current (count-win))
      (vim.cmd close-cmd))
    ))

(fn toggle-qf-window []
  (toggle-window true))

(fn toggle-loclist-window []
  (toggle-window false))

{: toggle-window
 : toggle-qf-window
 : toggle-loclist-window}
