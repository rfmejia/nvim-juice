(local {: autoload} (require :nfnl.module))
(local {: nmap} (autoload :juice.util))

(local directions {:up [:k :-U] :down [:j :-D] :left [:h :-L] :right [:l :-R]})
(lambda vim-direction [direction] (?. directions direction 1))
(lambda tmux-direction [direction] (?. directions direction 2))

(lambda vim-navigate [direction]
  (vim.cmd (.. :wincmd " " (vim-direction direction))))

(fn get-tmux-socket []
  "Return current running tmux socket, else nil"
  (-?> vim.env.TMUX
       (vim.fn.split ",")
       (?. 1)))

(lambda tmux-navigate [direction]
  (let [socket (get-tmux-socket)
        pane (tmux-direction direction)
        tmux-cmd [:tmux :-S socket :select-pane pane]]
    (match (vim.fn.system tmux-cmd)
      ok nil
      (nil err-msg) (print "Could not run `tmux`: " err-msg))))

(lambda navigate [direction]
  (local current-vim-win (vim.fn.winnr))
  (vim-navigate direction)
  (when (= current-vim-win (vim.fn.winnr))
    (tmux-navigate direction)))

{: navigate
 :navigate-up (fn [] (navigate :up))
 :navigate-down (fn [] (navigate :down))
 :navigate-left (fn [] (navigate :left))
 :navigate-right (fn [] (navigate :right))}
