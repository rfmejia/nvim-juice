(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local pack (autoload :pack))
(local util (autoload :juice.util))

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

{:setup (fn []
          (pack.add [{:src "https://github.com/tpope/vim-dadbod"}
                     {:src "https://github.com/kristijanhusak/vim-dadbod-completion"}
                     {:src "https://github.com/lewis6991/gitsigns.nvim"}])
          (pack.load-on-event [:vim-dadbod :vim-dadbod-completion] :FileType
                              {:pattern [:sql :mysql :pgsql]
                               :callback #(util.set-keys dadbod-maps)})
          (pack.load-on-keymap :gitsigns.nvim :<localleader>gt
                               (fn []
                                 (util.call-setup :gitsigns)
                                 (util.set-keys gitsigns-maps)
                                 (util.call :gitsigns :toggle_signs))))}
