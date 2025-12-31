(local filetypes {:extension {:avsc :json
                              :edn :clojure
                              :mill :scala
                              :mysql :sql
                              :pgsql :sql
                              :sbt :scala
                              :sc :scala
                              :service :systemd
                              :tofu :hcl
                              :txt :text}
                  :filename {:.envrc :bash
                             :Jenkinsfile :groovy
                             :tmux.conf :tmux}
                  :pattern {"openapi.*%.yaml" :yaml.openapi
                            "openapi.*%.json" :json.openapi}})

{:setup #(vim.filetype.add filetypes)}
