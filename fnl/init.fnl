; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local mappings (autoload :juice.mappings))
(local util (autoload :juice.util))

(util.call-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :juice.dotenvrc :git-info :tmux-nav
                 :trim-whitespace :wildgitignore :projectify)

(let [journal-tools (autoload :journal-tools)
      opts {:maps mappings.journal-maps}]
  (vim.api.nvim_create_user_command :JournalInit #(journal-tools.setup opts)
                                    {:desc "Load default mappings for journal tools"}))

;; TODO use vim-native plug management and implement a custom lazy loading solution (:h packadd)
;; TODO Create your own auto-pairs plugins
;; TODO Create your own surround plugins
;; TODO Finish marksman module
;; TODO Modify wildignore plugin to remove all dependencies

;; FIXME When highlighting TODO/FIXME/NOTE the highlight is enabled only when moving from a split
