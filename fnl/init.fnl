; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local mappings (autoload :juice.mappings))
(local util (autoload :juice.util))

(util.auto-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :git-info :tmux-nav :trim-whitespace)

(let [journal-tools (autoload :journal-tools)]
  (journal-tools.setup {:maps (mappings.build-journal-maps)}))
