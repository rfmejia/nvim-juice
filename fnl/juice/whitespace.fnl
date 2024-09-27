(local {: autoload} (require :nfnl.module))
(local colors (autoload :juice.colors))

(fn setup []
  (let [hi-cmd "hi ExtraWhitespace cterm=undercurl ctermfg=red"
        match-all-cmd "match ExtraWhitespace /\\s\\+$/"
        match-partial-cmd "match ExtraWhitespace /\\s\\+\\%#\\@<!$/"
        clear-matches-cmd "call clearmatches()"]
    (vim.cmd hi-cmd)
    (vim.cmd match-all-cmd)
    (vim.api.nvim_create_augroup :whitespace-group [])
    (vim.api.nvim_create_autocmd :ColorScheme
                                 {:group :whitespace-group
                                  :pattern "*"
                                  :command hi-cmd})
    (vim.api.nvim_create_autocmd [:BufWinEnter :InsertLeave]
                                 {:group :whitespace-group
                                  :pattern "*"
                                  :command match-all-cmd})
    (vim.api.nvim_create_autocmd :InsertEnter
                                 {:group :whitespace-group
                                  :pattern "*"
                                  :command match-partial-cmd})
    (vim.api.nvim_create_autocmd :BufWinLeave
                                 {:group :whitespace-group
                                  :pattern "*"
                                  :command clear-matches-cmd})
    (vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})))

{: setup}
