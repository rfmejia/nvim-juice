;; -----------------------------------------------------------------------------
; PLUGINS
(let [lazy (require "lazy")
      opts {:ui {:border "rounded"}
            :performance {:rtp {:disabled_plugins [:rplugin
                                                   :tohtml
                                                   :tutor
                                                   :vimball]}}}
      plugins [{1 "projekt0n/github-nvim-theme"
                :lazy false
                :priority 1000
                :config (fn []
                          (let [c (require :juice.colors)]
                            (c.setup)))}

               {1 "Olical/nfnl" :ft "fennel"}
               {1 "Olical/conjure" :ft ["clojure" "fennel" "lisp" "scheme"]}

               {1 "stevearc/oil.nvim"
                :cmd "Oil"
                :config (fn []
                          (let [oil (require :oil)]
                            (oil.setup)))}

               {1 "junegunn/fzf.vim"
                :cmd ["Files" "GFiles" "History"]
                :config (fn []
                          (set vim.g.fzf_layout {:window {:width 0.9 :height 0.9}})
                          (set vim.g.fzf_preview_window ["up:50%" "ctrl-/"]))
                :dependencies [{1 "junegunn/fzf"
                                :name "fzf"
                                :dir "~/.fzf"
                                :build "./install --all"}]}

               {1 "lewis6991/gitsigns.nvim"
                :event ["BufReadPre" "BufNewFile"]
                :config (fn []
                          (let [gitsigns (require :gitsigns)]
                            (gitsigns.setup)))}

               {1 "neovim/nvim-lspconfig"
                :ft [:go :scala]
                :config (fn []
                          (let [lsp (require :juice.lsp)]
                            (lsp.setup)))}

               {1 "scalameta/nvim-metals"
                :cmd "MetalsInit"
                :dependencies ["nvim-lua/plenary.nvim"]}

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
                            ))}

               {1 "nvim-treesitter/nvim-treesitter"
                ; :version "0.9.2" ; FIXME pinned due to https://github.com/nvim-treesitter/nvim-treesitter/issues/2293
                :event ["BufReadPre" "BufNewFile"]
                :build ":TSUpdate"
                :config (fn []
                          (let [ts (require "nvim-treesitter.configs")
                                languages ["bash"
                                           "dockerfile"
                                           "fennel"
                                           "hocon"
                                           "javascript"
                                           "json"
                                           "git_config"
                                           "gitcommit"
                                           "gitignore"
                                           "go"
                                           "html"
                                           "java"
                                           "lua"
                                           "markdown"
                                           "scala"
                                           "sql"
                                           "todotxt"
                                           "vim"
                                           "vimdoc"
                                           "yaml"]]
                            (ts.setup {:ensure_installed languages
                                       :highlight {:enable true}
                                       :indent {:enable true}
                                       })
                            ))}

               {1 "mbbill/undotree"
                :cmd "UndotreeToggle"
                :config (fn []
                          (set vim.g.undotree_WindowLayout 4)
                          (set vim.g.undotree_SetFocusWhenToggle 1))}

               {1 "numToStr/Comment.nvim"
                :keys "gc"
                :config (fn []
                          (let [c (require :Comment)]
                            (c.setup)))}

               {1 "kylechui/nvim-surround"
                :keys ["cs" "ds" "ys"]
                :config (fn []
                          (let [surround (require :nvim-surround)]
                            (surround.setup)))}

               {1 "github/copilot.vim"
                :cmd "Copilot"
                :config (fn []
                          (set vim.g.copilot_workspace_folders ["$WORKSPACE/myshake-backends"
                                                                "$WORKSPACE/myshake-bc"]))}

              {1 "kristijanhusak/vim-dadbod-ui"
                :cmd ["DBUI" "DBUIToggle"]
                :config (fn []
                          (vim.api.nvim_create_autocmd :FileType {:pattern ["sql" "mysql"]
                                                 :callback (fn []
                                                             (set vim.opt.commentstring "--%s")
                                                             (set vim.opt.omnifunc "vim_dadbod_completion#omni"))}))
                :dependencies [{1 "tpope/vim-dadbod"
                                :lazy true}
                               {1 "kristijanhusak/vim-dadbod-completion"
                                :lazy true
                                :ft ["sql" "mysql"]}]
                }
              ]]

  (lazy.setup plugins opts))
