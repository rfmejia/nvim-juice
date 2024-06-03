(local {: autoload} (require :nfnl.module))
(local {: concat} (autoload :nfnl.core))
(local {: auto-setup : nmap : set-opts} (autoload :juice.util))

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

(local database-tools
       [{1 :kristijanhusak/vim-dadbod-ui
         :cmd [:DBUI :DBUIToggle]
         :config #(vim.api.nvim_create_autocmd :FileType
                                               {:pattern [:sql :mysql]
                                                :callback #(set-opts {:commentstring "-- %s"
                                                                      :omnifunc "vim_dadbod_completion#omni"})})
         :dependencies [{1 :tpope/vim-dadbod :lazy true}
                        {1 :kristijanhusak/vim-dadbod-completion
                         :lazy true
                         :ft [:sql :mysql]}]}])

(local dev-tools
       [{1 :neovim/nvim-lspconfig :config #(auto-setup :juice.lsp)}
        {1 :scalameta/nvim-metals
         :cmd :MetalsInit
         :dependencies [:nvim-lua/plenary.nvim]}
        {1 :Olical/conjure :ft [:clojure :fennel :lisp :scheme]}])

(local editing-tools
       [{1 :kylechui/nvim-surround :keys [:cs :ds :ys] :config true}
        {1 :mbbill/undotree
         :cmd :UndotreeToggle
         :config (fn []
                   (set vim.g.undotree_WindowLayout 4)
                   (set vim.g.undotree_SetFocusWhenToggle 1))}])

(local file-tools [{1 :stevearc/oil.nvim
                    :cmd :Oil
                    :config {:default_file_explorer true :delete_to_trash true}}
                   {1 :nvim-telescope/telescope.nvim
                    :tag :0.1.6
                    :dependencies [:nvim-lua/plenary.nvim]
                    :config (fn []
                              (let [telescope (autoload :telescope)
                                    actions (autoload :telescope.actions)
                                    config {:defaults {:border false
                                                       :layout_config {:prompt_position :bottom
                                                                       :height 0.4}
                                                       :layout_strategy :bottom_pane
                                                       :mappings {:i {:<esc> actions.close
                                                                      :<C-u> false}}
                                                       :path_display {1 :truncate}
                                                       :preview false
                                                       :prompt_prefix "/"
                                                       :prompt_title :test}}]
                                (telescope.setup config)))}])

(local git-tools [{1 :lewis6991/gitsigns.nvim
                   :event [:BufReadPre :BufNewFile]
                   :config true}
                  {1 :NeogitOrg/neogit
                   :dependencies [{1 :nvim-lua/plenary.nvim}
                                  {1 :sindrets/diffview.nvim}
                                  {1 :nvim-telescope/telescope.nvim}]
                   :config true}])

(local vim-fu [{1 :m4xshen/hardtime.nvim
                :dependencies [{1 :MunifTanjim/nui.nvim}
                               {1 :nvim-lua/plenary.nvim}]
                :config true}])

(fn setup []
  (let [lazy (autoload :lazy)
        plugins (concat core database-tools dev-tools editing-tools file-tools
                        git-tools vim-fu)
        opts {:ui {:border :rounded}
              :performance {:rtp {:disabled_plugins [:rplugin
                                                     :tohtml
                                                     :tutor
                                                     :vimball]}}}]
    (lazy.setup plugins opts)))

{: setup}
