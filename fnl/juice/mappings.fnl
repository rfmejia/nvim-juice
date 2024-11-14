(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local notify (autoload :nfnl.notify))
(local util (autoload :juice.util))

(local general
       [[:n :Y :y$ {:desc "yank until the end of the line"}]
        [:n
         "<leader>;"
         ":<C-r>\""
         {:desc "paste register 0 contents in command mode"}]
        [:n :<leader>w ":w<cr>" {:desc "write buffer" :silent true}]
        [:n :<leader>r vim.cmd.registers {:desc "list registers"}]
        [:n :g? ":vert h<cr>" {:desc "open help" :silent true}]
        [:n
         :<F2>
         "let @+ = getreg('%')"
         {:desc "copy current file path to clipboard"}]
        [:n :<F5> vim.cmd.make {:desc "trigger `make` in shell"}]])

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

;; TODO make this into the `marksman` plugin
(local marks [[:n
               :<leader>mm
               #(vim.cmd.marks :ARSTarst)
               {:desc "list quick marks ARST"}]
              ;; TODO Replace these with putting signs on the sign column
              [:n :ma "ma:echo 'Quick marked a'<cr>"]
              [:n :mr "mr:echo 'Quick marked r'<cr>"]
              [:n :ms "ms:echo 'Quick marked s'<cr>"]
              [:n :mt "mt:echo 'Quick marked t'<cr>"]
              [:n :mA "mA:echo 'Quick marked A'<cr>"]
              [:n :mR "mR:echo 'Quick marked R'<cr>"]
              [:n :mS "mS:echo 'Quick marked S'<cr>"]
              [:n :mT "mT:echo 'Quick marked T'<cr>"]])

(local buffers [[:n :<leader>b ":buffers<cr>:buffer<Space>" {}]
                [:n "[B" vim.cmd.bfirst {}]
                [:n "]B" vim.cmd.blast {}]
                [:n "[b" vim.cmd.bprevious {}]
                [:n "]b" vim.cmd.bnext {}]
                [:n :<leader>x ":bp|bdelete #<cr>" {}]])

(local tabs [[:n :<leader>tn vim.cmd.tabnew {}]
             [:n :<leader>tc vim.cmd.tabclose {}]
             [:n :<leader>ts ":tab split<cr>" {}]
             [:n "[t" vim.cmd.tabprevious {}]
             [:n "]t" vim.cmd.tabnext {}]
             [:n "[T" vim.cmd.tabfirst {}]
             [:n "]T" vim.cmd.tablast {}]])

(local quickfix [[:n :<leader>co vim.cmd.copen {:desc "open quickfix list"}]
                 [:n :<leader>cc vim.cmd.cclose {:desc "close quickfix list"}]
                 [:n
                  "[c"
                  vim.cmd.cprevious
                  {:desc "jump to previous entry in quickfix list"}]
                 [:n
                  "]c"
                  vim.cmd.cnext
                  {:desc "jump to previous entry in quickfix list"}]
                 [:n
                  "[C"
                  vim.cmd.cfirst
                  {:desc "jump to previous entry in quickfix list"}]
                 [:n
                  "]C"
                  vim.cmd.clast
                  {:desc "jump to previous entry in quickfix list"}]
                 [:n :<leader>lo vim.cmd.lopen {:desc "open loclist list"}]
                 [:n :<leader>lc vim.cmd.lclose {:desc "close loclist list"}]
                 [:n
                  "[l"
                  vim.cmd.lprevious
                  {:desc "jump to previous entry in loclist"}]
                 [:n
                  "]l"
                  vim.cmd.lnext
                  {:desc "jump to next entry in loclist"}]
                 [:n
                  "[L"
                  vim.cmd.lfirst
                  {:desc "jump to first entry in loclist"}]
                 [:n
                  "]L"
                  vim.cmd.llast
                  {:desc "jump to last entry in loclist"}]])

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

(local plugins [[:n :<leader>L ":Lazy<cr>" {:silent true}]
                [:n
                 :<leader>u
                 ":UndotreeToggle<cr>"
                 {:desc "(undotree) toggle" :silent true}]])

(local journal-launchers
       [[:n
         :<leader>oj
         (fn []
           ((. (autoload :journal-tools) :load-journal-tools))
           (vim.cmd (.. ":$tabnew" :$JOURNAL/journal.md)))
         {:desc "open journal in a new tab" :silent true}]
        [:n
         :<leader>ov
         (fn []
           ((. (autoload :journal-tools) :load-journal-tools))
           (vim.cmd (.. ":$tabnew" :$JOURNAL/linux/vim.adoc)))
         {:desc "open vim notes in a new tab" :silent true}]])

(local tmux-apps {:lazygit [[:n
                             :<leader>og
                             ":!tmux neww lazygit<cr><cr>"
                             {:desc "open lazygit in a new tmux window"
                              :silent true}]]
                  ;; Add editor context-specific apps here, lazydocker is not a good example
                  :lazydocker [[:n
                                :<leader>od
                                ":!tmux neww lazydocker<cr><cr>"
                                {:desc "open lazydocker in a new tmux window"
                                 :silent true}]]})

(local oil-maps [[:n
                  :<leader>e
                  #(util.call :oil :open)
                  {:desc "[oil] explore files in current file's path"
                   :silent true}]])

