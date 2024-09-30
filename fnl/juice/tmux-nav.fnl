(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local notify (autoload :nfnl.notify))
(local util (autoload :juice.util))

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
      (nil err-msg) (notify.error "Could not run `tmux`: " err-msg))))

(lambda navigate [direction]
  (local current-vim-win (vim.fn.winnr))
  (vim-navigate direction)
  (when (= current-vim-win (vim.fn.winnr))
    (tmux-navigate direction)))

(fn setup-default-mapping [in-tmux?]
  (let [nav-keys {:left :<M-h> :right :<M-l> :up :<M-k> :down :<M-j>}
        options {:left {:desc "jump to the left window"
                        :noremap true
                        :silent true}
                 :right {:desc "jump to the right window"
                         :noremap true
                         :silent true}
                 :up {:desc "jump to the window above"
                      :noremap true
                      :silent true}
                 :down {:desc "jump to the window below"
                        :noremap true
                        :silent true}}
        vim-keys {:left :<C-w>h :right :<C-w>l :up :<C-w>k :down :<C-w>l}
        tmux-keys {:left #(navigate :left)
                   :right #(navigate :right)
                   :up #(navigate :up)
                   :down #(navigate :down)}
        win-nav (if in-tmux? tmux-keys vim-keys)
        make-mapping (lambda [dir]
                       (let [mapping (core.map #(core.get $ dir)
                                               [nav-keys win-nav options])]
                         (table.insert mapping 1 :n)
                         mapping))
        mappings (core.map make-mapping [:left :right :up :down])]
    (util.set-keys mappings)))

(lambda setup []
  (setup-default-mapping vim.env.TMUX))

{: setup}
