(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(local general
       [[:n :Y :y$ {:desc "yank until the end of the line"}]
        [:n :<C-l> ":nohl<cr>" {:desc "clear search highlight"}]
        [:n
         "<leader>;"
         ":<C-r>\""
         {:desc "paste register 0 contents in command mode"}]
        [:n :<leader>w ":w<cr>" {:desc "write buffer"}]
        [:n :<leader>n ":registers<cr>" {:desc "list registers"}]
        [:n :<F5> ":make<cr>" {:desc "trigger `make` in shell"}]
        [:n
         :<F2>
         "let @+ = getreg('%')"
         {:desc "copy current file path to clipboard"}]
        [:n :g? ":vert h<cr>" {:desc "open help" :silent true}]])

(local jumps [[:n :<C-d> :<C-d>zz {:silent true}]
              [:n :<C-u> :<C-u>zz {:silent true}]
              [:n :<C-o> :<C-o>zz {:silent true}]
              [:n :<C-i> :<C-i>zz {:silent true}]])

; Add undo step when typing sentences
(local undo-steps [[:i "\"" "\"<C-g>u" {:silent true}]
                   [:i "." :.<C-g>u {:silent true}]
                   [:i "!" :!<C-g>u {:silent true}]
                   [:i "?" :?<C-g>u {:silent true}]
                   [:i "(" "(<C-g>u" {:silent true}]
                   [:i ")" ")<C-g>u" {:silent true}]
                   [:i "{" "{<C-g>u" {:silent true}]
                   [:i "}" "}<C-g>u" {:silent true}]
                   [:i "[" "[<C-g>u" {:silent true}]
                   [:i "]" "]<C-g>u" {:silent true}]])

(local dates [[:n
               :<leader>dt
               ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>"
               {:desc "insert current date"}]
              [:n
               :<leader>dT
               ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>"
               {:desc "prompt for date query"}]])

(local marks [[:n :<leader>mm ":marks ARST<cr>" {:desc "list file marks ARST"}]
              [:n
               :<leader>mc
               ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>"
               {:desc "clear special file marks"}]
              [:n :<leader>a "`Azz" {:desc "jump to A mark"}]
              [:n :<leader>r "`Rzz" {:desc "jump to R mark"}]
              [:n :<leader>s "`Szz" {:desc "jump to S mark"}]
              [:n :<leader>t "`Tzz" {:desc "jump to T mark"}]
              [:n
               :<leader>ma
               "mA:echo 'Marked file A'<cr>"
               {:desc "set A mark"}]
              [:n
               :<leader>mr
               "mR:echo 'Marked file R'<cr>"
               {:desc "set R mark"}]
              [:n
               :<leader>ms
               "mS:echo 'Marked file S'<cr>"
               {:desc "set S mark"}]
              [:n
               :<leader>mt
               "mT:echo 'Marked file T'<cr>"
               {:desc "set T mark"}]])

(local buffers [[:n :<leader>b ":buffers<cr>:buffer<Space>" {}]
                [:n "[B" ":bfirst<cr>" {}]
                [:n "]B" ":blast<cr>" {}]
                [:n "[b" ":bprevious<cr>" {}]
                [:n "]b" ":bnext<cr>" {}]
                [:n :<leader>x ":bp|bdelete #<cr>" {}]])

(local tabs [[:n :<leader>tn ":tabnew<cr>" {}]
             [:n :<leader>tc ":tabclose<cr>" {}]
             [:n :<leader>ts ":tab split<cr>" {}]
             [:n "[t" ":tabprevious<cr>" {}]
             [:n "]t" ":tabnext<cr>" {}]
             [:n "[T" ":tabfirst<cr>" {}]
             [:n "]T" ":tablast<cr>" {}]])

(local quickfix
       [[:n :<leader>co ":copen<cr>" {:desc "open quickfix list"}]
        [:n :<leader>cc ":cclose<cr>" {:desc "close quickfix list"}]
        [:n
         "[c"
         ":cprevious<cr>"
         {:desc "jump to previous entry in quickfix list"}]
        [:n
         "]c"
         ":cnext<cr>"
         {:desc "jump to previous entry in quickfix list"}]
        [:n
         "[C"
         ":cfirst<cr>"
         {:desc "jump to previous entry in quickfix list"}]
        [:n
         "]C"
         ":clast<cr>"
         {:desc "jump to previous entry in quickfix list"}]
        [:n :<leader>lo ":lopen<cr>" {:desc "open loclist list"}]
        [:n :<leader>lc ":lclose<cr>" {:desc "close loclist list"}]
        [:n "[l" ":lprevious<cr>" {:desc "jump to previous entry in loclist"}]
        [:n "]l" ":lnext<cr>" {:desc "jump to next entry in loclist"}]
        [:n "[L" ":lfirst<cr>" {:desc "jump to first entry in loclist"}]
        [:n "]L" ":llast<cr>" {:desc "jump to last entry in loclist"}]])

(local search-replace
       [[:n :<leader>/s ":s//g<left><left>" {:desc "prompt for line search"}]
        [:n
         :<leader>/S
         ":%s//g<left><left>"
         {:desc "prompt for buffer search"}]
        [:n
         :<leader>/w
         ":s/\\<<c-r><c-w>\\>//g<left><left>"
         {:desc "prompt for line search and replace"}]
        [:n
         :<leader>/W
         ":%s/\\<<c-r><c-w>\\>//g<left><left>"
         {:desc "prompt for buffer search and replace"}]
        [:n
         :<leader>/v
         ":vim // *<left><left><left>"
         {:desc "prompt for global search"}]])

(local visual-indent [[:v "<" :<gv {}] [:v ">" :>gv {}]])

(fn setup []
  (let [mappings (core.concat general jumps undo-steps dates marks buffers tabs
                              quickfix search-replace visual-indent)]
    (util.set-keys mappings))
  (comment "select completion binding item")
  (vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  (comment "---- TMUX ----")
  (when vim.env.TMUX
    (when (util.executable? :lazygit)
      (vim.keymap.set :n :<leader>ol ":!tmux neww lazygit<cr><cr>"
                      {:desc "open lazygit in a new tmux window" :silent true})))
  (comment "---- JOURNAL ----")
  (when vim.env.JOURNAL
    (util.set-keys [[:n
                     :<leader>oj
                     #(vim.cmd (.. ":$tabnew" :$JOURNAL/journal.adoc))
                     {:desc "open journal in a new tab" :silent true}]
                    [:n
                     :<leader>ov
                     #(vim.cmd (.. ":$tabnew" :$JOURNAL/vim/vim.adoc))
                     {:desc "open vim notes in a new tab" :silent true}]]))
  (comment "---- PLUGINS ----")
  (util.set-keys [[:n :<leader>L ":Lazy<cr>" {:silent true}]
                  [:n
                   :<leader>u
                   ":UndotreeToggle<cr>"
                   {:desc "toggle undotree" :silent true}]]))

(fn oil-maps []
  (let [oil (autoload :oil)]
    (vim.keymap.set :n :<leader>e #(oil.open)
                    {:desc "explore files in current file's path" :silent true})))

(fn telescope-maps []
  (let [builtin (autoload :telescope.builtin)
        maps [[:n :<leader>f builtin.find_files {:desc "telescope (f)iles"}]
              [:n :<leader>p builtin.oldfiles {:desc "telescope oldfiles"}]
              [:n :<leader>g builtin.git_files {:desc "telescope (g)it files"}]
              [:n :<leader>k builtin.keymaps {:desc "telescope (k)eymaps"}]]]
    (util.set-keys maps)))

(fn gitsigns-maps []
  (let [gitsigns (autoload :gitsigns)
        nav [[:n
              "]g"
              #(gitsigns.nav_hunk :next {:wrap false :preview true})
              {:desc "jump to next git hunk"}]
             [:n
              "[g"
              #(gitsigns.nav_hunk :prev {:wrap false :preview true})
              {:desc "jump to previous git hunk"}]]
        staging [[:n
                  :<localleader>gs
                  gitsigns.stage_hunk
                  {:desc "(g)it (s)tage hunk"}]
                 [:n
                  :<localleader>gu
                  gitsigns.undo_stage_hunk
                  {:desc "(g)it (u)ndo staged hunk"}]
                 [:n
                  :<localleader>gr
                  gitsigns.reset_hunk
                  {:desc "(g)it (r)eset hunk"}]
                 [:n
                  :<localleader>gS
                  gitsigns.stage_buffer
                  {:desc "(g)it (S)tage buffer"}]
                 [:n
                  :<localleader>gR
                  gitsigns.reset_buffer
                  {:desc "(g)it (R)eset buffer"}]
                 [:v
                  :<localleader>gs
                  #(gitsigns.stage_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                  {:desc "(g)it (s)tage hunk"}]
                 [:v
                  :<localleader>gr
                  #(gitsigns.reset_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                  {:desc "(g)it (r)eset hunk"}]]
        blame [[:n
                :<localleader>gb
                #(gitsigns.blame_line {:full true})
                {:desc "(g)it show line (b)lame"}]
               [:n
                :<localleader>gB
                gitsigns.toggle_current_line_blame
                {:desc "(g)it toggle current line (B)lame"}]]
        view [[:n
               :<localleader>gp
               gitsigns.preview_hunk
               {:desc "(g)it (p)review hunk"}]
              [:n
               :<localleader>gd
               gitsigns.diffthis
               {:desc "(g)it show (d)iff"}]
              [:n
               :<localleader>gD
               gitsigns.toggle_deleted
               {:desc "(g)it toggle (D)eleted hunks"}]]
        list [[:n
               :<localleader>gl
               gitsigns.setloclist
               {:desc "show buffer (g)it hunks in (l)oclist"}]
              [:n
               :<localleader>gc
               #(gitsigns.setqflist :all)
               {:desc "show all (g)it hunks in qui(c)kfix list"}]]
        mappings (core.concat nav staging blame view list)]
    (util.set-keys mappings)))

(fn neogit-maps []
  (let [neogit (autoload :neogit)]
    (vim.keymap.set :n :<leader>og neogit.open {:desc "(o)pen (n)eogit"})))

{: setup : oil-maps : telescope-maps : gitsigns-maps : neogit-maps}
