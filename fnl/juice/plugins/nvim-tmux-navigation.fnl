{1 "alexghergh/nvim-tmux-navigation"
 :event (fn [] (if (vim.fn.exists "$TMUX") "VeryLazy"))
 :config (fn []
           (let [nav (require "nvim-tmux-navigation")]
             (nav.setup {:disabled_when_zoomed true
                         :keybindings {:left  "<M-h>"
                                       :down  "<M-j>"
                                       :up    "<M-k>"
                                       :right "<M-l>"}
                         })
             )
           )
 }
