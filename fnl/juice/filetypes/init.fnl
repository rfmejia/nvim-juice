(module filetypes
  {import-macros [[ac :aniseed.macros.autocmds]]})

(vim.cmd "filetype plugin on")
(ac.augroup :ftplugins-group
            [:FileType {:pattern "fennel"
                        :callback (fn [] (require "juice.filetypes.fennel"))}]
            [:FileType {:pattern "markdown"
                        :callback (fn [] (require "juice.filetypes.markdown"))}]
            [:FileType {:pattern "scala"
                        :callback (fn [] (require "juice.filetypes.scala"))}]
            [:FileType {:pattern "go"
                        :callback (fn [] (require "juice.filetypes.go"))}]
            )

;; TODO Investigate if you can generalize the autogroups by listing files in
;; this directory, filter `init.fnl`, and produce a `FileType` data structure
