; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.call-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :juice.lsp :juice.dotenvrc :journal-tools
                 :git-info :tmux-nav :trim-whitespace :wildgitignore)

;; TODO use vim-native plug management and implement a custom lazy loading solution (:h packadd)
;; TODO Create your own auto-pairs plugins
;; TODO Create your own surround plugins
;; TODO Finish marksman module

;; FIXME When highlighting TODO/FIXME/NOTE the highlight is enabled only when moving from a split
