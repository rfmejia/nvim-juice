; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.auto-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :git-info :journal-tools :tmux-nav
                 :trim-whitespace)
