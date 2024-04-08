(let [lazy (require :lazy)
      core (require :nfnl.core)
      opts {:ui {:border :rounded}
            :performance {:rtp {:disabled_plugins [:rplugin
                                                   :tohtml
                                                   :tutor
                                                   :vimball]}}}
      basic [{1 :Olical/nfnl :ft :fennel}
             {1 :projekt0n/github-nvim-theme
              :lazy false
              :priority 1000
              :config (fn []
                        (let [c (require :juice.colors)]
                          (c.setup)))}
             {1 :nvim-treesitter/nvim-treesitter
              :event [:BufReadPre :BufNewFile]
              :build ":TSUpdate"
              :config (fn []
                        (let [ts (require :nvim-treesitter.configs)
                              languages [:bash
                                         :dockerfile
                                         :fennel
                                         :hocon
                                         :javascript
                                         :json
                                         :git_config
                                         :gitcommit
                                         :gitignore
                                         :go
                                         :html
                                         :java
                                         :lua
                                         :markdown
                                         :scala
                                         :sql
                                         :todotxt
                                         :vim
                                         :vimdoc
                                         :yaml]]
                          (ts.setup {:ensure_installed languages
                                     :highlight {:enable true}
                                     :indent {:enable true}})))}]
      ui-tools [{1 :stevearc/oil.nvim
                 :cmd :Oil
                 :config (fn []
                           (let [oil (require :oil)
                                 config {:default_file_explorer true
                                         :delete_to_trash true}]
                             (oil.setup config)))}
                {1 :nvim-telescope/telescope.nvim
                 :tag :0.1.6
                 :dependencies [:nvim-lua/plenary.nvim]
                 :config (fn []
                           (let [telescope (require :telescope)
                                 actions (require :telescope.actions)
                                 config {:defaults {:border false
                                                    :layout_config {:prompt_position :bottom
                                                                    :height 0.6}
                                                    :layout_strategy :bottom_pane
                                                    :mappings {:i {:<esc> actions.close
                                                                   :<C-u> false}}
                                                    :path_display {1 :truncate}
                                                    :preview false
                                                    :prompt_prefix "? "}}]
                             (telescope.setup config)))}
                {1 :lewis6991/gitsigns.nvim
                 :event [:BufReadPre :BufNewFile]
                 :config (fn []
                           (let [gitsigns (require :gitsigns)]
                             (gitsigns.setup)))}
                {1 :mbbill/undotree
                 :cmd :UndotreeToggle
                 :config (fn []
                           (set vim.g.undotree_WindowLayout 4)
                           (set vim.g.undotree_SetFocusWhenToggle 1))}
                {1 :alexghergh/nvim-tmux-navigation
                 :event (fn [] (if (vim.fn.exists :$TMUX) :VeryLazy))
                 :config (fn []
                           (let [nav (require :nvim-tmux-navigation)]
                             (nav.setup {:disabled_when_zoomed true
                                         :keybindings {:left :<M-h>
                                                       :down :<M-j>
                                                       :up :<M-k>
                                                       :right :<M-l>}})))}]
      text-tools [{1 :numToStr/Comment.nvim
                   :keys :gc
                   :config (fn []
                             (let [c (require :Comment)]
                               (c.setup)))}
                  {1 :kylechui/nvim-surround
                   :keys [:cs :ds :ys]
                   :config (fn []
                             (let [surround (require :nvim-surround)]
                               (surround.setup)))}]
      dev-tools [{1 :neovim/nvim-lspconfig
                  :ft [:go :scala]
                  :config (fn []
                            (let [lsp (require :juice.lsp)]
                              (lsp.setup)))}
                 {1 :scalameta/nvim-metals
                  :cmd :MetalsInit
                  :dependencies [:nvim-lua/plenary.nvim]}
                 {1 :Olical/conjure :ft [:clojure :fennel :lisp :scheme]}
                 {1 :github/copilot.vim
                  :cmd :Copilot
                  :config (fn []
                            (set vim.g.copilot_workspace_folders
                                 [:$WORKSPACE/myshake-backends
                                  :$WORKSPACE/myshake-bc]))}]
      database-tools [{1 :kristijanhusak/vim-dadbod-ui
                       :cmd [:DBUI :DBUIToggle]
                       :config (fn []
                                 (vim.api.nvim_create_autocmd :FileType
                                                              {:pattern [:sql
                                                                         :mysql]
                                                               :callback (fn []
                                                                           (set vim.opt.commentstring
                                                                                "--%s")
                                                                           (set vim.opt.omnifunc
                                                                                "vim_dadbod_completion#omni"))}))
                       :dependencies [{1 :tpope/vim-dadbod :lazy true}
                                      {1 :kristijanhusak/vim-dadbod-completion
                                       :lazy true
                                       :ft [:sql :mysql]}]}]
      plugins (core.concat basic ui-tools text-tools dev-tools database-tools)]
  (lazy.setup plugins opts))
