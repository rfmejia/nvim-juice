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
(nmap "<C-m>" ":make<cr>" [noremap])
(nmap "<leader>w" ":w<cr>" [noremap silent])
(nmap "<leader>n" "<C-6>" [noremap silent])
(nmap "<C-l>" ":nohl<cr>" [noremap])
(nmap "<leader>e" ":Dirvish<cr>" [noremap silent])
(nmap "gx" ":!xdg-open <C-r><C-a><cr>" [noremap])

(nmap "<C-d>" "<C-d>zz" [noremap silent])
(nmap "<C-u>" "<C-u>zz" [noremap silent])
(nmap "<C-o>" "<C-o>zz" [noremap silent])
(nmap "<C-i>" "<C-i>zz" [noremap silent])

; Disable default mappings to train optimal alternatives
(nmap "{" (fn [] (print "Use C-u or relative jumps instead")) [noremap silent])
(nmap "}" (fn [] (print "Use C-d or relative jumps instead")) [noremap silent])
(nmap "0" (fn [] (print "Use _ instead")) [noremap silent])

; Map omnifunc 
(imap "<C-t>" "<C-x><C-o>" [noremap silent])

; mark management
(nmap "<leader>mm" ":marks ARST<cr>" [noremap])
(nmap "<leader>a" "`Azz" [noremap])
(nmap "<leader>r" "`Rzz" [noremap])
(nmap "<leader>s" "`Szz" [noremap])
(nmap "<leader>t" "`Tzz" [noremap])
(nmap "<leader>ma" "mA:echo 'Marked register A'<cr>" [noremap])
(nmap "<leader>mr" "mR:echo 'Marked register R'<cr>" [noremap])
(nmap "<leader>ms" "mS:echo 'Marked register S'<cr>" [noremap])
(nmap "<leader>mt" "mT:echo 'Marked register T'<cr>" [noremap])

; window management
(nmap "<M-h>" "<C-w>h" [noremap silent])
(nmap "<M-j>" "<C-w>j" [noremap silent])
(nmap "<M-k>" "<C-w>k" [noremap silent])
(nmap "<M-l>" "<C-w>l" [noremap silent])
(nmap "<C-p>" "<C-w>p" [noremap silent])

; buffer management
(nmap "<leader>b" ":buffers<cr>:buffer<Space>" [noremap])
(nmap "[B" ":bfirst<cr>" [noremap silent])
(nmap "]B" ":blast<cr>" [noremap silent])
(nmap "[b" ":bprevious<cr>" [noremap silent])
(nmap "]b" ":bnext<cr>" [noremap silent])
(nmap "<leader>x" ":bp|bdelete #<cr>" [noremap silent])

; quickfix
(nmap "<leader>q" (u.lua-cmd "require('juice.quickfix')['toggle-qf-window']()") [noremap])
(nmap "<leader>Q" (u.lua-cmd "require('juice.quickfix')['toggle-loclist-window']()") [noremap])
(nmap "[q" ":cprevious" [noremap])
(nmap "]q" ":cnext" [noremap])
(nmap "[Q" ":cfirst" [noremap])
(nmap "]Q" ":clast" [noremap])
(nmap "[l" ":lprevious" [noremap])
(nmap "]l" ":lnext" [noremap])
(nmap "[L" ":lfirst" [noremap])
(nmap "]L" ":llast" [noremap])

; search/replace shortcuts
(nmap "<leader>/s" ":s//g<left><left>" [noremap])
(nmap "<leader>/s" ":%s//g<left><left>" [noremap])
(nmap "<leader>/l" ":.,+s//g<left><left><left><left>" [noremap])
(nmap "<leader>/w" ":s/\\<<c-r><c-w>\\>//g<left><left>" [noremap])
(nmap "<leader>/W" ":%s/\\<<c-r><c-w>\\>//g<left><left>" [noremap])

; date shortcuts
(nmap "<leader>dt" ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>" [noremap])
(nmap "<leader>dT" ":.!date '+\\%a, \\%d \\%b \\%Y' --date=" [])

; open external apps in a new tmux window
(when (executable? "tmux")
  (when (executable? "lazydocker")
    (nmap "<leader>ld" ":!tmux neww lazydocker<cr><cr>" [noremap silent]))
  (when (executable? "lazygit")
    (nmap "<leader>lg" ":!tmux neww lazygit<cr><cr>" [noremap silent]))
  (when (executable? "sbtn")
    (nmap "<leader>ls" ":vsplit term://sbtn<cr><cr>" [noremap silent]))
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
