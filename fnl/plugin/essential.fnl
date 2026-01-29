(let [{: autoload} (require :nfnl.module)
      pacman (autoload :pacman)
      packs [{:src "https://github.com/nvim-treesitter/nvim-treesitter"
              :version :master}
             "https://github.com/stevearc/oil.nvim"]
      util (autoload :juice.util)
      treesitter-opts {:highlight {:enable true} :indent {:enable true}}
      oil-opts {:default_file_explorer true
                :delete_to_trash true
                :skip_confirm_for_simple_edits true
                :view_options {:show_hidden true}}]
  (comment "NOTE For nvim-treesitter, the `main` branch is an in-progress
           backward-incompatible rewrite, set branch to `master` until rewrite
           is complete")
  (pacman.add packs)
  (pacman.load-now [:nvim-treesitter :oil.nvim])
  (util.call :nvim-treesitter.configs :setup treesitter-opts)
  (util.call :oil :setup oil-opts)
  (vim.keymap.set :n :<leader>e #(util.call :oil :open)
                  {:desc "[oil] explore files in current file's path"
                   :silent true}))
