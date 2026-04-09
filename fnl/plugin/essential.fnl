(vim.pack.add ["https://github.com/nvim-treesitter/nvim-treesitter"
               "https://github.com/stevearc/oil.nvim"])

(let [{: autoload} (require :nfnl.module)
      oil (autoload :oil)
      oil-opts {:default_file_explorer true
                :delete_to_trash true
                :skip_confirm_for_simple_edits true
                :view_options {:show_hidden true}}]
  (oil.setup oil-opts)
  (vim.keymap.set :n :<leader>e oil.open
                  {:desc "[oil] explore files in current file's path"
                   :silent true})
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern [:clojure
                                          :fennel
                                          :java
                                          :lua
                                          :markdown
                                          :scala]
                                :callback (fn []
                                            (vim.treesitter.start)
                                            (set vim.bo.indentexpr
                                                 "v:lua.require'nvim-treesitter'.indentexpr()"))}))
