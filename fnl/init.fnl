; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local mappings (autoload :juice.mappings))
(local util (autoload :juice.util))

(util.call-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :git-info :tmux-nav :trim-whitespace
                 :wildignore)

(let [journal-tools (autoload :journal-tools)]
  (journal-tools.setup {:maps mappings.journal-maps}))

;; TODO use vim-native plug management and implement a custom lazy loading solution (:h packadd)
;; TODO Create your own auto-pairs plugins
;; TODO Finish marksman module
;; TODO Modify wildignore plugin to remove all dependencies
