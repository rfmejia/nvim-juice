; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.call-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :juice.dotenvrc :git-info :tmux-nav
                 :trim-whitespace :wildgitignore :projectify)

(vim.api.nvim_create_user_command :JournalInit
                                  #(let [mappings (autoload :juice.mappings)]
                                     (util.call :journal-tools :setup
                                                {:maps mappings.journal-maps}))
                                  {:desc "Load default mappings for journal tools"})

;; TODO use vim-native plug management and implement a custom lazy loading solution (:h packadd)
;; TODO Create your own auto-pairs plugins
;; TODO Create your own surround plugins
;; TODO Finish marksman module
;; TODO Change `util.assoc-in` => `core.merge!`

;; FIXME When highlighting TODO/FIXME/NOTE the highlight is enabled only when moving from a split
