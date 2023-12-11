(module mappings
  {autoload {u util}})

(local noremap u.noremap)
(local silent u.silent)

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(u.nmap "Y" "y$" [])
(u.nmap "<C-m>" ":make<cr>" [noremap])
(u.nmap "<leader>w" ":w<cr>" [noremap silent])
(u.nmap "<leader>n" "<C-6>" [noremap silent])
(u.nmap "<C-l>" ":nohl<cr>" [noremap])
(u.nmap "<leader>e" ":Dirvish<cr>" [noremap silent])
(u.nmap "gx" ":!xdg-open <C-r><C-a><cr>" [noremap])

(u.nmap "<C-d>" "<C-d>zz" [noremap silent])
(u.nmap "<C-u>" "<C-u>zz" [noremap silent])
(u.nmap "<C-o>" "<C-o>zz" [noremap silent])
(u.nmap "<C-i>" "<C-i>zz" [noremap silent])

; Disable default mappings to train optimal alternatives
(u.nmap "{" (fn [] (print "Use C-u or relative jumps instead")) [noremap silent])
(u.nmap "}" (fn [] (print "Use C-d or relative jumps instead")) [noremap silent])
(u.nmap "0" (fn [] (print "Use _ instead")) [noremap silent])

; Map omnifunc
(u.imap "<C-t>" "<C-x><C-o>" [noremap silent])

; mark management
(u.nmap "<leader>mm" ":marks ARST<cr>" [noremap])
(u.nmap "<leader>a" "`Azz" [noremap])
(u.nmap "<leader>r" "`Rzz" [noremap])
(u.nmap "<leader>s" "`Szz" [noremap])
(u.nmap "<leader>t" "`Tzz" [noremap])
(u.nmap "<leader>ma" "mA:echo 'Marked register A'<cr>" [noremap])
(u.nmap "<leader>mr" "mR:echo 'Marked register R'<cr>" [noremap])
(u.nmap "<leader>ms" "mS:echo 'Marked register S'<cr>" [noremap])
(u.nmap "<leader>mt" "mT:echo 'Marked register T'<cr>" [noremap])

; window management
(u.nmap "<M-h>" "<C-w>h" [noremap silent])
(u.nmap "<M-j>" "<C-w>j" [noremap silent])
(u.nmap "<M-k>" "<C-w>k" [noremap silent])
(u.nmap "<M-l>" "<C-w>l" [noremap silent])
(u.nmap "<C-p>" "<C-w>p" [noremap silent])

; buffer management
(u.nmap "<leader>b" ":buffers<cr>:buffer<Space>" [noremap])
(u.nmap "[B" ":bfirst<cr>" [noremap silent])
(u.nmap "]B" ":blast<cr>" [noremap silent])
(u.nmap "[b" ":bprevious<cr>" [noremap silent])
(u.nmap "]b" ":bnext<cr>" [noremap silent])
(u.nmap "<leader>x" ":bp|bdelete #<cr>" [noremap silent])

; quickfix
(u.nmap "<leader>c" (u.lua-cmd "require('juice.quickfix')['toggle-qf-window']()") [noremap])
(u.nmap "<leader>l" (u.lua-cmd "require('juice.quickfix')['toggle-loclist-window']()") [noremap])
(u.nmap "[c" ":cprevious<cr>" [noremap])
(u.nmap "]c" ":cnext<cr>" [noremap])
(u.nmap "[C" ":cfirst<cr>" [noremap])
(u.nmap "]C" ":clast<cr>" [noremap])
(u.nmap "[l" ":lprevious<cr>" [noremap])
(u.nmap "]l" ":lnext<cr>" [noremap])
(u.nmap "[L" ":lfirst<cr>" [noremap])
(u.nmap "]L" ":llast<cr>" [noremap])

; search/replace shortcuts
(u.nmap "<leader>/s" ":s//g<left><left>" [noremap])
(u.nmap "<leader>/S" ":%s//g<left><left>" [noremap])
(u.nmap "<leader>/l" ":.,+s//g<left><left><left><left>" [noremap])
(u.nmap "<leader>/w" ":s/\\<<c-r><c-w>\\>//g<left><left>" [noremap])
(u.nmap "<leader>/W" ":%s/\\<<c-r><c-w>\\>//g<left><left>" [noremap])

; date shortcuts
(u.nmap "<leader>dt" ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>" [noremap])
(u.nmap "<leader>dT" ":.!date '+\\%a, \\%d \\%b \\%Y' --date=" [])

; open external apps in a new tmux window
(when (u.executable? "tmux")
  (when (u.executable? "lazydocker")
    (u.nmap "<leader>ld" ":!tmux neww lazydocker<cr><cr>" [noremap silent]))
  (when (u.executable? "lazygit")
    (u.nmap "<leader>lg" ":!tmux neww lazygit<cr><cr>" [noremap silent]))
  (when (u.executable? "sbtn")
    (u.nmap "<leader>ls" ":vsplit term://sbtn<cr><cr>" [noremap silent]))
  )

; easier moving of blocks in visual mode
(u.vmap "<" "<gv" [noremap])
(u.vmap ">" ">gv" [noremap])

; add undo step when typing sentences
(u.imap "\"" "\"<C-g>u" [noremap silent])
(u.imap "." ".<C-g>u" [noremap silent])
(u.imap "!" "!<C-g>u" [noremap silent])
(u.imap "?" "?<C-g>u" [noremap silent])
(u.imap "(" "(<C-g>u" [noremap silent])
(u.imap ")" ")<C-g>u" [noremap silent])
(u.imap "{" "{<C-g>u" [noremap silent])
(u.imap "}" "}<C-g>u" [noremap silent])
(u.imap "[" "[<C-g>u" [noremap silent])
(u.imap "]" "]<C-g>u" [noremap silent])

; completion bindings
(vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")  ; select item
