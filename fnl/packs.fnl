(module packs
  {autoload {u util
             lsp juice.lsp}
   import-macros [[ac :aniseed.macros.autocmds]]})

; unload netrw
(set vim.g.loaded_netrw 1)         ;
(set vim.g.loaded_netrwPlugin 1)   ;

;; -----------------------------------------------------------------------------
; USER PLUGINS
(let [lazy (require "lazy")
      opts {:ui {:border "rounded"}
            :performance {:rtp {:disabled_plugins [:netrwPlugin
                                                   :rplugin
                                                   :tohtml
                                                   :tutor
                                                   :vimball]}}
            }

      plugins [; colorscheme (always loaded)
               {1 "projekt0n/github-nvim-theme"
                :lazy false
                :priority 1000
                :config (fn []
                          (let [theme (require "github-theme")
                                dark-palette {:github_dark_high_contrast {:bg0 "#0000FF"
                                                                          :bg1 "#0000FF"
                                                                          :bg2 "#0000FF"
                                                                          :bg3 "#0000FF"
                                                                          :bg4 "#0000FF"
                                                                          }}]
                            (theme.setup {:palettes dark-palette})
                            (vim.cmd "colorscheme github_dark_high_contrast")))}

               {1 "tpope/vim-commentary"
                :keys "gc"}
               {1 "tpope/vim-surround"
                :keys ["cs" "ds" "ys"]}
               {1 "tpope/vim-repeat"
                :keys "."}
               {1 "tpope/vim-fugitive"
                :cmd "Git"}

               {1 "justinmk/vim-dirvish"
                :cmd :Dirvish
                :config (fn []
                          ; Sort by file/dir type, and then hidden files/dirs
                          (vim.cmd "let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'"))}

               ; Navigate between nvim splits and tmux panes
               {1 "alexghergh/nvim-tmux-navigation"
                :event (fn [] (if (= (vim.fn.exists "$TMUX") 1)
                                "VeryLazy"))
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

               ; fennel plugins
               {1 "Olical/aniseed"
                :ft "fennel"}
               {1 "Olical/conjure"
                :ft ["clojure" "fennel" "lisp" "scheme"]}

               {1 "mbbill/undotree"
                :keys "<leader>u"
                :config (fn []
                          (set vim.g.undotree_WindowLayout 4)
                          (set vim.g.undotree_SetFocusWhenToggle 1))}

               ; fuzzy finder
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

               {1 "nvim-treesitter/nvim-treesitter"
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
                                           "vim"
                                           "vimdoc"
                                           "yaml"]]
                            (ts.setup {:ensure_installed languages
                                       :highlight {:enable true}
                                       :incremental_selection {:enable true}
                                       :indent {:enable true}
                                       })
                            ))}

               ; language-specific
               {1 "neovim/nvim-lspconfig"
                :ft [:go :scala]
                :config (fn [] (lsp.setup))}

               {1 "scalameta/nvim-metals"
                :cmd "MetalsInit"
                :dependencies ["nvim-lua/plenary.nvim"
                               "nvim-lua/popup.nvim"]}

               {1 "tpope/vim-dadbod"
                :cmd "DB"
                :config (fn []
                          (ac.autocmd :FileType {:pattern ["sql" "mysql"]
                                                 :callback (fn []
                                                             (set vim.opt.omnifunc "vim_dadbod_completion#omni"))})
                          )
                :dependencies [{1 "kristijanhusak/vim-dadbod-completion"}]}
               ]]

  (lazy.setup plugins opts)
  (u.nmap "<leader>ll" ":Lazy<CR>" [:noremap :silent]))
