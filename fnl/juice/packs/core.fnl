(local {: autoload} (require :nfnl.module))
(local pack (autoload :pack))
(local util (autoload :juice.util))

(comment "NOTE For nvim-treesitter, the `main` branch is an in-progress
           backward-incompatible rewrite, set branch to `master` until rewrite
           is complete")

{:setup (fn []
          (pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter"
                      :version :master}
                     "https://github.com/stevearc/oil.nvim"])
          (pack.load-now [:nvim-treesitter :oil.nvim])
          (util.call :nvim-treesitter.configs :setup
                     {:highlight {:enable true} :indent {:enable true}})
          (util.call :oil :setup
                     {:default_file_explorer true
                      :delete_to_trash true
                      :skip_confirm_for_simple_edits true
                      :view_options {:show_hidden true}})
          (vim.keymap.set :n :<leader>e #(util.call :oil :open)
                          {:desc "[oil] explore files in current file's path"
                           :silent true}))}
