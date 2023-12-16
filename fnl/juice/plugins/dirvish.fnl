{1 "justinmk/vim-dirvish"
 :cmd :Dirvish
 :config (fn []
           (set vim.g.loaded_netrw 1)
           (set vim.g.loaded_netrwPlugin 1)
           ; Sort by file/dir type, and then hidden files/dirs
           (vim.cmd "let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'"))}
