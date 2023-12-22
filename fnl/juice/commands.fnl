(module commands
  {autoload {c juice.colors}
   import-macros [[ac :aniseed.macros.autocmds]]})

; -----------------------------------------------------------------------------
; USER COMMANDS & AUTOCOMMANDS
(vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})

; Remember the cursor position of the last editing
(ac.autocmd :BufReadPost {:pattern "*"
                          :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})

(ac.autocmd [:BufEnter :BufWritePost] {:pattern "*"
                                       :callback (. (require :juice.statusline) :git-file-status)
                                       })

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
                                                      (c.show-extra-whitespace))}]

            [[:BufWinLeave :InsertEnter] {:pattern "*"
                                          :command "hi clear ExtraWhitespace"}])

(ac.augroup :terminal-group
            ; remove signcolumn in terminal mode
            [:TermOpen {:pattern "*"
                        :command "set signcolumn=no"}])

