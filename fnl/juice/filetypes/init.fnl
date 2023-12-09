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
            [:FileType {:pattern ["sh" "bash"]
                        :callback (fn [] (require "juice.filetypes.bash"))}]
            [:FileType {:pattern "dirvish"
                        :callback (fn []
                                    ; Hide hidden files by default
                                    ; `u` undos this effect, `R` reloads the buffer
                                    (set vim.opt_local.spell false)
                                    (vim.cmd "keeppatterns g@\\v/\\.[^\\/]+/?$@d _"))}]
            )

;; TODO Investigate if you can generalize the autogroups by listing files in
;; this directory, filter `init.fnl`, and produce a `FileType` data structure
