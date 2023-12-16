(module commands
  {import-macros [[ac :aniseed.macros.autocmds]]})

; -----------------------------------------------------------------------------
; USER COMMANDS & AUTOCOMMANDS
(vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})

; Remember the cursor position of the last editing
(ac.autocmd :BufReadPost {:pattern "*"
                          :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})

(ac.augroup :highlight-group
            ; highlight yanked text
            [:TextYankPost {:pattern "*"
                            :callback (fn [] (vim.highlight.on_yank {:timeout 200
                                                                     :on_visual false}))}]

            ; highlight TODO and FIXME keywords
            [[:WinEnter :VimEnter] {:pattern "*"
                                    :command ":silent! call matchadd('Todo','TODO\\|FIXME', -1)"}]

            [[:BufWinEnter :InsertLeave] {:pattern "*"
                                          :callback (fn []
                                                      (vim.cmd "match ExtraWhitespace /\\s\\+$/")
                                                      (vim.cmd  "hi ExtraWhitespace guibg=#dd1111")
                                                      )}]

            [[:BufWinLeave :InsertEnter] {:pattern "*"
                                          :command "hi ExtraWhitespace ctermbg=NONE guibg=NONE"}])

(ac.augroup :terminal-group
            ; remove signcolumn in terminal mode
            [:TermOpen {:pattern "*"
                        :command "set signcolumn=no"}])

