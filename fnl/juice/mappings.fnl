(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(local general
       [[:n :Y :y$ {:desc "yank until the end of the line"}]
        [:n :<leader>w vim.cmd.w {:desc "write buffer" :silent true}]
        [:n :<leader>r vim.cmd.registers {:desc "list registers"}]
        [:n :<F5> vim.cmd.make {:desc "trigger `make` in shell"}]
        [:n
         :<leader>n
         #(let [is-enabled (and (vim.opt.number:get)
                                (vim.opt.relativenumber:get))]
            (core.merge! vim.opt
                         {:number (not is-enabled)
                          :relativenumber (not is-enabled)}))
         {:desc "toggle number and relativenumber options"}]
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
              [:n :<C-i> :<C-i>zz]
              [:n "'." "'.zz"]])

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
(local quickmarks
       (let [marks [:A :S :D :F]
             create-mark (fn [key]
                           [:n
                            (.. :m (string.lower key))
                            (fn []
                              (vim.cmd.mark key)
                              (vim.notify (string.format "Marked %s" key)))
                            {:desc (string.format "[quickmark] set mark for %s"
                                                  key)}])
             jump-to-mark (fn [key]
                            [:n
                             (.. "'" (string.lower key))
                             #(case (vim.api.nvim_get_mark key {})
                                [_ _ _ filename] (vim.cmd.edit filename))
                             {:desc (string.format "[quickmark] jump to %s mark"
                                                   key)}])]
         (core.concat [[:n
                        "''"
                        #(vim.cmd.marks (table.concat marks))
                        {:desc (string.format "[quickmark] list quickmarks {%s}"
                                              (table.concat marks))}]]
                      (core.map #(create-mark $1) marks)
                      (core.map #(jump-to-mark $1) marks))))

(local buffers [[:n :<leader>b ":buffers<cr>:b<Space>"]
                [:n
                 :<leader>x
                 ":bp|bdelete #<cr>"
                 {:silent true :desc "[buffer] close buffer"}]])

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
         {:desc "prompt for buffer search and replace"}]])

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

(comment "-- OPEN OTHER FILES AND PROGRAMS  --")

(local journal-launchers
       [[:n
         :<leader>oj
         (fn []
           (vim.cmd.JournalInit)
           (vim.cmd (.. ":$tabnew" :$JOURNAL/journal.md)))
         {:desc "open journal in a new tab" :silent true}]
        [:n
         :<leader>ov
         (fn []
           (vim.cmd.JournalInit)
           (vim.cmd (.. ":$tabnew" :$JOURNAL/linux/vim.adoc)))
         {:desc "open vim notes in a new tab" :silent true}]])

(local mail-draft-launcher
       [[:n
         :<leader>om
         #(let [tmp-file (vim.fn.system [:mktemp :--suffix=.mail])]
           (vim.cmd (.. ":$tabnew" tmp-file)))
         {:desc "open a new mail draft in new tab"}]])

(local lazygit-launcher [[:n
                          :<leader>og
                          (if vim.env.TMUX ":!tmux neww lazygit<cr><cr>"
                              (fn []
                                (vim.cmd.tabnew "term://lazygit")
                                (vim.cmd.startinsert)))
                          {:desc "open lazygit in a new tab or tmux window"
                           :silent true}]])

(local opencode-launcher [[:n
                           :<leader>oc
                           (if vim.env.TMUX
                               ":!tmux split-window -l 40\\% opencode<cr><cr>"
                               (fn []
                                 (vim.cmd.vsplit "term://opencode")
                                 (vim.cmd.startinsert)))
                           {:desc "open opencode in a new tab or tmux window"
                            :silent true}]])

(local tmux-apps {;; Add editor context-specific apps here, lazydocker is not a good example
                  :lazydocker [[:n
                                :<leader>od
                                ":!tmux neww lazydocker<cr><cr>"
                                {:desc "open lazydocker in a new tmux window"
                                 :silent true}]]})

(fn setup []
  (let [mappings (core.concat general filters jumps undo-steps dates quickmarks
                              buffers tabs quickfix loclist search-replace
                              visual-indent terminal-maps mail-draft-launcher)]
    (util.set-keys mappings)
    (comment "select completion binding item")
    (vim.cmd "inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
    (when (util.executable? :lazygit) (util.set-keys lazygit-launcher))
    (when (util.executable? :opencode) (util.set-keys opencode-launcher))
    (when vim.env.JOURNAL (util.set-keys journal-launchers))
    (when vim.env.TMUX
      (each [app maps (pairs tmux-apps)]
        (when (util.executable? app)
          (util.set-keys maps))))))

{: setup}
