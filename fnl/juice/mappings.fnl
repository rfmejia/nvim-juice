(local {: autoload} (require :nfnl.module))
(local {: lua-cmd : map-keys : nmap : map : imap : vmap : executable?}
       (autoload :juice.util))

(fn setup []
  (nmap ; ---- GENERAL MAPPINGS ----
        {:Y [:y$ nil "yank until the end of the line"]
         :<C-l> [":nohl<cr>" [:noremap] "clear search highlight"]
         "<leader>;" [":<C-r>\""
                      [:noremap]
                      "paste register 0 contents in command mode"]
         :<leader>w [":w<cr>" [:noremap] "write buffer"]
         :<leader>n [":registers<cr>" [:noremap] "list registers"]
         :<F5> [":make<cr>" [:noremap] "trigger `make` in shell"]})
  (nmap ; Vertically center screen when page scrolling up/down
        {:<C-d> [:<C-d>zz [:noremap :silent]]
         :<C-u> [:<C-u>zz [:noremap :silent]]
         :<C-o> [:<C-o>zz [:noremap :silent]]
         :<C-i> [:<C-i>zz [:noremap :silent]]})
  (vmap ; Indent blocks in visual mode
        {:< [:<gv [:noremap]] :> [:>gv [:noremap]]})
  (imap ; Add undo step when typing sentences
        {"\"" ["\"<C-g>u" [:noremap :silent]]
         :. [:.<C-g>u [:noremap :silent]]
         :! [:!<C-g>u [:noremap :silent]]
         :? [:?<C-g>u [:noremap :silent]]
         "(" ["(<C-g>u" [:noremap :silent]]
         ")" [")<C-g>u" [:noremap :silent]]
         "{" ["{<C-g>u" [:noremap :silent]]
         "}" ["}<C-g>u" [:noremap :silent]]
         "[" ["[<C-g>u" [:noremap :silent]]
         "]" ["]<C-g>u" [:noremap :silent]]})
  (nmap ; date shortcuts
        {:<leader>dt [":.!date '+\\%a, \\%d \\%b \\%Y'<cr>"
                      [:noremap]
                      "insert current date"]
         :<leader>dT [":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>"
                      [:noremap]
                      "prompt for date query"]})
  (comment "select completion binding item")
  (vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  (nmap ; ---- MARK MANAGEMENT ----
        {:<leader>mm [":marks ARST<cr>" [:noremap] "list special file marks"]
         :<leader>mc [":delmarks ARST<cr>:echo 'Cleared file marks'<cr>"
                      [:noremap]
                      "clear special file marks"]
         :<leader>a ["`Azz" [:noremap] "jump to A mark"]
         :<leader>r ["`Rzz" [:noremap] "jump to R mark"]
         :<leader>s ["`Szz" [:noremap] "jump to S mark"]
         :<leader>t ["`Tzz" [:noremap] "jump to T mark"]
         :<leader>ma ["mA:echo 'Marked file A'<cr>" [:noremap] "set A mark"]
         :<leader>mr ["mR:echo 'Marked file R'<cr>" [:noremap] "set R mark"]
         :<leader>ms ["mS:echo 'Marked file S'<cr>" [:noremap] "set S mark"]
         :<leader>mt ["mT:echo 'Marked file T'<cr>" [:noremap] "set T mark"]})
  (nmap ; ---- BUFFER MANAGEMENT ----
        {:<leader>b [":buffers<cr>:buffer<Space>" [:noremap]]
         "[B" [":bfirst<cr>" [:noremap]]
         "]B" [":blast<cr>" [:noremap]]
         "[b" [":bprevious<cr>" [:noremap]]
         "]b" [":bnext<cr>" [:noremap]]
         :<leader>x [":bp|bdelete #<cr>" [:noremap]]})
  (nmap ; ---- TAB MANAGEMENT ----
        {:<leader>tn [":tabnew<cr>" [:noremap]]
         :<leader>tc [":tabclose<cr>" [:noremap]]
         :<leader>ts [":tab split<cr>" [:noremap]]
         "[t" [":tabprevious<cr>" [:noremap]]
         "]t" [":tabnext<cr>" [:noremap]]
         "[T" [":tabfirst<cr>" [:noremap]]
         "]T" [":tablast<cr>" [:noremap]]})
  (nmap ; ---- QUICKFIX LIST ----
        {:<leader>co [":copen<cr>" [:noremap] "open quickfix list"]
         :<leader>cc [":cclose<cr>" [:noremap] "close quickfix list"]
         "[c" [":cprevious<cr>"
               [:noremap]
               "jump to previous entry in quickfix list"]
         "]c" [":cnext<cr>"
               [:noremap]
               "jump to previous entry in quickfix list"]
         "[C" [":cfirst<cr>"
               [:noremap]
               "jump to previous entry in quickfix list"]
         "]C" [":clast<cr>"
               [:noremap]
               "jump to previous entry in quickfix list"]
         :<leader>lo [":lopen<cr>" [:noremap] "open loclist list"]
         :<leader>lc [":lclose<cr>" [:noremap] "close loclist list"]
         "[l" [":lprevious<cr>" [:noremap] "jump to previous entry in loclist"]
         "]l" [":lnext<cr>" [:noremap] "jump to next entry in loclist"]
         "[L" [":lfirst<cr>" [:noremap] "jump to first entry in loclist"]
         "]L" [":llast<cr>" [:noremap] "jump to last entry in loclist"]})
  (nmap ; ---- SEARCH/REPLACE ----
        {:<leader>/s [":s//g<left><left>" [:noremap] "prompt for line search"]
         :<leader>/S [":%s//g<left><left>"
                      [:noremap]
                      "prompt for buffer search"]
         :<leader>/w [":s/\\<<c-r><c-w>\\>//g<left><left>"
                      [:noremap]
                      "prompt for line search and replace"]
         :<leader>/W [":%s/\\<<c-r><c-w>\\>//g<left><left>"
                      [:noremap]
                      "prompt for buffer search and replace"]
         :<leader>/v [":vim // *<left><left><left>"
                      [:noremap]
                      "prompt for global search"]})
  (comment "---- WINDOW MANAGEMENT ----")
  (nmap {:<C-p> [:<C-w>p [:noremap :silent] "jump to previous window"]})
  (if vim.env.TMUX
      (let [tmux (autoload :juice.tmux)]
        (nmap {:<M-h> [tmux.navigate-left
                       [:noremap :silent]
                       "jump to the nvim/tmux window to the left"]
               :<M-l> [tmux.navigate-right
                       [:noremap :silent]
                       "jump to the nvim/tmux window to the right"]
               :<M-k> [tmux.navigate-up
                       [:noremap :silent]
                       "jump to the nvim/tmux window above"]
               :<M-j> [tmux.navigate-down
                       [:noremap :silent]
                       "jump to the nvim/tmux window below"]}))
      (nmap {:<M-h> [:<C-w>h
                     [:noremap :silent]
                     "jump to the window to the left"]
             :<M-l> [:<C-w>l
                     [:noremap :silent]
                     "jump to the window to the right"]
             :<M-k> [:<C-w>k [:noremap :silent] "jump to the window above"]
             :<M-j> [:<C-w>j [:noremap :silent] "jump to the window below"]}))
  (comment "---- TMUX ----")
  (when vim.env.TMUX
    (when (executable? :lazygit)
      (nmap {:<leader>og [":!tmux neww lazygit<cr><cr>"
                          [:noremap :silent]
                          "open lazygit in a new tmux window"]})))
  (comment "---- JOURNAL ----")
  (when vim.env.JOURNAL
    (nmap {:<leader>oj [#(vim.cmd (.. ":$tabnew" :$JOURNAL/journal.adoc))
                        [:noremap :silent]
                        "open journal in a new tab"]
           :<leader>ov [#(vim.cmd (.. ":$tabnew" :$JOURNAL/vim/vim.adoc))
                        [:noremap :silent]
                        "open vim notes in a new tab"]}))
  (comment "---- PLUGINS ----")
  (nmap {:<leader>L [":Lazy<cr>" [:noremap :silent]]
         :<leader>e [":Oil<cr>"
                     [:noremap :silent]
                     "explore files in current file's path"]
         :<leader>E [":Oil .<cr>"
                     [:noremap :silent]
                     "explore files in current working dir"]
         :<leader>u [":UndotreeToggle<cr>"
                     [:noremap :silent]
                     "toggle undotree"]})
  (let [builtin (autoload :telescope.builtin)
        maps {:<leader>f [builtin.find_files
                          [:noremap :silent]
                          "telescope (f)iles"]
              :<leader>g [builtin.git_files
                          [:noremap :silent]
                          "telescope (g)it files"]
              :<leader>p [builtin.oldfiles
                          [:noremap :silent]
                          "telescope oldfiles"]
              :<leader>k [builtin.keymaps
                          [:noremap :silent]
                          "telescope (k)eymaps"]}]
    (nmap maps))
  (let [gitsigns (autoload :gitsigns)
        nav-maps {"]g" [#(gitsigns.nav_hunk :next {:wrap false :preview true})
                        [:noremap]
                        "jump to next git hunk"]
                  "[g" [#(gitsigns.nav_hunk :prev {:wrap false :preview true})
                        [:noremap]
                        "jump to previous git hunk"]}
        action-maps {:<localleader>gs [gitsigns.stage_hunk
                                       [:noremap]
                                       "(g)it (s)tage hunk"]
                     :<localleader>gu [gitsigns.undo_stage_hunk
                                       [:noremap]
                                       "(g)it (u)ndo staged hunk"]
                     :<localleader>gr [gitsigns.reset_hunk
                                       [:noremap]
                                       "(g)it (r)eset hunk"]
                     :<localleader>gS [gitsigns.stage_buffer
                                       [:noremap]
                                       "(g)it (S)tage buffer"]
                     :<localleader>gR [gitsigns.reset_buffer
                                       [:noremap]
                                       "(g)it (R)eset buffer"]}
        visual-action-maps {:<localleader>gs [#(gitsigns.stage_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                                              [:noremap]
                                              "(g)it (s)tage hunk"]
                            :<localleader>gr [#(gitsigns.reset_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                                              [:noremap]
                                              "(g)it (r)eset hunk"]}
        blame-maps {:<localleader>gb [#(gitsigns.blame_line {:full true})
                                      [:noremap]
                                      "(g)it show line (b)lame"]
                    :<localleader>gB [gitsigns.toggle_current_line_blame
                                      [:noremap]
                                      "(g)it toggle current line (B)lame"]}
        view-maps {:<localleader>gp [gitsigns.preview_hunk
                                     [:noremap]
                                     "(g)it (p)review hunk"]
                   :<localleader>gd [gitsigns.diffthis
                                     [:noremap]
                                     "(g)it show (d)iff"]
                   :<localleader>gD [gitsigns.toggle_deleted
                                     [:noremap]
                                     "(g)it toggle (D)eleted hunks"]}
        list-maps {:<localleader>gl [#(gitsigns.setloclist)
                                     [:noremap]
                                     "show buffer (g)it hunks in (l)oclist"]
                   :<localleader>gc [#(gitsigns.setqflist :all)
                                     [:noremap]
                                     "show all (g)it hunks in qui(c)kfix list"]}]
    (each [_ mappings (ipairs [nav-maps
                               action-maps
                               blame-maps
                               view-maps
                               list-maps])]
      (nmap mappings))
    (vmap visual-action-maps))
  (let [neogit (autoload :neogit)]
    (nmap {:<leader>on [neogit.open [:noremap] "(o)pen (n)eogit"]})))

{: setup}
