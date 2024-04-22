(local {: autoload} (require :nfnl.module))
(local {: show-extra-whitespace} (autoload :juice.colors))
(local {: git-branch : git-file-status} (autoload :juice.statusline))
(local {: augroup : autocmd} (autoload :juice.util))

(fn setup []
  (vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})
  (comment "Remember the cursor position of the last editing")
  (autocmd :BufReadPost
           {:pattern "*" :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  (autocmd [:BufEnter :BufWritePost]
           {:pattern "*"
            :callback (fn []
                        (git-file-status)
                        (git-branch))})
  (augroup :highlight-group [])
  (comment "highlight yanked text")
  (autocmd :TextYankPost
           {:group :highlight-group
            :pattern "*"
            :callback (fn []
                        (vim.highlight.on_yank {:timeout 200 :on_visual false}))})
  (comment "highlight TODO, FIXME and Note: keywords")
  (autocmd [:WinEnter :VimEnter]
           {:group :highlight-group
            :pattern "*"
            :command ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  (autocmd [:BufWinEnter :InsertLeave]
           {:group :highlight-group
            :pattern "*"
            :callback (fn []
                        (show-extra-whitespace)
                        (vim.cmd "match ExtraWhitespace /\\s\\+$/"))})
  (autocmd [:BufWinLeave :InsertEnter]
           {:group :highlight-group
            :pattern "*"
            :command "hi clear ExtraWhitespace"})
  (augroup :terminal-group [])
  (comment "remove signcolumn in terminal mode")
  (autocmd :TermOpen {:group :terminal-group
                      :pattern "*"
                      :command "set signcolumn=no"}))

{: setup}
