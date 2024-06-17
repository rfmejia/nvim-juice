(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(local general
       [[:n :Y :y$ {:desc "yank until the end of the line"}]
        [:n :<C-l> ":nohl<cr>" {:desc "clear search highlight" :noremap true}]
        [:n
         "<leader>;"
         ":<C-r>\""
         {:desc "paste register 0 contents in command mode" :noremap true}]
        [:n :<leader>w ":w<cr>" {:desc "write buffer" :noremap true}]
        [:n :<leader>n ":registers<cr>" {:desc "list registers" :noremap true}]
        [:n :<F5> ":make<cr>" {:desc "trigger `make` in shell" :noremap true}]])

(local jumps [[:n :<C-d> :<C-d>zz {:noremap true :silent true}]
              [:n :<C-u> :<C-u>zz {:noremap true :silent true}]
              [:n :<C-o> :<C-o>zz {:noremap true :silent true}]
              [:n :<C-i> :<C-i>zz {:noremap true :silent true}]])

; Add undo step when typing sentences
(local undo-steps
       [[:i "\"" "\"<C-g>u" {:noremap true :silent true}]
        [:i "." :.<C-g>u {:noremap true :silent true}]
        [:i "!" :!<C-g>u {:noremap true :silent true}]
        [:i "?" :?<C-g>u {:noremap true :silent true}]
        [:i "(" "(<C-g>u" {:noremap true :silent true}]
        [:i ")" ")<C-g>u" {:noremap true :silent true}]
        [:i "{" "{<C-g>u" {:noremap true :silent true}]
        [:i "}" "}<C-g>u" {:noremap true :silent true}]
        [:i "[" "[<C-g>u" {:noremap true :silent true}]
        [:i "]" "]<C-g>u" {:noremap true :silent true}]])

(local dates [[:n
               :<leader>dt
               ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>"
               {:desc "insert current date" :noremap true}]
              [:n
               :<leader>dT
               ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>"
               {:desc "prompt for date query" :noremap true}]])

(local marks [[:n
               :<leader>mm
               ":marks ARST<cr>"
               {:noremap true :desc "list file marks ARST"}]
              [:n
               :<leader>mc
               ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>"
               {:noremap true :desc "clear special file marks"}]
              [:n :<leader>a "`Azz" {:noremap true :desc "jump to A mark"}]
              [:n :<leader>r "`Rzz" {:noremap true :desc "jump to R mark"}]
              [:n :<leader>s "`Szz" {:noremap true :desc "jump to S mark"}]
              [:n :<leader>t "`Tzz" {:noremap true :desc "jump to T mark"}]
              [:n
               :<leader>ma
               "mA:echo 'Marked file A'<cr>"
               {:noremap true :desc "set A mark"}]
              [:n
               :<leader>mr
               "mR:echo 'Marked file R'<cr>"
               {:noremap true :desc "set R mark"}]
              [:n
               :<leader>ms
               "mS:echo 'Marked file S'<cr>"
               {:noremap true :desc "set S mark"}]
              [:n
               :<leader>mt
               "mT:echo 'Marked file T'<cr>"
               {:noremap true :desc "set T mark"}]])

(local buffers
       [[:n :<leader>b ":buffers<cr>:buffer<Space>" {:noremap true}]
        [:n "[B" ":bfirst<cr>" {:noremap true}]
        [:n "]B" ":blast<cr>" {:noremap true}]
        [:n "[b" ":bprevious<cr>" {:noremap true}]
        [:n "]b" ":bnext<cr>" {:noremap true}]
        [:n :<leader>x ":bp|bdelete #<cr>" {:noremap true}]])

(local tabs [[:n :<leader>tn ":tabnew<cr>" {:noremap true}]
             [:n :<leader>tc ":tabclose<cr>" {:noremap true}]
             [:n :<leader>ts ":tab split<cr>" {:noremap true}]
             [:n "[t" ":tabprevious<cr>" {:noremap true}]
             [:n "]t" ":tabnext<cr>" {:noremap true}]
             [:n "[T" ":tabfirst<cr>" {:noremap true}]
             [:n "]T" ":tablast<cr>" {:noremap true}]])

(local quickfix
       [[:n
         :<leader>co
         ":copen<cr>"
         {:noremap true :desc "open quickfix list"}]
        [:n
         :<leader>cc
         ":cclose<cr>"
         {:noremap true :desc "close quickfix list"}]
        [:n
         "[c"
         ":cprevious<cr>"
         {:noremap true :desc "jump to previous entry in quickfix list"}]
        [:n
         "]c"
         ":cnext<cr>"
         {:noremap true :desc "jump to previous entry in quickfix list"}]
        [:n
         "[C"
         ":cfirst<cr>"
         {:noremap true :desc "jump to previous entry in quickfix list"}]
        [:n
         "]C"
         ":clast<cr>"
         {:noremap true :desc "jump to previous entry in quickfix list"}]
        [:n :<leader>lo ":lopen<cr>" {:noremap true :desc "open loclist list"}]
        [:n
         :<leader>lc
         ":lclose<cr>"
         {:noremap true :desc "close loclist list"}]
        [:n
         "[l"
         ":lprevious<cr>"
         {:noremap true :desc "jump to previous entry in loclist"}]
        [:n
         "]l"
         ":lnext<cr>"
         {:noremap true :desc "jump to next entry in loclist"}]
        [:n
         "[L"
         ":lfirst<cr>"
         {:noremap true :desc "jump to first entry in loclist"}]
        [:n
         "]L"
         ":llast<cr>"
         {:noremap true :desc "jump to last entry in loclist"}]])

(local search-replace
       [[:n
         :<leader>/s
         ":s//g<left><left>"
         {:noremap true :desc "prompt for line search"}]
        [:n
         :<leader>/S
         ":%s//g<left><left>"
         {:noremap true :desc "prompt for buffer search"}]
        [:n
         :<leader>/w
         ":s/\\<<c-r><c-w>\\>//g<left><left>"
         {:noremap true :desc "prompt for line search and replace"}]
        [:n
         :<leader>/W
         ":%s/\\<<c-r><c-w>\\>//g<left><left>"
         {:noremap true :desc "prompt for buffer search and replace"}]
        [:n
         :<leader>/v
         ":vim // *<left><left><left>"
         {:noremap true :desc "prompt for global search"}]])

(local visual-indent [[:n "<" :<gv {:noremap true}]
                      [:n ">" :>gv {:noremap true}]])

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
                      {:desc "open lazygit in a new tmux window"
                       :noremap true
                       :silent true})))
  (comment "---- JOURNAL ----")
  (when vim.env.JOURNAL
    (util.set-keys [[:n
                     :<leader>oj
                     #(vim.cmd (.. ":$tabnew" :$JOURNAL/journal.adoc))
                     {:desc "open journal in a new tab"
                      :noremap true
                      :silent true}]
                    [:n
                     :<leader>ov
                     #(vim.cmd (.. ":$tabnew" :$JOURNAL/vim/vim.adoc))
                     {:desc "open vim notes in a new tab"
                      :noremap true
                      :silent true}]]))
  (comment "---- PLUGINS ----")
  (util.set-keys [[:n :<leader>L ":Lazy<cr>" {:noremap true :silent true}]
                  [:n
                   :<leader>u
                   ":UndotreeToggle<cr>"
                   {:desc "toggle undotree" :noremap true :silent true}]]))

