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

      plugins [["tpope/vim-commentary"]
               ["tpope/vim-surround"]
               ["tpope/vim-repeat"]
               ["tpope/vim-dotenv"]
               {1 "tpope/vim-fugitive"
                :cmd "Git"}

               {1 "justinmk/vim-dirvish"
                :config (fn []
                          ; Sort by file/dir type, and then hidden files/dirs
                          (vim.cmd "let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'"))}

               ; Navigate between nvim splits and tmux panes
               {1 "alexghergh/nvim-tmux-navigation"
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
                :config (fn []
                          (set vim.g.undotree_WindowLayout 4)
                          (set vim.g.undotree_SetFocusWhenToggle 1)
                          (u.nmap "<leader>u" ":UndotreeToggle<CR>" [noremap silent]))}

               ; fuzzy finder
               {1 "junegunn/fzf"
                :name "fzf"
                :dir "~/.fzf"
                :build "./install --all"}
               {1 "junegunn/fzf.vim"
                :config (fn []
                          (set vim.g.fzf_layout {:window {:width 0.9 :height 0.9}})
                          (set vim.g.fzf_preview_window ["up:50%" "ctrl-/"])
                          (u.nmap "<leader>f" ":Files<CR>" [noremap silent])
                          (u.nmap "<leader>g" ":GFiles<CR>" [noremap silent])
                          (u.nmap "<leader>p" ":History<CR>" [noremap silent]))}

               ; colorscheme
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

               {1 "nvim-treesitter/nvim-treesitter"
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
                :ft ["sql" "mysql"]
                :config (fn []
                          (u.nmap "<localleader>dc" ":DB g:active " [noremap silent])
                          (u.nmap "<localleader>dd" ":.DB g:active<CR>" [noremap silent])
                          (u.nmap "<localleader>db" ":%DB g:active<CR>" [noremap silent])
                          (u.nmap "<localleader>dp" "vip:DB g:active<CR>" [noremap silent])
                          (ac.autocmd :FileType {:pattern ["sql" "mysql"]
                                                 :callback (fn []
                                                             (set vim.opt.omnifunc "vim_dadbod_completion#omni"))})
                          )
                :dependencies [{1 "kristijanhusak/vim-dadbod-completion"}]}
               ]]

  (lazy.setup plugins opts)
  (u.nmap "<leader>ll" ":Lazy<CR>" [noremap silent]))
