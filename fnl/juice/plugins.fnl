(local {: autoload} (require :nfnl.module))
(local {: concat} (autoload :nfnl.core))
(local {: autocmd : auto-setup : set-opts} (autoload :juice.util))

(local core [{1 :Olical/nfnl :ft :fennel}
             {1 :projekt0n/github-nvim-theme
              :lazy false
              :priority 1000
              :config #(auto-setup :juice.colors)}
             {1 :nvim-treesitter/nvim-treesitter
              :event [:BufReadPre :BufNewFile]
              :build ":TSUpdate"
              :config (fn []
                        (let [ts (autoload :nvim-treesitter.configs)
                              languages [:bash
                                         :fennel
                                         :gitcommit
                                         :go
                                         :hocon
                                         :java
                                         :json
                                         :lua
                                         :markdown
                                         :scala
                                         :sql
                                         :vimdoc
                                         :yaml]
                              config {:ensure_installed languages
                                      :highlight {:enable true}
                                      :indent {:enable true}}]
                          (ts.setup config)))}])

(local ui-tools
       [{1 :stevearc/oil.nvim
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
                                            :prompt_prefix "/"}}]
                     (telescope.setup config)))}
        {1 :lewis6991/gitsigns.nvim
         :event [:BufReadPre :BufNewFile]
         :config true}
        {1 :mbbill/undotree
         :cmd :UndotreeToggle
         :config (fn []
                   (set vim.g.undotree_WindowLayout 4)
                   (set vim.g.undotree_SetFocusWhenToggle 1))}])

(local text-tools
       [{1 :kylechui/nvim-surround :keys [:cs :ds :ys] :config true}])

(local dev-tools
       [{1 :neovim/nvim-lspconfig :config #(auto-setup :juice.lsp)}
        {1 :scalameta/nvim-metals
         :cmd :MetalsInit
         :dependencies [:nvim-lua/plenary.nvim]}
        {1 :Olical/conjure :ft [:clojure :fennel :lisp :scheme]}])

(local database-tools
       [{1 :kristijanhusak/vim-dadbod-ui
         :cmd [:DBUI :DBUIToggle]
         :config #(autocmd :FileType
                           {:pattern [:sql :mysql]
                            :callback #(set-opts {:commentstring "-- %s"
                                                  :omnifunc "vim_dadbod_completion#omni"})})
         :dependencies [{1 :tpope/vim-dadbod :lazy true}
                        {1 :kristijanhusak/vim-dadbod-completion
                         :lazy true
                         :ft [:sql :mysql]}]}])

(local test-tools [{1 :echasnovski/mini.notify
                    :config #(auto-setup :mini.notify)}])

(fn setup []
  (let [lazy (autoload :lazy)
        plugins (concat core ui-tools text-tools dev-tools database-tools
                        test-tools)
        opts {:ui {:border :rounded}
              :performance {:rtp {:disabled_plugins [:rplugin
                                                     :tohtml
                                                     :tutor
                                                     :vimball]}}}]
    (lazy.setup plugins opts)))

{: setup}
