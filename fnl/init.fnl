; check and install core plugins
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local mappings (autoload :juice.mappings))
(local util (autoload :juice.util))

(util.call-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :git-info :tmux-nav :trim-whitespace)

(let [journal-tools (autoload :journal-tools)]
  (journal-tools.setup {:maps mappings.journal-maps}))

;; experimental: play around with vim-native file finding
(do
  (: vim.opt.path :append "**")
  (vim.keymap.set :n :<leader>f ":find<space>" {:desc "pre-fill find command"}))

;; TODO use vim-native plug management and implement a custom lazy loading solution (:h packadd)
;; TODO Finish marksman plugin
;; TODO Create your own auto-pairs plugins
