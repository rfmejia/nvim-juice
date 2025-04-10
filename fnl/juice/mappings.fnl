(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(local general
       [[:n :Y :y$ {:desc "yank until the end of the line"}]
        [:n :<leader>w vim.cmd.w {:desc "write buffer" :silent true}]
        [:n :<leader>r vim.cmd.registers {:desc "list registers"}]
        [:n
         :<F2>
         "let @+ = getreg('%')"
         {:desc "copy current file path to clipboard"}]
        [:n :<F5> vim.cmd.make {:desc "trigger `make` in shell"}]
        [:n
         :<leader>n
         #(let [is-enabled (and (vim.opt.number:get)
                                (vim.opt.relativenumber:get))]
            (core.merge! vim.opt
                         {:number (not is-enabled)
                          :relativenumber (not is-enabled)}))
         {:desc "toggle number and relativenumber options"}]
        [:n :<leader>ol ":Lazy<cr>" {:desc "open lazy.nvim" :silent true}]
        [:n
         :<leader>on
         #(let [config-path (.. vim.env.XDG_CONFIG_HOME :/nvim)]
            (vim.cmd (.. ":$tabnew" config-path))
            (vim.cmd.tcd config-path)
            (comment -?>> (util.call :juice.dotenvrc :read-path-list)
              (set vim.opt_local.path)))
         {:desc "open nvim config in a new tab" :silent true}]])

(local filters
       (let [repeat (fn [times value]
                      (var acc "")
                      (for [i 1 times]
                        (set acc (.. acc value)))
                      acc)
             vimgrep-cmd (.. ":vimgrep // **/*" (repeat 6 :<left>))
             filter-cmd (fn [cmd]
                          (.. ":filter '' " cmd
                              (repeat (+ 2 (length cmd)) :<left>)))]
         [[:n :<leader>f ":find " {:desc "pre-fill find command"}]
          [:n :<leader>v vimgrep-cmd {:desc "pre-fill vimgrep command"}]
          [:n
           :<leader>p
           (filter-cmd "browse oldfiles")
           {:desc "filter and select from oldfiles"}]
          [:n :<leader>k (filter-cmd :map) {:desc "filter keymaps"}]]))

