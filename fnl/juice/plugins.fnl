(local {: autoload} (require :nfnl.module))
(local {: concat} (autoload :nfnl.core))
(local {: autocmd : auto-setup : set-opts} (autoload :juice.util))

(local basic [{1 :Olical/nfnl :ft :fennel}
              {1 :projekt0n/github-nvim-theme
               :lazy false
               :priority 1000
               :config (fn [] (auto-setup :juice.colors))}
              {1 :nvim-treesitter/nvim-treesitter
               :event [:BufReadPre :BufNewFile]
               :build ":TSUpdate"
               :config (fn []
                         (let [ts (autoload :nvim-treesitter.configs)
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
                                          :yaml]
                               config {:ensure_installed languages
                                       :highlight {:enable true}
                                       :indent {:enable true}}]
                           (ts.setup config)))}])

(local ui-tools [{1 :stevearc/oil.nvim
                  :cmd :Oil
                  :config (fn []
                            (let [oil (autoload :oil)
                                  config {:default_file_explorer true
                                          :delete_to_trash true}]
                              (oil.setup config)))}
                 {1 :nvim-telescope/telescope.nvim
                  :tag :0.1.6
                  :dependencies [:nvim-lua/plenary.nvim]
                  :config (fn []
                            (let [telescope (autoload :telescope)
                                  actions (autoload :telescope.actions)
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
                  :config (fn [] (auto-setup :gitsigns))}
                 {1 :mbbill/undotree
                  :cmd :UndotreeToggle
                  :config (fn []
                            (set vim.g.undotree_WindowLayout 4)
                            (set vim.g.undotree_SetFocusWhenToggle 1))}
                 {1 :alexghergh/nvim-tmux-navigation
                  :event (fn [] (if (vim.fn.exists :$TMUX) :VeryLazy))
                  :config (fn []
                            (let [nav (autoload :nvim-tmux-navigation)
                                  config {:disabled_when_zoomed true
                                          :keybindings {:left :<M-h>
                                                        :down :<M-j>
                                                        :up :<M-k>
                                                        :right :<M-l>}}]
                              (nav.setup config)))}])

(local text-tools
       [{1 :numToStr/Comment.nvim
         :keys :gc
         :config (fn [] (auto-setup :Comment))}
        {1 :kylechui/nvim-surround
         :keys [:cs :ds :ys]
         :config (fn [] (auto-setup :nvim-surround))}])

(local dev-tools [{1 :neovim/nvim-lspconfig
                   :ft [:go :scala]
                   :config (fn [] (auto-setup :juice.lsp))}
                  {1 :scalameta/nvim-metals
                   :cmd :MetalsInit
                   :dependencies [:nvim-lua/plenary.nvim]}
                  {1 :Olical/conjure :ft [:clojure :fennel :lisp :scheme]}
                  {1 :github/copilot.vim
                   :cmd :Copilot
                   :config (fn []
                             (set vim.g.copilot_workspace_folders
                                  [:$WORKSPACE/myshake-backends
                                   :$WORKSPACE/myshake-bc]))}])

(local database-tools
       [{1 :kristijanhusak/vim-dadbod-ui
         :cmd [:DBUI :DBUIToggle]
         :config (fn []
                   (autocmd :FileType
                            {:pattern [:sql :mysql]
                             :callback (fn []
                                         (set-opts {:commentstring "-- %s"
                                                    :omnifunc "vim_dadbod_completion#omni"}))}))
         :dependencies [{1 :tpope/vim-dadbod :lazy true}
                        {1 :kristijanhusak/vim-dadbod-completion
                         :lazy true
                         :ft [:sql :mysql]}]}])

(fn setup []
  (let [lazy (autoload :lazy)
        plugins (concat basic ui-tools text-tools dev-tools database-tools)
        opts {:ui {:border :rounded}
              :performance {:rtp {:disabled_plugins [:rplugin
                                                     :tohtml
                                                     :tutor
                                                     :vimball]}}}]
    (lazy.setup plugins opts)))

{: setup}
