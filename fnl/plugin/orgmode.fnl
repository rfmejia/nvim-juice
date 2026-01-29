(let [{: autoload} (require :nfnl.module)
      pacman (autoload :pacman)
      util (autoload :juice.util)
      pack "https://github.com/nvim-orgmode/orgmode"
      org-home (or vim.env.JOURNAL "~/journal")
      opts {:org_agenda_files (.. org-home "/**/*")
            :org_default_notes_file (.. org-home :/journal.org)
            :org_capture_templates {:b {:description :Bookmark
                                        :template "- %? [%a]\n"
                                        :target (.. org-home :/bookmarks.org)}
                                    :c {:description "Clip register"
                                        :template "- %? \n%x\n"
                                        :target (.. org-home :/clips.org)}
                                    :t {:description "Add task - unfiled"
                                        :template "* TODO  %?\n  %U\n"
                                        :headline :unfiled}
                                    :m {:description "Add task - myshake"
                                        :template "* TODO  %?\n  %U\n"
                                        :headline :myshake}
                                    :2 {:description "Add task - < 20 min"
                                        :template "* TODO  %?\n  %U\n"
                                        :headline :quick}}}]
  (pacman.add pack)
  (pacman.load-now :orgmode)
  (util.call :orgmode :setup opts))
