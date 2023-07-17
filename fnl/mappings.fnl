(module mappings
  {autoload {u util}})

(local nmap u.nmap)
(local imap u.imap)
(local vmap u.vmap)
(local tmap u.tmap)
(local noremap u.noremap)
(local silent u.silent)
(local executable? u.executable?)

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(nmap "Y" "y$" [])
(nmap "<F5>" ":make<cr>" [noremap])
(nmap "<leader>w" ":w<cr>" [noremap silent])
(nmap "<leader>n" ":nohl<cr>" [noremap silent])
(nmap "<leader>e" ":Explore<cr><cr>" [noremap silent])

; mark management
(nmap "<leader>mm" ":marks ARST<cr>" [noremap])
(nmap "<leader>a" "`A" [noremap])
(nmap "<leader>r" "`R" [noremap])
(nmap "<leader>s" "`S" [noremap])
(nmap "<leader>t" "`T" [noremap])
(nmap "<leader>ma" "mA:echo 'Marked register A'<cr>" [noremap])
(nmap "<leader>mr" "mR:echo 'Marked register R'<cr>" [noremap])
(nmap "<leader>ms" "mS:echo 'Marked register S'<cr>" [noremap])
(nmap "<leader>mt" "mT:echo 'Marked register T'<cr>" [noremap])

; window management
(nmap "<C-h>" "<C-w>h" [noremap silent])
(nmap "<C-j>" "<C-w>j" [noremap silent])
(nmap "<C-k>" "<C-w>k" [noremap silent])
(nmap "<C-l>" "<C-w>l" [noremap silent])
(nmap "<C-p>" "<C-w>p" [noremap silent])

; buffer management
(nmap "<leader>b" ":buffers<cr>:buffer<Space>" [noremap])
(nmap "<leader>K" ":bfirst<cr>" [noremap silent])
(nmap "<leader>k" ":bprevious<cr>" [noremap silent])
(nmap "<leader>j" ":bnext<cr>" [noremap silent])
(nmap "<leader>J" ":blast<cr>" [noremap silent])
(nmap "<leader>x" ":bp|bdelete #<cr>" [noremap silent])

; terminal management
(tmap "<C-o>" "<C-\\><C-n>" [noremap silent])
(tmap "<C-h>" "<C-\\><C-n><C-w>h" [noremap silent])
(tmap "<C-j>" "<C-\\><C-n><C-w>j" [noremap silent])
(tmap "<C-k>" "<C-\\><C-n><C-w>k" [noremap silent])
(tmap "<C-l>" "<C-\\><C-n><C-w>l" [noremap silent])
(nmap "<leader>ls" ":split term://$SHELL<cr>A" [noremap silent])
(nmap "<leader>lv" ":vsplit term://$SHELL<cr>A" [noremap silent])

; search/replace shortcuts
(nmap "<leader>/s" ":s//g<left><left>" [noremap])
(nmap "<leader>/s" ":%s//g<left><left>" [noremap])
(nmap "<leader>/l" ":.,+s//g<left><left><left><left>" [noremap])
(nmap "<leader>/w" ":s/\\<<c-r><c-w>\\>//g<left><left>" [noremap])
(nmap "<leader>/w" ":%s/\\<<c-r><c-w>\\>//g<left><left>" [noremap])

; date shortcuts
(nmap "<leader>dt" ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>" [noremap])
(nmap "<leader>dT" ":.!date '+\\%a, \\%d \\%b \\%Y' --date=" [])

; open external apps in a new tmux window
(when (executable? "tmux")
  (when (executable? "lazygit")
    (nmap "<leader>lg" ":!tmux neww lazygit<cr>" [noremap silent]))
  (when (executable? "sbtn")
    (nmap "<leader>lS" ":vsplit term://sbtn<cr>" [noremap silent]))
  )

; easier moving of blocks in visual mode
(vmap "<" "<gv" [noremap])
(vmap ">" ">gv" [noremap])

; add undo step when typing sentences
(imap "\"" "\"<C-g>u" [noremap silent])
(imap "." ".<C-g>u" [noremap silent])
(imap "!" "!<C-g>u" [noremap silent])
(imap "?" "?<C-g>u" [noremap silent])
(imap "(" "(<C-g>u" [noremap silent])
(imap ")" ")<C-g>u" [noremap silent])
(imap "{" "{<C-g>u" [noremap silent])
(imap "}" "}<C-g>u" [noremap silent])
(imap "[" "[<C-g>u" [noremap silent])
(imap "]" "]<C-g>u" [noremap silent])

; completion bindings
(vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")  ; select item
