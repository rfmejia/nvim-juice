(local {: autoload} (require :nfnl.module))
(local {: show-extra-whitespace} (autoload :juice.colors))

(fn setup []
  (vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})
  (comment "Remember the cursor position of the last editing")
  (vim.api.nvim_create_autocmd :BufReadPost
                               {:pattern "*"
                                :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  (vim.api.nvim_create_augroup :highlight-group [])
  (comment "highlight yanked text")
  (vim.api.nvim_create_autocmd :TextYankPost
                               {:group :highlight-group
                                :pattern "*"
                                :callback #(vim.highlight.on_yank {:timeout 200
                                                                   :on_visual false})})
  (comment "highlight TODO, FIXME and Note: keywords")
  (vim.api.nvim_create_autocmd [:WinEnter :VimEnter]
                               {:group :highlight-group
                                :pattern "*"
                                :command ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  (vim.api.nvim_create_autocmd [:BufWinEnter :InsertLeave]
                               {:group :highlight-group
                                :pattern "*"
                                :callback (fn []
                                            (show-extra-whitespace)
                                            (vim.cmd "match ExtraWhitespace /\\s\\+$/"))})
  (vim.api.nvim_create_autocmd [:BufWinLeave :InsertEnter]
                               {:group :highlight-group
                                :pattern "*"
                                :command "hi clear ExtraWhitespace"})
  (vim.api.nvim_create_augroup :terminal-group [])
  (comment "remove signcolumn in terminal mode")
  (vim.api.nvim_create_autocmd :TermOpen
                               {:group :terminal-group
                                :pattern "*"
                                :command "set signcolumn=no"}))

{: setup}
