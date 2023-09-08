(module filetypes
  {import-macros [[ac :aniseed.macros.autocmds]]})

(vim.cmd "filetype plugin on")
(ac.augroup :ftplugins-group
            [:FileType {:pattern "markdown"
                        :callback (fn [] (require "juice.filetypes.markdown"))}]
            [:FileType {:pattern "scala"
                        :callback (fn [] (require "juice.filetypes.scala"))}]
            )

