(module filetypes
  {autoload {u util}
   import-macros [[ac :aniseed.macros.autocmds]]})

(vim.cmd "filetype plugin on")

(ac.augroup :ftplugins-group
            [[:BufNewFile :BufRead] {:pattern [:*.txt :*.text]
                                     :command "setf text"}]
            [[:BufNewFile :BufRead] {:pattern [:*bash_profile :*.bash]
                                     :command "setf bash"}]
            [[:BufNewFile :BufRead] {:pattern :tmux.conf
                                     :command "setf tmux"}]
            [[:BufNewFile :BufRead] {:pattern [:*.sbt :*.sc]
                                     :command "set ft=scala"}]
            [[:BufNewFile :BufRead] {:pattern :Jenkinsfile
                                     :command "set ft=groovy"}]

            [:FileType {:pattern [:sh :bash]
                        :callback (fn [] (require "juice.filetypes.bash"))}]
            [:FileType {:pattern :fennel
                        :callback (fn [] (require "juice.filetypes.fennel"))}]
            [:FileType {:pattern :go
                        :callback (fn [] (require "juice.filetypes.go"))}]
            [:FileType {:pattern :mail
                        :callback (fn [] (require "juice.filetypes.mail"))}]
            [:FileType {:pattern :markdown
                        :callback (fn [] (require "juice.filetypes.markdown"))}]
            [:FileType {:pattern :scala
                        :callback (fn [] (require "juice.filetypes.scala"))}]

            [:FileType {:pattern :netrw
                        :callback (fn []
                                    ; Note: some options were removed due to a bug
                                    ; https://github.com/neovim/neovim/issues/23650#issuecomment-1863894217
                                    (set vim.g.netrw_altfile 1)        ; C-^ skips netrw (return to last edited file)
                                    (set vim.g.netrw_sort_by :exten)  ; sort by extension
                                    (set vim.g.netrw_sort_options :i) ; add sort options (i = ignore case)
                                    (u.nmap "?" ":h netrw-quickmap<CR>" [:noremap]))
                        }]
            )

;; TODO Investigate if you can generalize the autogroups by listing files in
;; this directory, filter `init.fnl`, and produce a `FileType` data structure
