{:* {:root_markers [:.git]}
 :clojure_lsp {:cmd [:clojure-lsp]
               :filetypes [:clojure :edn]
               :single_file_support true}
 :fennel_ls {:cmd [:fennel-ls]
             :filetypes [:fennel]
             :single_file_support true
             :capabilities {:offsetEncoding [:utf-8 :utf-16]}
             :root_markers [:.git :flsproject.fnl]}
 :jdtls (require :juice.lsp.jdtls)
 :gopls {:cmd [:gopls]
         :filetypes [:go :gomod :gowork :gotmpl]
         :single_file_support true}
 :vacuum {:cmd [:vacuum :language-server]
          :filetypes [:yaml.openapi :json.openapi]
          :single_file_support true}}
