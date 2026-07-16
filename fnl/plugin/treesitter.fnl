(vim.pack.add ["https://github.com/nvim-treesitter/nvim-treesitter"])

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
                                               "v:lua.require'nvim-treesitter'.indentexpr()"))})
