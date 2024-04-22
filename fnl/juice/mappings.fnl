(local {: autoload} (require :nfnl.module))
(local {: lua-cmd : nmap : imap : vmap : executable?} (autoload :juice.util))
(local {: toggle-qf-window : toggle-loclist-window} (autoload :juice.quickfix))

(fn setup []
  (comment "---- GENERAL MAPPINGS ----")
  (nmap :Y :y$ nil "yank until the end of the line")
  (nmap :<C-l> ":nohl<cr>" [:noremap] "clear search highlight")
  (nmap "<leader>;" ":<C-r>\"" [:noremap]
        "paste register 0 contents in command mode")
  (nmap :<leader>w ":w<cr>" [:noremap] "write buffer")
  (nmap :<leader>n ":registers<cr>" [:noremap] "list registers")
  (nmap :<F5> ":make<cr>" [:noremap] "trigger `make` in shell")
  (do
    "Vertically center screen when page scrolling up/down"
    (nmap :<C-d> :<C-d>zz [:noremap :silent])
    (nmap :<C-u> :<C-u>zz [:noremap :silent])
    (nmap :<C-o> :<C-o>zz [:noremap :silent])
    (nmap :<C-i> :<C-i>zz [:noremap :silent]))
  (imap :<C-t> :<C-x><C-o> [:noremap :silent] "trigger omnicompletion")
  (do
    "Indent blocks in visual mode"
    (vmap "<" :<gv [:noremap])
    (vmap ">" :>gv [:noremap]))
  (do
    "Add undo step when typing sentences"
    (imap "\"" "\"<C-g>u" [:noremap :silent])
    (imap "." :.<C-g>u [:noremap :silent])
    (imap "!" :!<C-g>u [:noremap :silent])
    (imap "?" :?<C-g>u [:noremap :silent])
    (imap "(" "(<C-g>u" [:noremap :silent])
    (imap ")" ")<C-g>u" [:noremap :silent])
    (imap "{" "{<C-g>u" [:noremap :silent])
    (imap "}" "}<C-g>u" [:noremap :silent])
    (imap "[" "[<C-g>u" [:noremap :silent])
    (imap "]" "]<C-g>u" [:noremap :silent]))
  (do
    "date shortcuts"
    (nmap :<leader>dt ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>" [:noremap]
          "insert current date")
    (nmap :<leader>dT ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>" nil
          "prompt for date query"))
  (comment "select completion binding item")
  (vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  (comment "---- MARK MANAGEMENT ----")
  (nmap :<leader>mm ":marks ARST<cr>" [:noremap] "list special file marks")
  (nmap :<leader>mc ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>"
        [:noremap] "clear special file marks")
  (nmap :<leader>a "`Azz" [:noremap] "jump to A mark")
  (nmap :<leader>r "`Rzz" [:noremap] "jump to R mark")
  (nmap :<leader>s "`Szz" [:noremap] "jump to S mark")
  (nmap :<leader>t "`Tzz" [:noremap] "jump to T mark")
  (nmap :<leader>ma "mA:echo 'Marked file A'<cr>" [:noremap] "set A mark")
  (nmap :<leader>mr "mR:echo 'Marked file R'<cr>" [:noremap] "set R mark")
  (nmap :<leader>ms "mS:echo 'Marked file S'<cr>" [:noremap] "set S mark")
  (nmap :<leader>mt "mT:echo 'Marked file T'<cr>" [:noremap] "set T mark")
  (comment "---- BUFFER MANAGEMENT ----")
  (nmap :<leader>b ":buffers<cr>:buffer<Space>" [:noremap])
  (nmap "[B" ":bfirst<cr>" [:noremap])
  (nmap "]B" ":blast<cr>" [:noremap])
  (nmap "[b" ":bprevious<cr>" [:noremap])
  (nmap "]b" ":bnext<cr>" [:noremap])
  (nmap :<leader>x ":bp|bdelete #<cr>" [:noremap])
  (comment "---- TAB MANAGEMENT ----")
  (nmap :tn ":tabnew<cr>" [:noremap])
  (nmap :tc ":tabclose<cr>" [:noremap])
  (nmap :ts ":tab split<cr>" [:noremap])
  (nmap "[t" ":tabprevious<cr>" [:noremap])
  (nmap "]t" ":tabnext<cr>" [:noremap])
  (nmap "[T" ":tabfirst<cr>" [:noremap])
  (nmap "]T" ":tablast<cr>" [:noremap])
  (comment "---- QUICKFIX LIST ----")
  (nmap :<leader>c toggle-qf-window [:noremap] "toggle quickfix list")
  (nmap "[c" ":cprevious<cr>" [:noremap]
        "jump to previous entry in quickfix list")
  (nmap "]c" ":cnext<cr>" [:noremap] "jump to previous entry in quickfix list")
  (nmap "[C" ":cfirst<cr>" [:noremap] "jump to previous entry in quickfix list")
  (nmap "]C" ":clast<cr>" [:noremap] "jump to previous entry in quickfix list")
  (nmap :<leader>l toggle-loclist-window [:noremap] "toggle loclist")
  (nmap "[l" ":lprevious<cr>" [:noremap] "jump to previous entry in loclist")
  (nmap "]l" ":lnext<cr>" [:noremap] "jump to next entry in loclist")
  (nmap "[L" ":lfirst<cr>" [:noremap] "jump to first entry in loclist")
  (nmap "]L" ":llast<cr>" [:noremap] "jump to last entry in loclist")
  (comment "---- SEARCH/REPLACE ----")
  (nmap :<leader>/s ":s//g<left><left>" [:noremap] "prompt for line search")
  (nmap :<leader>/S ":%s//g<left><left>" [:noremap] "prompt for buffer search")
  (nmap :<leader>/w ":s/\\<<c-r><c-w>\\>//g<left><left>" [:noremap]
        "prompt for line search and replace")
  (nmap :<leader>/W ":%s/\\<<c-r><c-w>\\>//g<left><left>" [:noremap]
        "prompt for buffer search and replace")
  (nmap :<leader>/v ":vim // *<left><left><left>" [:noremap]
        "prompt for global search")
  (comment "---- WINDOW MANAGEMENT ----")
  (nmap :<C-p> :<C-w>p [:noremap :silent] "jump to previous window")
  (if vim.env.TMUX
      (do
        (let [tmux (autoload :juice.tmux)]
          (nmap :<M-h> tmux.navigate-left [:noremap :silent]
                "jump to the nvim/tmux window to the left")
          (nmap :<M-l> tmux.navigate-right [:noremap :silent]
                "jump to the nvim/tmux window to the right")
          (nmap :<M-k> tmux.navigate-up [:noremap :silent]
                "jump to the nvim/tmux window above")
          (nmap :<M-j> tmux.navigate-down [:noremap :silent]
                "jump to the nvim/tmux window below")))
      (do
        (nmap :<M-h> :<C-w>h [:noremap :silent]
              "jump to the window to the left")
        (nmap :<M-l> :<C-w>l [:noremap :silent]
              "jump to the window to the right")
        (nmap :<M-k> :<C-w>k [:noremap :silent] "jump to the window above")
        (nmap :<M-j> :<C-w>j [:noremap :silent] "jump to the window below")))
  (comment "---- TMUX ----")
  (when vim.env.TMUX
    (when (executable? :lazygit)
      (nmap :<leader>og ":!tmux neww lazygit<cr><cr>" [:noremap :silent]
            "open lazygit in a new tmux window")))
  (comment "---- JOURNAL ----")
  (when vim.env.JOURNAL
    (nmap :<leader>oj (fn [] (vim.cmd (.. ":$tabnew" :$JOURNAL/journal.adoc)))
          [:noremap :silent] "open journal in a new tab")
    (nmap :<leader>ov (fn [] (vim.cmd (.. ":$tabnew" :$JOURNAL/vim/vim.adoc)))
          [:noremap :silent] "open vim notes in a new tab"))
  (comment "---- PLUGINS ----")
  (nmap :<leader>L ":Lazy<cr>" [:noremap :silent])
  (nmap :<leader>e ":Oil<cr>" [:noremap :silent]
        "explore files in current file's path")
  (nmap :<leader>E ":Oil .<cr>" [:noremap :silent]
        "explore files in current working dir")
  (nmap :<leader>u ":UndotreeToggle<cr>" [:noremap :silent] "toggle undotree")
  (let [builtin (autoload :telescope.builtin)]
    (nmap :<leader>f builtin.find_files [:noremap :silent])
    (nmap :<leader>g builtin.git_files [:noremap :silent])
    (nmap :<leader>p builtin.oldfiles [:noremap :silent])
    (nmap :<leader>k builtin.keymaps [:noremap :silent]))
  (let [gitsigns (autoload :gitsigns)]
    (nmap "]h" (fn [] (gitsigns.nav_hunk :next)) [:noremap])
    (nmap "[h" (fn [] (gitsigns.nav_hunk :prev)) [:noremap])
    (nmap :<localleader>hS (fn [] (gitsigns.blame_line {:full true}))
          [:noremap])
    (nmap :<localleader>hp gitsigns.preview_hunk [:noremap])
    (nmap :<localleader>hs gitsigns.stage_hunk [:noremap])
    (nmap :<localleader>hS gitsigns.undo_stage_hunk [:noremap])))

{: setup}
