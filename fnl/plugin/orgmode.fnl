(let [{: autoload} (require :nfnl.module)
      pacman (autoload :pacman)
      pack "https://github.com/nvim-orgmode/orgmode"
      util (autoload :juice.util)
      opts {:org_agenda_files "~/orgfiles/**/*"
            :org_default_notes_file "~/orgfiles/refile.org"}
      keymaps [[:n :goa ":Org agenda<CR>" {:desc "[orgmode] start agenda"}]
               [:n :goc ":Org capture<CR>" {:desc "[orgmode] start capture"}]]]
  (pacman.add pack)
  (pacman.load-on-keymap :orgmode [:goa :goc]
                         (fn []
                           (util.call :orgmode :setup opts)
                           (util.set-keys keymaps))))
