(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local fs (autoload :nfnl.fs))
(local str (autoload :nfnl.string))
(local util (autoload :juice.util))

(lambda sanitize-url [url]
  (let [trimmed (str.trim url)]
    (if (str.ends-with? trimmed "/")
        (string.sub trimmed 1 (core.dec (string.len url)))
        trimmed)))

(lambda reify-spec [user-spec]
  "Validates and computes metadata for package specs"
  (if (and (core.table? user-spec) (str.blank? (. user-spec :src)))
      [:error "Missing `src`"]
      (not (or (core.table? user-spec) (core.string? user-spec)))
      [:error "Spec is not a table or string"]
      :else
      (let [spec (if (core.string? user-spec) {:src (sanitize-url user-spec)}
                     (core.update user-spec :src sanitize-url))
            name (or (?. spec :name) (core.last (str.split (. spec :src) "/")))
            full-spec (core.assoc spec :name name)]
        [:ok full-spec])))

(lambda pack-cloned? [{: name} pack-path]
  "Checks if a package has already been cloned to pack-path"
  (fs.exists? (.. pack-path "/" name)))

(lambda spec->clone-cmd [{: src :version ?version} pack-path]
  "Generates command to clone repository"
  (if ?version
      [:git :-C pack-path :clone (string.format "--branch=%s" ?version) src]
      [:git :-C pack-path :clone src]))

(lambda clone-src [spec pack-path]
  "Clones repository to pack-path; creates pack-path directory if necessary"
  (vim.notify (string.format "[pack] Cloning %s to %s..." (. spec :name)
                             pack-path))
  (case-try (: (vim.system [:mkdir :-p pack-path]) :wait)
    {:code 0} (: (vim.system (spec->clone-cmd spec pack-path)) :wait)
    {:code 0} (vim.notify (string.format "[pack] Cloned %s" (. spec :name)))
    (catch {: stderr} (vim.notify (string.format "[pack] Could not clone %s: %s"
                                                 (. spec :name) stderr)
                                  vim.log.levels.WARN))))

(lambda add-spec [spec pack-path]
  (case (reify-spec spec)
    [:error reason] (vim.notify (string.format "[pack] Invalid spec: %s" reason)
                                vim.log.levels.WARN)
    [:ok full-spec] (when (not (pack-cloned? full-spec pack-path))
                      (clone-src full-spec pack-path))))

(lambda add [specs]
  "Add one or more package specifications

Parameters:
* `specs` (string|seq) A list of specs, where each spec is a git repository URL 
          to a pack or a dictionary containing:
          * `src`: git repository URL
          * `name` (string) optional: Name of the package, otherwise use
          the repository name
          * `version` (string) optional: Git branch to clone, otherwise
          use the repository default"
  (let [pack-path (.. (vim.fn.stdpath :data) :/site/pack/juice/opt)]
    (if (core.sequential? specs)
        (each [_ spec (ipairs specs)]
          (add-spec spec pack-path))
        (core.string? specs)
        (add-spec specs pack-path)
        :else
        (vim.notify "[pack] Invalid spec: must be a list or string"
                    vim.log.levels.WARN))))

(lambda load-now [packs]
  "Load packs

Parameters:
* `packs`  (string|seq) Package name(s) to load"
  (if (core.sequential? packs)
      (each [_ pack (ipairs packs)]
        (vim.cmd.packadd pack))
      (core.string? packs)
      (vim.cmd.packadd packs)))

(lambda load-on-event [packs events opts]
  "Load packs upon vim event(s)

Parameters:
* `packs`  (string|seq) Package name(s) to load
* `events` (string|seq) Vim event(s) that will trigger loading
* `opts`   (dict) Options to pass to `nvim_create_autocmd`"
  (vim.api.nvim_create_augroup :pack {:clear false})
  (let [user-callback (core.get opts :callback)]
    (core.update opts :callback
                 (fn [user-callback]
                   (fn []
                     (load-now packs)
                     (if (core.function? user-callback) (user-callback)
                         (core.string? user-callback) (vim.cmd user-callback)))))
    (core.assoc opts :group :pack :once true)
    (vim.api.nvim_create_autocmd events opts)))

(lambda load-on-keymap [packs keys callback ?trigger-after]
  "Load packs upon pressing keymap(s)

When triggered, the package(s) are loaded and all keymaps are unassigned before
calling the (optional) callback.

Parameters:
* `packs`          (string|seq) Package name(s) to load
* `keys`           (string|seq) Vim event(s) that will trigger loading
* `callback`       (function) Optional initialization function
* `?trigger-after` (boolean) Trigger the keymap after loading (default `true`)"
  (let [mode :n
        clear-triggers #(if (core.sequential? keys)
                            (each [_ lhs (ipairs keys)]
                              (vim.keymap.del mode lhs))
                            (core.string? keys)
                            (vim.keymap.del mode keys))
        start (fn [mode lhs user-opts]
                (load-now packs)
                (clear-triggers)
                (when (core.function? callback)
                  (callback))
                (when (or ?trigger-after (= nil ?trigger-after))
                  (vim.api.nvim_input lhs)))
        set-trigger (fn [mode lhs]
                      (vim.keymap.set mode lhs #(start mode lhs)))]
    (if (core.sequential? keys)
        (each [_ key (ipairs keys)]
          (set-trigger :n key))
        (core.string? keys)
        (set-trigger :n keys))))

{: add : load-now : load-on-event : load-on-keymap}