(fn oil-maps []
  (let [oil (autoload :oil)]
    (vim.keymap.set :n :<leader>e #(oil.open)
                    {:desc "explore files in current file's path"
                     :noremap true
                     :silent true})))

(fn telescope-maps []
  (let [builtin (autoload :telescope.builtin)
        maps [[:n
               :<leader>f
               builtin.find_files
               {:desc "telescope (f)iles" :noremap true}]
              [:n
               :<leader>p
               builtin.oldfiles
               {:desc "telescope oldfiles" :noremap true}]
              [:n
               :<leader>g
               builtin.git_files
               {:desc "telescope (g)it files" :noremap true}]
              [:n
               :<leader>k
               builtin.keymaps
               {:desc "telescope (k)eymaps" :noremap true}]]]
    (util.set-keys maps)))

(fn gitsigns-maps []
  (let [gitsigns (autoload :gitsigns)
        nav [[:n
              "]g"
              #(gitsigns.nav_hunk :next {:wrap false :preview true})
              {:noremap true :desc "jump to next git hunk"}]
             [:n
              "[g"
              #(gitsigns.nav_hunk :prev {:wrap false :preview true})
              {:noremap true :desc "jump to previous git hunk"}]]
        staging [[:n
                  :<localleader>gs
                  gitsigns.stage_hunk
                  {:noremap true :desc "(g)it (s)tage hunk"}]
                 [:n
                  :<localleader>gu
                  gitsigns.undo_stage_hunk
                  {:noremap true :desc "(g)it (u)ndo staged hunk"}]
                 [:n
                  :<localleader>gr
                  gitsigns.reset_hunk
                  {:noremap true :desc "(g)it (r)eset hunk"}]
                 [:n
                  :<localleader>gS
                  gitsigns.stage_buffer
                  {:noremap true :desc "(g)it (S)tage buffer"}]
                 [:n
                  :<localleader>gR
                  gitsigns.reset_buffer
                  {:noremap true :desc "(g)it (R)eset buffer"}]
                 [:v
                  :<localleader>gs
                  #(gitsigns.stage_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                  {:noremap true :desc "(g)it (s)tage hunk"}]
                 [:v
                  :<localleader>gr
                  #(gitsigns.reset_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                  {:noremap true :desc "(g)it (r)eset hunk"}]]
        blame [[:n
                :<localleader>gb
                #(gitsigns.blame_line {:full true})
                {:noremap true :desc "(g)it show line (b)lame"}]
               [:n
                :<localleader>gB
                gitsigns.toggle_current_line_blame
                {:noremap true :desc "(g)it toggle current line (B)lame"}]]
        view [[:n
               :<localleader>gp
               gitsigns.preview_hunk
               {:noremap true :desc "(g)it (p)review hunk"}]
              [:n
               :<localleader>gd
               gitsigns.diffthis
               {:noremap true :desc "(g)it show (d)iff"}]
              [:n
               :<localleader>gD
               gitsigns.toggle_deleted
               {:noremap true :desc "(g)it toggle (D)eleted hunks"}]]
        list [[:n
               :<localleader>gl
               gitsigns.setloclist
               {:noremap true :desc "show buffer (g)it hunks in (l)oclist"}]
              [:n
               :<localleader>gc
               #(gitsigns.setqflist :all)
               {:noremap true :desc "show all (g)it hunks in qui(c)kfix list"}]]
        mappings (core.concat nav staging blame view list)]
    (util.set-keys mappings)))

(fn neogit-maps []
  (let [neogit (autoload :neogit)]
    (vim.keymap.set :n :<leader>og neogit.open
                    {:desc "(o)pen (n)eogit" :noremap true})))

{: setup : oil-maps : telescope-maps : gitsigns-maps : neogit-maps}