(local jumps [[:n :<C-d> :<C-d>zz]
              [:n :<C-u> :<C-u>zz]
              [:n :<C-o> :<C-o>zz]
              [:n :<C-i> :<C-i>zz]])

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
;; TODO Replace these with putting signs on the sign column
(local marks (let [marks [:A :R :S :T :z :x :c :d]
                   create-mark #[:n
                                 (.. :m (string.lower $1))
                                 (.. :m $1 ":echo 'Marked " $1 "'<cr>")]
                   jump-to-mark #[:n (.. "'" (string.lower $1)) (.. "`" $1)]]
               (core.concat [[:n
                              "''"
                              #(vim.cmd.marks (table.concat marks))
                              {:desc "list quick marks (ARST and zxcd)"}]]
                            (core.map #(create-mark $1) marks)
                            (core.map #(jump-to-mark $1) marks))))

(local buffers [[:n :<leader>b ":buffers<cr>:buffer<Space>"]
                [:n
                 :<leader>x
                 ":bp|bdelete #<cr>"
                 {:desc "[buffer] close buffer"}]])

(local tabs [[:n :<leader>ts ":tab split<cr>" {:silent true}]
             [:n "[t" vim.cmd.tabprevious]
             [:n "]t" vim.cmd.tabnext]
             [:n "[T" vim.cmd.tabfirst]
             [:n "]T" vim.cmd.tablast]])

(local quickfix [[:n :<leader>co vim.cmd.copen {:desc "open quickfix list"}]
                 [:n :<leader>cc vim.cmd.cclose {:desc "close quickfix list"}]
                 [:n
                  "[q"
                  vim.cmd.cprevious
                  {:desc "jump to the previous entry in the current quickfix list"}]
                 [:n
                  "]q"
                  vim.cmd.cnext
                  {:desc "jump to the next entry in the current quickfix list"}]
                 [:n
                  :<leader>C
                  vim.cmd.chistory
                  {:desc "list quickfix history"}]
                 [:n
                  "[C"
                  vim.cmd.colder
                  {:desc "jump to the previous quickfix list"}]
                 [:n
                  "]C"
                  vim.cmd.cnewer
                  {:desc "jump to the newer quickfix list"}]])

(local loclist
       [[:n :<leader>lo vim.cmd.lopen {:desc "open loclist list"}]
        [:n :<leader>lc vim.cmd.lclose {:desc "close loclist list"}]
        [:n
         "[l"
         vim.cmd.lprevious
         {:desc "jump to previous entry in the current loclist"}]
        [:n
         "]l"
         vim.cmd.lnext
         {:desc "jump to next entry in the current loclist"}]
        [:n :<leader>L vim.cmd.lhistory {:desc "list loclist history"}]
        [:n "[L" vim.cmd.lolder {:desc "jump to the previous loclist"}]
        [:n "]L" vim.cmd.lnewer {:desc "jump to the newer loclist"}]])

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

(local terminal-maps [[:t :<C-o><C-o> "<C-\\><C-n>"]
                      [:n :<leader>otc #(vim.cmd.tabnew "term://bash")]
                      [:n :<leader>ots #(vim.cmd.split "term://bash")]
                      [:n :<leader>otv #(vim.cmd.vsplit "term://bash")]
                      [:n :<leader>ott ":tabnew term://"]
                      [:n
                       :<leader>otd
                       (fn []
                         (vim.cmd.tabnew "term://w3m duckduckgo.com")
                         (vim.cmd.startinsert))]])

(comment "-- PLUGIN-SPECIFIC MAPPINGS --")

(local oil-maps [[:n
                  :<leader>e
                  #(util.call :oil :open)
                  {:desc "[oil] explore files in current file's path"
                   :silent true}]])

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
                    :<localleader>gt
                    #(util.call :gitsigns :toggle_signs)
                    {:desc "[gitsigns] toggle sign visibility"}]
                   [:n
                    :<localleader>gp
                    #(util.call :gitsigns :preview_hunk)
                    {:desc "[gitsigns] (g)it (p)review hunk"}]
                   [:n
                    :<localleader>gi
                    #(util.call :gitsigns :preview_hunk_inline)
                    {:desc "[gitsigns] (g)it toggle (D)eleted hunks"}]
                   [:n
                    :<localleader>gd
                    #(util.call :gitsigns :diffthis)
                    {:desc "[gitsigns] (g)it show (d)iff"}]]
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

(comment "-- OPEN OTHER FILES AND PROGRAMS  --")

(local journal-launchers
       [[:n
         :<leader>oj
         (fn []
           (util.call :journal-tools :setup)
           (vim.cmd (.. ":$tabnew" :$JOURNAL/journal.md)))
         {:desc "open journal in a new tab" :silent true}]
        [:n
         :<leader>ov
         (fn []
           ((. (autoload :journal-tools) :load-journal-tools))
           (vim.cmd (.. ":$tabnew" :$JOURNAL/linux/vim.adoc)))
         {:desc "open vim notes in a new tab" :silent true}]])

(local lazygit-launcher [[:n
                          :<leader>og
                          (if vim.env.TMUX ":!tmux neww lazygit<cr><cr>"
                              (fn []
                                (vim.cmd.tabnew "term://lazygit")
                                (vim.cmd.startinsert)))
                          {:desc "open lazygit in a new tab or tmux window"
                           :silent true}]])

(local tmux-apps {;; Add editor context-specific apps here, lazydocker is not a good example
                  :lazydocker [[:n
                                :<leader>od
                                ":!tmux neww lazydocker<cr><cr>"
                                {:desc "open lazydocker in a new tmux window"
                                 :silent true}]]})

(fn setup []
  (let [mappings (core.concat general filters jumps undo-steps dates marks
                              buffers tabs quickfix loclist search-replace
                              visual-indent terminal-maps)]
    (util.set-keys mappings)
    (comment "select completion binding item")
    (vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
    (when (util.executable? :lazygit) (util.set-keys lazygit-launcher))
    (when vim.env.JOURNAL (util.set-keys journal-launchers))
    (when vim.env.TMUX
      (each [app maps (pairs tmux-apps)]
        (when (util.executable? app)
          (util.set-keys maps))))))

{: setup : oil-maps : gitsigns-maps : dadbod-maps : journal-maps}
