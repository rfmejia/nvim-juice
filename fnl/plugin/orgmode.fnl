(let [{: autoload} (require :nfnl.module)
      pacman (autoload :pacman)
      pack "https://github.com/nvim-orgmode/orgmode"
      util (autoload :juice.util)
      org-home (or vim.env.ORG_HOME "~/orgfiles")
      opts {:org_agenda_files (.. org-home "/**/*")
            :org_default_notes_file (.. org-home :/_main.org)
            :org_capture_templates {:c {:description "Clip register"
                                        :template "-  %?\n%x\n"
                                        :target (.. org-home :/_clips.org)}
                                    :m {:description "Add myshake task"
                                        :template "* TODO  %?\n  %u\n"
                                        :headline :myshake}
                                    :2 {:description "< 20 min task"
                                        :template "* TODO  %?\n  %u"
                                        :headline :quick}}
            :mappings {:global {:org_agenda :goa :org_capture :goc}}}]
  (pacman.add pack)
  (pacman.load-on-keymap :orgmode [:goa :goc]
                         (fn []
                           (util.call :orgmode :setup opts)
                           (vim.lsp.enable :org))))
