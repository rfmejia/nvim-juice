{1 "junegunn/fzf.vim"
 :cmd ["Files" "GFiles" "History"]
 :config (fn []
           (set vim.g.fzf_layout {:window {:width 0.9 :height 0.9}})
           (set vim.g.fzf_preview_window ["up:50%" "ctrl-/"]))
 :dependencies [{1 "junegunn/fzf"
                 :name "fzf"
                 :dir "~/.fzf"
                 :build "./install --all"}]
 }