(local telescope-maps [[:n
                        :<leader>f
                        #(util.call :telescope.builtin :find_files)
                        {:desc "[telescope] (f)iles"}]
                       [:n
                        :<leader>p
                        #(util.call :telescope.builtin :oldfiles)
                        {:desc "[telescope] oldfiles"}]
                       [:n
                        :<leader>g
                        #(util.call :telescope.builtin :git_files)
                        {:desc "[telescope] (g)it files"}]
                       [:n
                        :<leader>k
                        #(util.call :telescope.builtin :keymaps)
                        {:desc "[telescope] (k)eymaps"}]])

(local gitsigns-maps
       (let [nav [[:n
                   "]g"
                   #(util.call :gitsigns :nav_hunk :next
                               {:wrap false :preview true})
                   {:desc "[gitsigns] jump to next git hunk"}]
                  [:n
                   "[g"
                   #(util.call :gitsigns :nav_hunk :prev
                               {:wrap false :preview true})
                   {:desc "[gitsigns] jump to previous git hunk"}]]
             staging [[:n
                       :<localleader>gs
                       #(util.call :gitsigns :stage_hunk)
                       {:desc "[gitsigns] (g)it (s)tage hunk"}]
                      [:n
                       :<localleader>gu
                       #(util.call :gitsigns :undo_stage_hunk)
                       {:desc "[gitsigns] (g)it (u)ndo staged hunk"}]
                      [:n
                       :<localleader>gr
                       #(util.call :gitsigns :reset_hunk)
                       {:desc "(g)it (r)eset hunk"}]
                      [:n
                       :<localleader>gS
                       #(util.call :gitsigns :stage_buffer)
                       {:desc "[gitsigns] (g)it (S)tage buffer"}]
                      [:n
                       :<localleader>gR
                       #(util.call :gitsigns :reset_buffer)
                       {:desc "[gitsigns] (g)it (R)eset buffer"}]
                      [:v
                       :<localleader>gs
                       #(#(util.call :gitsigns :stage_hunk
                                     {(vim.fn.line ".") (vim.fn.line :v)}))
                       {:desc "[gitsigns] (g)it (s)tage hunk"}]
                      [:v
                       :<localleader>gr
                       #(util.call :gitsigns :reset_hunk
                                   {(vim.fn.line ".") (vim.fn.line :v)})
                       {:desc "[gitsigns] (g)it (r)eset hunk"}]]
             blame [[:n
                     :<localleader>gb
                     #(util.call :gitsigns :blame_line {:full true})
                     {:desc "[gitsigns] (g)it show line (b)lame"}]
                    [:n
                     :<localleader>gB
                     #(util.call :gitsigns :toggle_current_line_blame)
                     {:desc "[gitsigns] (g)it toggle current line (B)lame"}]]
             view [[:n
                    :<localleader>gp
                    #(util.call :gitsigns :preview_hunk)
                    {:desc "[gitsigns] (g)it (p)review hunk"}]
                   [:n
                    :<localleader>gd
                    #(util.call :gitsigns :diffthis)
                    {:desc "[gitsigns] (g)it show (d)iff"}]
                   [:n
                    :<localleader>gD
                    #(util.call :gitsigns :toggle_deleted)
                    {:desc "[gitsigns] (g)it toggle (D)eleted hunks"}]]
             list [[:n
                    :<localleader>gl
                    #(util.call :gitsigns :setloclist)
                    {:desc "[gitsigns] show buffer (g)it hunks in (l)oclist"}]
                   [:n
                    :<localleader>gc
                    #(util.call :gitsigns :setqflist :all)
                    {:desc "[gitsigns] show all (g)it hunks in qui(c)kfix list"}]]]
         (core.concat nav staging blame view list)))

(local dadbod-maps [[:n
                     "<localleader>d;"
                     ":DB g:db "
                     {:desc "[dadbod] run an sql statement in command mode"
                      :noremap true
                      :buffer true}]
                    [:n
                     :<localleader>dd
                     ":.DB g:db<cr>"
                     {:desc "[dadbod] run line as an sql statement"
                      :noremap true
                      :buffer true}]
                    [:n
                     :<localleader>dp
                     "vip:DB g:db<cr>"
                     {:desc "[dadbod] run paragraph as an sql statement"
                      :noremap true
                      :buffer true}]
                    [:n
                     :<localleader>db
                     ":%DB g:db<cr>"
                     {:desc "[dadbod] run buffer as sql statements"
                      :noremap true
                      :buffer true}]])

(local journal-maps [[:n
                      :<localleader>w
                      #(util.call :journal-tools :insert-week)
                      {:desc "[journal] insert current week as an h2 header"
                       :buffer true
                       :silent true}]
                     [:n
                      :<localleader>d
                      #(util.call :journal-tools :insert-day)
                      {:desc "[journal] insert current date as an h3 header"
                       :buffer true
                       :silent true}]
                     [:n
                      :<localleader>t
                      #(util.call :journal-tools :insert-time)
                      {:desc "[journal] insert current time as an h4 header"
                       :buffer true
                       :silent true}]
                     [:n
                      :<localleader>x
                      #(util.call :journal-tools :insert-task)
                      {:desc "[journal] insert current time as an h4 header"
                       :buffer true
                       :silent true}]])

(fn setup []
  (let [mappings (core.concat general jumps undo-steps dates marks buffers tabs
                              quickfix search-replace visual-indent plugins)]
    (util.set-keys mappings)
    (comment "select completion binding item")
    (vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
    (when vim.env.TMUX
      (each [app mappings (pairs tmux-apps)]
        (when (util.executable? app)
          (util.set-keys mappings))))
    (when vim.env.JOURNAL (util.set-keys journal-launchers))))

{: setup
 : oil-maps
 : telescope-maps
 : gitsigns-maps
 : dadbod-maps
 : journal-maps}
