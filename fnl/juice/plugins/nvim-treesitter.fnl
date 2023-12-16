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
                        :incremental_selection {:enable true}
                        :indent {:enable true}
                        })
             ))}
