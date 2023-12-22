(module packs
  {autoload {lsp juice.lsp
             u util}
   import-macros [[ac :aniseed.macros.autocmds]]})

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
                          ; TODO point this to a central colors.fnl
                          (let [theme (require :github-theme)
                                color-attr (lambda [hl-group attribute]
                                             (. (vim.api.nvim_get_hl 0 {:name hl-group}) attribute))
                                c {:default-bg :none
                                   :linenr-fg :#3d3d3d
                                   :linenr-bg :none
                                   :cursor-fg :#ffffff
                                   :cursor-bg :none
                                   :spell-bad :#bb4466
                                   :comment-fg :#707070
                                   :winsep-fg :#009000
                                   :winsep-bg :none
                                   :statusline-fg :#909090
                                   :statusline-bg (color-attr :StatusLine :bg)
                                   :diagnostic-error-fg (color-attr :DiagnosticError :fg)
                                   :diagnostic-warn-fg (color-attr :DiagnosticWarn :fg)}
                                options {:transparent true}
                                groups {:all {:Comment {:fg c.comment-fg :style :italic}
                                              :Conceal {:link :Comment}
                                              :CursorLine {:bg :none}
                                              :CursorLineNr {:fg c.cursor-fg :bg c.cursor-bg}
                                              :DiagnosticVirtualTextError {:fg c.diagnostic-error-fg :style :italic}
                                              :DiagnosticVirtualTextWarn {:fg c.diagnostic-warn-fg :style :italic}
                                              :LineNr {:fg c.linenr-fg :bg c.cursor-bg}
                                              :LineNrAbove {:fg c.linenr-fg :bg c.linenr-bg}
                                              :LineNrBelow {:fg c.linenr-fg :bg c.linenr-bg}
                                              :MsgArea {:fg :#909090}
                                              :SpellBad {:fg c.spell-bad :undercurl true}
                                              :StatusLine {:fg :#909090 :bg :none}
                                              :StatusLineError {:fg c.diagnostic-error-fg :bg c.statusline-bg}
                                              :StatusLineWarn {:fg c.diagnostic-warn-fg :bg c.statusline-bg}
                                              :Todo {:fg :#eeee00}
                                              :WinSeparator {:fg c.winsep-fg :bg c.winsep-bg}}
                                        }]
                            (theme.setup {: options : groups})
                            (set vim.opt.termguicolors true)
                            (set vim.opt.background "dark")
                            (vim.cmd "colorscheme github_dark"))
                          )}

               {1 "Olical/aniseed" :ft "fennel"}
               {1 "Olical/conjure" :ft ["clojure" "fennel" "lisp" "scheme"]}

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

               {1 "lewis6991/gitsigns.nvim"
                :event ["BufReadPre" "BufNewFile"]
                :config (fn []
                          (let [gitsigns (require :gitsigns)]
                            (gitsigns.setup))
                          )}

               {1 "neovim/nvim-lspconfig"
                :ft [:go :scala]
                :config (fn [] (lsp.setup))}

               {1 "scalameta/nvim-metals"
                :cmd "MetalsInit"
                :dependencies ["nvim-lua/plenary.nvim"
                               "nvim-lua/popup.nvim"]}

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
                                       :indent {:enable true}
                                       })
                            ))}

               {1 "mbbill/undotree"
                :cmd "UndotreeToggle"
                :config (fn []
                          (set vim.g.undotree_WindowLayout 4)
                          (set vim.g.undotree_SetFocusWhenToggle 1))}

               {1 "tpope/vim-fugitive" :cmd "Git"}

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

               {1 "tpope/vim-dadbod"
                :cmd "DB"
                :config (fn []
                          (ac.autocmd :FileType {:pattern ["sql" "mysql"]
                                                 :callback (fn []
                                                             (set vim.opt.omnifunc "vim_dadbod_completion#omni"))}))
                :dependencies [{1 "kristijanhusak/vim-dadbod-completion"}]}
               ]]


  ; Set up netrw
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern "netrw"
                                :callback (fn []
                                            ; Note: some options were removed due to a bug
                                            ; https://github.com/neovim/neovim/issues/23650#issuecomment-1863894217
                                            (set vim.g.netrw_altfile 1)        ; C-^ skips netrw (return to last edited file)
                                            (set vim.g.netrw_sort_by "exten")  ; sort by extension
                                            (set vim.g.netrw_sort_options "i") ; add sort options (i = ignore case)
                                            (u.nmap "?" ":h netrw-quickmap<CR>" [:noremap]))
                                })

  ; Load all plugins defined in the 'juice.plugins' directory
  (lazy.setup plugins opts))
