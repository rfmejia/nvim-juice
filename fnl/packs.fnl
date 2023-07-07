(module packs
  {autoload {u util
             lsp juice.lsp}
   require-macros [aniseed.macros.autocmds]})

(local nmap u.nmap)

;; -----------------------------------------------------------------------------
; BUILTIN PLUGINS

; disable unused builtin plugins
(set vim.g.loaded_2html_plugin 1)
(set vim.g.loaded_getscript 1)
(set vim.g.loaded_getscriptPlugin 1)
(set vim.g.loaded_gzip 1)
(set vim.g.loaded_logiPat 1)
(set vim.g.loaded_rrhelper 1)
(set vim.g.loaded_tar 1)
(set vim.g.loaded_tarPlugin 1)
(set vim.g.loaded_vimball 1)
(set vim.g.loaded_vimballPlugin 1)
(set vim.g.loaded_zip 1)
(set vim.g.loaded_zipPlugin 1)

; netrw
(set vim.g.netrw_altfile 1)        ; C-^ skips netrw (return to last edited file)
(set vim.g.netrw_banner 0)         ; hide banner
(set vim.g.netrw_sort_by "exten")  ; sort by extension
(set vim.g.netrw_sort_options "i") ; add sort options (i = ignore case)
(set vim.g.netrw_list_hide
     "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+") ; hide dotfiles by adding to g:netrw_list_hide

; show key mappings inside netrw window
(vim.api.nvim_create_autocmd :FileType 
                             {:pattern "netrw" 
                              :command "nnoremap <buffer> ? :h netrw-quickmap<CR>"})

;; -----------------------------------------------------------------------------
; USER PLUGINS
(let [lazy (require "lazy")
      plugins [["tpope/vim-commentary"]
               ["tpope/vim-fugitive"]
               ["tpope/vim-surround"]

               ; fennel plugins
               {1 "Olical/aniseed"
                :priority 10000}
               {1 "Olical/conjure"
                :ft ["clojure" "fennel"]}

               {1 "mbbill/undotree"
                :config (fn []
                          (set vim.g.undotree_WindowLayout 4)
                          (set vim.g.undotree_SetFocusWhenToggle 1)
                          (nmap "<leader>u" ":UndotreeToggle<CR>" [noremap silent]))}

               ; fuzzy finder
               {1 "junegunn/fzf"
                :name "fzf"
                :dir "~/.fzf"
                :build "./install --all"}
               {1 "junegunn/fzf.vim"
                :config (fn []
                          (set vim.g.fzf_layout {:window {:width 0.9 :height 0.9}})
                          (set vim.g.fzf_preview_window ["up:50%" "ctrl-/"])
                          (nmap "<leader>f" ":Files<CR>" [noremap silent])
                          (nmap "<leader>g" ":GFiles<CR>" [noremap silent])
                          (nmap "<leader>p" ":History<CR>" [noremap silent]))}

               ; colorscheme
               {1 "projekt0n/github-nvim-theme"
                :priority 1000
                :config (lambda [] 
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
                                           "javascript"
                                           "json"
                                           "git_config"
                                           "gitcommit"
                                           "gitignore"
                                           "html"
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

               {1 "neovim/nvim-lspconfig"
                :config (fn [] (lsp.setup))}

               {1 "scalameta/nvim-metals"
                :cmd "MetalsInit"
                :dependencies ["nvim-lua/plenary.nvim"
                               "nvim-lua/popup.nvim" 
                               "mfussenegger/nvim-dap"]}
               ]]
  (lazy.setup plugins))
