(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))
(local mappings (autoload :juice.mappings))

(local core-tools [{1 :Olical/nfnl :ft :fennel}
                   {1 :projekt0n/github-nvim-theme
                    :lazy false
                    :priority 1000
                    :config #(util.auto-setup :juice.colors)}
                   {1 :nvim-treesitter/nvim-treesitter
                    :event [:BufReadPre :BufNewFile]
                    :build ":TSUpdate"
                    :config #(let [ts (autoload :nvim-treesitter.configs)
                                   languages [:bash
                                              :clojure
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
                               (ts.setup config))}])

(local database-tools
       [{1 :kristijanhusak/vim-dadbod-ui
         :cmd [:DBUI :DBUIToggle]
         :config #(vim.api.nvim_create_autocmd :FileType
                                               {:pattern [:sql :mysql]
                                                :callback #(util.set-opts {:commentstring "-- %s"
                                                                           :omnifunc "vim_dadbod_completion#omni"})})
         :dependencies [{1 :tpope/vim-dadbod :lazy true}
                        {1 :kristijanhusak/vim-dadbod-completion
                         :lazy true
                         :ft [:sql :mysql]}]}])

(local dev-tools [{1 :neovim/nvim-lspconfig
                   :ft [:clojure :java :go :scala]
                   :config #(util.auto-setup :juice.lsp)}
                  {1 :scalameta/nvim-metals
                   :cmd :MetalsInit
                   :dependencies [:nvim-lua/plenary.nvim]}])

(local lisp-tools
       (let [languages [:clojure :fennel]]
         [{1 :Olical/conjure
           :ft languages
           :config (fn []
                     (set vim.g.conjure#result#register "*")
                     (set vim.g.conjure#mapping#doc_word :gk)
                     (set vim.g.conjure#log#botright true))}
          {1 :julienvincent/nvim-paredit
           :ft languages
           :opts {:use_default_keys true :indent {:enabled true}}}
          {1 :julienvincent/nvim-paredit-fennel
           :ft :fennel
           :config true
           :dependencies :julienvincent/nvim-paredit}]))

(local editing-tools
       [{1 :kylechui/nvim-surround :keys [:cs :ds :ys] :config true}
        {1 :windwp/nvim-autopairs
         :event :InsertEnter
         :opts {:enable_check_bracket_line false}}
        {1 :mbbill/undotree
         :cmd :UndotreeToggle
         :config (fn []
                   (set vim.g.undotree_WindowLayout 4)
                   (set vim.g.undotree_SetFocusWhenToggle 1))}])

(local file-tools [{1 :stevearc/oil.nvim
                    :cmd :Oil
                    :keys :<leader>e
                    :config #(let [oil (autoload :oil)
                                   opts {:default_file_explorer true
                                         :delete_to_trash true
                                         :skip_confirm_for_simple_edits true
                                         :view_options {:show_hidden true}}]
                               (oil.setup opts)
                               (mappings.oil-maps))}
                   {1 :nvim-telescope/telescope.nvim
                    :tag :0.1.6
                    :keys [:<leader>f :<leader>p :<leader>g :<leader>k]
                    :cmd :Telescope
                    :dependencies [:nvim-lua/plenary.nvim]
                    :config (fn []
                              (let [telescope (autoload :telescope)
                                    actions (autoload :telescope.actions)
                                    opts {:defaults {:border false
                                                     :layout_config {:prompt_position :bottom
                                                                     :height 0.4}
                                                     :layout_strategy :bottom_pane
                                                     :mappings {:i {:<esc> actions.close
                                                                    :<C-u> false}}
                                                     :path_display {1 :truncate}
                                                     :preview false
                                                     :prompt_prefix "/"
                                                     :prompt_title :test}}]
                                (telescope.setup opts)
                                (mappings.telescope-maps)))}])

(local git-tools [{1 :lewis6991/gitsigns.nvim
                   :event [:BufReadPre :BufNewFile]
                   :config (fn []
                             (let [gitsigns (autoload :gitsigns)]
                               (gitsigns.setup)
                               (mappings.gitsigns-maps)))}
                  {1 :NeogitOrg/neogit
                   :cmd :Neogit
                   :keys :<leader>og
                   :dependencies [{1 :nvim-lua/plenary.nvim}
                                  {1 :sindrets/diffview.nvim}
                                  {1 :nvim-telescope/telescope.nvim}]
                   :config (fn []
                             (let [neogit (autoload :neogit)]
                               (neogit.setup)
                               (mappings.neogit-maps)))}])

(fn setup []
  (let [lazy (autoload :lazy)
        plugins (core.concat core-tools database-tools dev-tools editing-tools
                             file-tools git-tools lisp-tools)
        opts {:ui {:border :rounded}
              :performance {:rtp {:disabled_plugins [:rplugin
                                                     :tohtml
                                                     :tutor
                                                     :vimball]}}}]
    (lazy.setup plugins opts)))

{: setup}
