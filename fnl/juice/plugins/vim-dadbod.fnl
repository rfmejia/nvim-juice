{1 "tpope/vim-dadbod"
 :cmd "DB"
 :config (fn []
           (ac.autocmd :FileType {:pattern ["sql" "mysql"]
                                  :callback (fn []
                                              (set vim.opt.omnifunc "vim_dadbod_completion#omni"))})
           )
 :dependencies [{1 "kristijanhusak/vim-dadbod-completion"}]}
