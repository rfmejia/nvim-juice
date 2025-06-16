(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))
(local mappings (autoload :juice.mappings))

(local core-tools
       [{1 :Olical/nfnl
         :ft :fennel
         :config #(set vim.g.conjure#client#fennel#aniseed#deprecation_warning
                       false)}
        {1 :nvim-treesitter/nvim-treesitter
         :event [:BufReadPre :BufNewFile]
         :build ":TSUpdate"
         :config #(let [languages [:bash
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
                    ;; Note: We cannot use `opts` loading for lazy.nvim because
                    ;; we need to call `nvim-treesitter.configs.setup`
                    (util.call :nvim-treesitter.configs :setup config))}
        {1 :stevearc/oil.nvim
         :config #(let [opts {:default_file_explorer true
                              :delete_to_trash true
                              :skip_confirm_for_simple_edits true
                              :view_options {:show_hidden true}}]
                    (util.call :oil :setup opts)
                    (util.set-keys mappings.oil-maps))}])

(local database-tools [(let [sql-filetypes [:sql :mysql :pgsql]]
                         {1 :tpope/vim-dadbod
                          :ft sql-filetypes
                          :config #(vim.api.nvim_create_autocmd :FileType
                                                                {:pattern sql-filetypes
                                                                 :callback #(util.set-keys mappings.dadbod-maps)})
                          :dependencies [{1 :kristijanhusak/vim-dadbod-completion
                                          :lazy true}]})])

(local dev-tools [{1 :neovim/nvim-lspconfig
                   :config #(util.call-setup :juice.lsp)}
                  {1 :scalameta/nvim-metals
                   :cmd :MetalsInit
                   :dependencies [:nvim-lua/plenary.nvim]}])

(local lisp-tools
       (let [languages [:clojure :fennel]]
         [{1 :Olical/conjure
           :branch :main
           :ft languages
           :config #(core.merge! vim.g
                                 {"conjure#result#register" "*"
                                  "conjure#mapping#doc_word" :gk
                                  "conjure#log#botright" true})}
          {1 :julienvincent/nvim-paredit
           :ft languages
           :opts {:use_default_keys true :indent {:enabled true}}
           :dependencies [{1 :nvim-treesitter/nvim-treesitter}]}]))

(local editing-tools
       [{1 :kylechui/nvim-surround :keys [:cs :ds :ys] :config true}
        {1 :windwp/nvim-autopairs
         :event :InsertEnter
         :opts {:enable_check_bracket_line false}}])

(local git-tools
       [{1 :lewis6991/gitsigns.nvim
         :keys :<localleader>gt
         :config (fn []
                   (util.call-setup :gitsigns)
                   (util.set-keys mappings.gitsigns-maps)
                   ;; switch gitsigns off now so it will be switched on after this loading function
                   ;; is finished and the keymap is passed down
                   (util.call :gitsigns :toggle_signs))}])

(local llm-tools
       [{1 :github/copilot.vim
         :cmd :Copilot
         :config (fn []
                   (util.set-keys mappings.copilot-maps)
                   (set vim.g.copilot_workspace_folders
                        (core.distinct (core.concat vim.g.copilot_workspace_folders
                                                    [(vim.fn.getcwd)]))))}
        {1 :olimorris/codecompanion.nvim
         :opts {}
         :dependencies [:nvim-lua/plenary.nvim
                        :nvim-treesitter/nvim-treesitter
                        {1 :ravitemer/mcphub.nvim
                         :build "npm install -g mcp-hub@latest"
                         :config #(util.call-setup :mcphub)}]
         :config #(let [extensions {:mcphub {:callback :mcphub.extensions.codecompanion
                                             :opts {; Show mcp tool results in chat
                                                    :show_result_in_chat true
                                                    ; Convert resources to #variables
                                                    :make_vars true
                                                    ; Add prompts as /slash commands
                                                    :make_slash_commands true}}}]
                    (util.call :codecompanion :setup {: extensions}))}])

(fn setup []
  (let [plugins (core.concat core-tools database-tools dev-tools editing-tools
                             git-tools lisp-tools llm-tools)
        opts {:ui {:border :rounded}
              :performance {:rtp {:disabled_plugins [:rplugin
                                                     :tohtml
                                                     :tutor
                                                     :vimball]}}}]
    (util.call :lazy :setup plugins opts)))

{: setup}
