(comment "Check and load `nfnl` pack; Clone repository if not")
(let [nfnl-url "https://github.com/rfmejia/nfnl"
      pack-path (.. (vim.fn.stdpath :data) :/site/pack/juice/start)
      dir-exists? (fn [path]
                    ((. (or vim.uv vim.loop) :fs_stat) path))]
  (when (not (dir-exists? (.. pack-path :/nfnl)))
    (vim.notify (string.format "[bootstrap] Cloning %s to %s..." nfnl-url
                               pack-path))
    (case-try (: (vim.system [:mkdir :-p pack-path]) :wait)
      {:code 0} (: (vim.system [:git :-C pack-path :clone nfnl-url]) :wait)
      {:code 0} (vim.notify "[bootstrap] OK")
      (catch {: stderr}
             (vim.notify (.. "[bootstrap] Could not clone `nfnl`: " stderr)
                         vim.log.levels.ERROR)))
    (vim.cmd :packloadall!)))

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.call-setup :juice.options :juice.colorscheme :juice.plugins
                 :juice.mappings :juice.commands :juice.lsp :juice.dotenvrc
                 :journal-tools :git-info :tmux-nav :trim-whitespace
                 :wildgitignore)

;; TODO use vim-native plug management and implement a custom lazy loading solution (:h packadd)
;; TODO Create your own auto-pairs plugins
;; TODO Create your own surround plugins
;; TODO Finish marksman module

;; FIXME When highlighting TODO/FIXME/NOTE the highlight is enabled only when moving from a split
