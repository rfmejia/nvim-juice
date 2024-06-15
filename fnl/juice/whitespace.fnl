(local {: autoload} (require :nfnl.module))
(local colors (autoload :juice.colors))

(fn setup []
  (vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})
  (vim.api.nvim_create_autocmd [:BufWinEnter :InsertLeave]
                               {:group :highlight-group
                                :pattern "*"
                                :callback (fn []
                                            (colors.show-extra-whitespace)
                                            (vim.cmd "match ExtraWhitespace /\\s\\+$/"))})
  (vim.api.nvim_create_autocmd [:BufWinLeave :InsertEnter]
                               {:group :highlight-group
                                :pattern "*"
                                :command "hi clear ExtraWhitespace"}))

{: setup}
