; -----------------------------------------------------------------------------
; USER COMMANDS & AUTOCOMMANDS
(vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})

; Remember the cursor position of the last editing
(vim.api.nvim_create_autocmd :BufReadPost {:pattern "*"
                                           :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})

(vim.api.nvim_create_autocmd [:BufEnter :BufWritePost] {:pattern "*"
                                                        :callback (fn []
                                                                    (local sl (require :juice.statusline))
                                                                    (sl.git-file-status)
                                                                    (sl.git-branch))})

(vim.api.nvim_create_augroup :highlight-group [])

; highlight yanked text
(vim.api.nvim_create_autocmd :TextYankPost {:group :highlight-group
                                            :pattern "*"
                                            :callback (fn [] (vim.highlight.on_yank {:timeout 200
                                                                                     :on_visual false}))})

; highlight TODO, FIXME and Note: keywords
(vim.api.nvim_create_autocmd [:WinEnter :VimEnter] {:group :highlight-group
                                                    :pattern "*"
                                                    :command ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})

(vim.api.nvim_create_autocmd [:BufWinEnter :InsertLeave] {:group :highlight-group
                                                          :pattern "*"
                                                          :callback (fn []
                                                                      (local c (require :juice.colors))
                                                                      (c.show-extra-whitespace)
                                                                      (vim.cmd "match ExtraWhitespace /\\s\\+$/"))})

(vim.api.nvim_create_autocmd [:BufWinLeave :InsertEnter] {:group :highlight-group
                                                          :pattern "*"
                                                          :command "hi clear ExtraWhitespace"})

(vim.api.nvim_create_augroup :terminal-group [])

; remove signcolumn in terminal mode
(vim.api.nvim_create_autocmd :TermOpen {:group :terminal-group
                                        :pattern "*"
                                        :command "set signcolumn=no"})
