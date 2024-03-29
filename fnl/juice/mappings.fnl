(module mappings
  {autoload {q juice.quickfix
             u util}})

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(u.nmap "Y" "y$" [])
(u.nmap "<C-l>" ":nohl<cr>" [:noremap])
(u.nmap "<leader>;" ":<C-r>\"" [:noremap])

(u.nmap "<leader>w" ":w<cr>" [:noremap])
(u.nmap "<leader>n" ":registers<cr>" [:noremap])

(u.nmap "<F5>" ":make<cr>" [:noremap])

; Vertically center screen when page scrolling up/down
(u.nmap "<C-d>" "<C-d>zz" [:noremap :silent])
(u.nmap "<C-u>" "<C-u>zz" [:noremap :silent])
(u.nmap "<C-o>" "<C-o>zz" [:noremap :silent])
(u.nmap "<C-i>" "<C-i>zz" [:noremap :silent])

; Disable default mappings to train optimal alternatives
(u.nmap "{" (fn [] (print "Use C-u or relative jumps instead")) [:noremap :silent])
(u.nmap "}" (fn [] (print "Use C-d or relative jumps instead")) [:noremap :silent])

; Map omnifunc
(u.imap "<C-t>" "<C-x><C-o>" [:noremap :silent])

; mark management
(u.nmap "<leader>mm" ":marks ARST<cr>" [:noremap])
(u.nmap "<leader>mc" ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>" [:noremap])
(u.nmap "<leader>a" "`Azz" [:noremap])
(u.nmap "<leader>r" "`Rzz" [:noremap])
(u.nmap "<leader>s" "`Szz" [:noremap])
(u.nmap "<leader>t" "`Tzz" [:noremap])
(u.nmap "<leader>ma" "mA:echo 'Marked file A'<cr>" [:noremap])
(u.nmap "<leader>mr" "mR:echo 'Marked file R'<cr>" [:noremap])
(u.nmap "<leader>ms" "mS:echo 'Marked file S'<cr>" [:noremap])
(u.nmap "<leader>mt" "mT:echo 'Marked file T'<cr>" [:noremap])

; window management
(u.nmap "<M-h>" "<C-w>h" [:noremap :silent])
(u.nmap "<M-j>" "<C-w>j" [:noremap :silent])
(u.nmap "<M-k>" "<C-w>k" [:noremap :silent])
(u.nmap "<M-l>" "<C-w>l" [:noremap :silent])
(u.nmap "<C-p>" "<C-w>p" [:noremap :silent])

; buffer management
(u.nmap "<leader>b" ":buffers<cr>:buffer<Space>" [:noremap])
(u.nmap "[B" ":bfirst<cr>" [:noremap])
(u.nmap "]B" ":blast<cr>" [:noremap])
(u.nmap "[b" ":bprevious<cr>" [:noremap])
(u.nmap "]b" ":bnext<cr>" [:noremap])
(u.nmap "<leader>x" ":bp|bdelete #<cr>" [:noremap])

; tab management
(u.nmap "tn" ":tabnew<cr>" [:noremap])
(u.nmap "tc" ":tabclose<cr>" [:noremap])
(u.nmap "ts" ":tab split<cr>" [:noremap])
(u.nmap "[t" ":tabprevious<cr>" [:noremap])
(u.nmap "]t" ":tabnext<cr>" [:noremap])
(u.nmap "[T" ":tabfirst<cr>" [:noremap])
(u.nmap "]T" ":tablast<cr>" [:noremap])

; quickfix list
(u.nmap "<leader>c" q.toggle-qf-window [:noremap])
(u.nmap "[c" ":cprevious<cr>" [:noremap])
(u.nmap "]c" ":cnext<cr>" [:noremap])
(u.nmap "[C" ":cfirst<cr>" [:noremap])
(u.nmap "]C" ":clast<cr>" [:noremap])

; location list
(u.nmap "<leader>l" q.toggle-loclist-window [:noremap])
(u.nmap "[l" ":lprevious<cr>" [:noremap])
(u.nmap "]l" ":lnext<cr>" [:noremap])
(u.nmap "[L" ":lfirst<cr>" [:noremap])
(u.nmap "]L" ":llast<cr>" [:noremap])

; search/replace shortcuts
(u.nmap "<leader>/s" ":s//g<left><left>" [:noremap])
(u.nmap "<leader>/S" ":%s//g<left><left>" [:noremap])
(u.nmap "<leader>/l" ":.,+s//g<left><left><left><left>" [:noremap])
(u.nmap "<leader>/w" ":s/\\<<c-r><c-w>\\>//g<left><left>" [:noremap])
(u.nmap "<leader>/W" ":%s/\\<<c-r><c-w>\\>//g<left><left>" [:noremap])

; date shortcuts
(u.nmap "<leader>dt" ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>" [:noremap])
(u.nmap "<leader>dT" ":.!date '+\\%a, \\%d \\%b \\%Y' --date=" [])

; open external apps in a new tmux window
(when (u.exists? "$TMUX")
  (when (u.executable? "lazygit")
    (u.nmap "<leader>og" ":!tmux neww lazygit<cr><cr>" [:noremap :silent]))
  (when (u.executable? "sbtn")
    (u.nmap "<leader>os" ":!tmux split-window -v -l 30\\% sbtn<cr><cr>" [:noremap :silent]))
  (when (u.executable? "scala-cli")
    (u.nmap "<leader>oc" ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>" [:noremap :silent]))
  )

; easier moving of blocks in visual mode
(u.vmap "<" "<gv" [:noremap])
(u.vmap ">" ">gv" [:noremap])

; add undo step when typing sentences
(u.imap "\"" "\"<C-g>u" [:noremap :silent])
(u.imap "." ".<C-g>u" [:noremap :silent])
(u.imap "!" "!<C-g>u" [:noremap :silent])
(u.imap "?" "?<C-g>u" [:noremap :silent])
(u.imap "(" "(<C-g>u" [:noremap :silent])
(u.imap ")" ")<C-g>u" [:noremap :silent])
(u.imap "{" "{<C-g>u" [:noremap :silent])
(u.imap "}" "}<C-g>u" [:noremap :silent])
(u.imap "[" "[<C-g>u" [:noremap :silent])
(u.imap "]" "]<C-g>u" [:noremap :silent])

; completion bindings
(vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")  ; select item

; open vim notes in a new tab
(when (u.exists? "$JOURNAL")
  (u.nmap "<leader>oj" (fn [] (vim.cmd (.. ":$tabnew" "$JOURNAL/journal.md"))) [:noremap :silent])
  (u.nmap "<leader>ov" (fn [] (vim.cmd (.. ":$tabnew" "$JOURNAL/vim/vim.md"))) [:noremap :silent]))

; plugin mappings
(u.nmap "<leader>L" ":Lazy<cr>" [:noremap :silent])
(u.nmap "<leader>e" ":Oil<cr>" [:noremap :silent])
(comment u.nmap "<leader>e" ":Explore<cr><cr>" [:noremap :silent])
(u.nmap "<leader>u" ":UndotreeToggle<cr>" [:noremap :silent])

(u.nmap "<leader>f" ":Files<cr>" [:noremap :silent])
(u.nmap "<leader>g" ":GFiles<cr>" [:noremap :silent])
(u.nmap "<leader>p" ":History<cr>" [:noremap :silent])

(u.nmap "<localleader>du" ":DBUIToggle<cr>" [:noremap])
(u.nmap "<localleader>d;" ":DB g:db " [:noremap])
(u.nmap "<localleader>dd" ":.DB g:db<cr>" [:noremap])
(u.nmap "<localleader>db" ":%DB g:db<cr>" [:noremap])
(u.nmap "<localleader>dp" "vip:DB g:db<cr>" [:noremap])

(u.nmap "]g" ":Gitsigns next_hunk<cr>" [:noremap])
(u.nmap "[g" ":Gitsigns prev_hunk<cr>" [:noremap])
(u.nmap "<localleader>gp" ":Gitsigns preview_hunk<cr>" [:noremap])
(u.nmap "<localleader>gs" ":Gitsigns stage_hunk<cr>" [:noremap])
(u.nmap "<localleader>gu" ":Gitsigns undo_stage_hunk<cr>" [:noremap])
