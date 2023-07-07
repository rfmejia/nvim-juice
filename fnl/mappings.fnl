(module mappings
  {autoload {u util}})

(local nmap u.nmap)
(local imap u.imap)
(local vmap u.vmap)
(local noremap u.noremap)
(local silent u.silent)

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(nmap "Y" "y$" [])
(nmap "<F5>" ":make<cr>" [noremap])
(nmap "<leader>w" ":w<cr>" [noremap silent])
(nmap "<C-l>" ":nohl<cr>" [noremap silent])
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

; buffer management
(nmap "<leader>b" ":buffers<cr>:buffer<Space>" [noremap])
(nmap "<leader>K" ":bfirst<cr>" [noremap silent])
(nmap "<leader>k" ":bprevious<cr>" [noremap silent])
(nmap "<leader>j" ":bnext<cr>" [noremap silent])
(nmap "<leader>J" ":blast<cr>" [noremap silent])
(nmap "<leader>x" ":bp|bdelete #<cr>" [noremap silent])

; search/replace shortcuts
(nmap "<leader>/s" ":s//g<LEFT><LEFT>" [noremap])
(nmap "<leader>/S" ":%s//g<LEFT><LEFT>" [noremap])
(nmap "<leader>/l" ":.,+s//g<LEFT><LEFT><LEFT><LEFT>" [noremap])
(nmap "<leader>/w" ":s/\\<<C-r><c-w>\\>//g<LEFT><LEFT>" [noremap])
(nmap "<leader>/W" ":%s/\\<<C-r><C-w>\\>//g<LEFT><LEFT>" [noremap])

; date shortcuts
(nmap "<leader>dt" ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>" [noremap])
(nmap "<leader>dT" ":.!date '+\\%a, \\%d \\%b \\%Y' --date=" [])

; open external apps in a new tmux window
(let [executable? (lambda [cmd] (= (vim.fn.executable cmd) 1))]
  (when (executable? "tmux")
    (when (executable? "lazygit")
      (nmap "<leader>lg" ":!tmux neww lazygit<cr><cr>" [noremap silent]))
    (when (executable? "sbtn")
      (nmap "<leader>ls" ":!tmux neww sbtn<cr><cr>" [noremap silent]))))

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
