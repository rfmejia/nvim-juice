(vim.pack.add ["https://github.com/nvim-orgmode/orgmode"])

(let [{: autoload} (require :nfnl.module)
      orgmode (autoload :orgmode)
      org-home (or vim.env.JOURNAL "~/journal")
      opts {:org_agenda_files (.. org-home "/**/*")
            :org_default_notes_file (.. org-home :/refile.org)
            :org_capture_templates {:b {:description :Bookmark
                                        :template "- %<%H:%M> [%a]\n%?\n"
                                        :headline :notes
                                        :datetree {:tree_type :day
                                                   :reversed true}}
                                    :c {:description "Clip register"
                                        :template "- %<%H:%M> [%a]\n%?\n%x\n"
                                        :headline :notes
                                        :datetree {:tree_type :day
                                                   :reversed true}}
                                    :n {:description "Take note"
                                        :template "- %<%H:%M> %? \n"
                                        :headline :notes
                                        :datetree {:tree_type :day
                                                   :reversed true}}
                                    :t {:description "Add task - unfiled"
                                        :template "* TODO  %?\n  %U\n"
                                        :headline :unfiled}
                                    :2 {:description "Add task - < 20 min"
                                        :template "* TODO  %?\n  %U\n"
                                        :headline :quick}}}]
  (orgmode.setup opts))
