(vim.pack.add ["https://github.com/stevearc/oil.nvim"
               "https://github.com/rmagatti/auto-session"])

(let [{: autoload} (require :nfnl.module)
      autosession (autoload :auto-session)
      str (autoload :nfnl.string)
      oil (autoload :oil)
      autosession-opts {:suppressed_dirs ["/" "~/" :/tmp]
                        :git_use_branch_name true
                        :git_auto_restore_on_branch_change true}
      autosession-sessionoptions [:blank
                                  :buffers
                                  :curdir
                                  :folds
                                  :help
                                  :tabpages
                                  :winsize
                                  :winpos
                                  :terminal
                                  :localoptions]
      oil-opts {:default_file_explorer true
                :delete_to_trash true
                :skip_confirm_for_simple_edits true
                :view_options {:show_hidden true}}]
  (oil.setup oil-opts)
  (vim.keymap.set :n :<leader>e oil.open
                  {:desc "[oil] explore files in current file's path"
                   :silent true})
  (autosession.setup autosession-opts)
  (set vim.o.sessionoptions (str.join "," autosession-sessionoptions)))
