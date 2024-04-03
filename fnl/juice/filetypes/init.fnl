(vim.cmd "filetype plugin on")

(vim.api.nvim_create_augroup :ftplugins-group [])

(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group :ftplugins-group
                                                     :pattern [:*.txt :*.text]
                                                     :command "setf text"})
(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group :ftplugins-group
                                                     :pattern [:*bash_profile :*.bash]
                                                     :command "setf bash"})
(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group :ftplugins-group
                                                     :pattern :tmux.conf
                                                     :command "setf tmux"})
(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group :ftplugins-group
                                                     :pattern [:*.sbt :*.sc]
                                                     :command "set ft=scala"})
(vim.api.nvim_create_autocmd [:BufNewFile :BufRead] {:group :ftplugins-group
                                                     :pattern :Jenkinsfile
                                                     :command "set ft=groovy"})

(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern [:sh :bash]
                                        :callback (fn [] (require "juice.filetypes.bash"))})
(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :fennel
                                        :callback (fn [] (require "juice.filetypes.fennel"))})
(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :go
                                        :callback (fn [] (require "juice.filetypes.go"))})
(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :mail
                                        :callback (fn [] (require "juice.filetypes.mail"))})
(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :asciidoc
                                        :callback (fn [] (require "juice.filetypes.asciidoc"))})
(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :markdown
                                        :callback (fn [] (require "juice.filetypes.markdown"))})
(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :scala
                                        :callback (fn [] (require "juice.filetypes.scala"))})

(vim.api.nvim_create_autocmd :FileType {:group :ftplugins-group
                                        :pattern :netrw
                                        :callback (fn []
                                                    (local u (require :util))
                                                    ; Note: some options were removed due to a bug
                                                    ; https://github.com/neovim/neovim/issues/23650#issuecomment-1863894217
                                                    (set vim.g.netrw_altfile 1)        ; C-^ skips netrw (return to last edited file)
                                                    (set vim.g.netrw_sort_by :exten)  ; sort by extension
                                                    (set vim.g.netrw_sort_options :i) ; add sort options (i = ignore case)
                                                    (u.nmap "?" ":h netrw-quickmap<CR>" [:noremap]))
                                        })

;; TODO Investigate if you can generalize the autogroups by listing files in
;; this directory, filter `init.fnl`, and produce a `FileType` data structure
