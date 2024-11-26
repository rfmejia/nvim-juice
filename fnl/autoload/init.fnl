(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local hash-command :md5sum)
(local hash-file-path (.. vim.env.XDG_STATE_HOME :/nvim/autoload.json))

(lambda load-hashes [path]
  (vim.json.decode (core.slurp path) {}))

(lambda save-hashes [path obj]
  (let [now (os.time)]
    (tset obj :updated now)
    (core.println path now obj)
    (core.spit path (vim.json.encode obj))))

(fn init-hash-file []
  (comment "TODO Create only if file does not exist")
  (let [now (os.time)]
    (save-hashes hash-file-path {:created (os.time)})))

(lambda compute-hash [input-string]
  "Given a string, compute its hash"
  (let [result (: (vim.system [hash-command] {:text true :stdin [input-string]})
                  :wait)]
    (if (= (. result :code) 0) (. (vim.fn.split (. result :stdout) " ") 1)
        (do
          (vim.notify vim.log.levels.ERROR
                      (.. "Could not compute hash" (. result :stderr)))
          nil))))

(lambda hash-valid? [lookup-table key-hash source-hash]
  (let [hash-info (. lookup-table key-hash)]
    (if (= nil hash-info) {:error :missing}
        (not= source-hash (. hash-info :source)) {:error :mismatch}
        (not (. hash-info :allowed)) {:error :rejected}
        :else nil)))

(assert (assert (= :missing (. (hash-valid? {} :a :1234) :error)))
        (assert (= :mismatch (. (hash-valid? {:a {:source :1234 :allowed true}}
                                             :a :12345)
                                :error)))
        (assert (= :rejected (. (hash-valid? {:a {:source :1234 :allowed false}}
                                             :a :1234)
                                :error)))
        (assert (= nil
                   (hash-valid? {:a {:source :1234 :allowed true}} :a :1234))))

(fn get-lua-project []
  (local path (-?> (vim.fs.root 0 :.nvim)
                   (.. :/.nvim/project.lua)))
  (local source (-?> path
                     (core.slurp)))
  (when (and source (> (length source) 0))
    {: path : source}))

(lambda load-source? [source])

(lambda allow-project-source [path source allowed]
  (let [key-hash (compute-hash path)
        source-hash (compute-hash source)
        valid-hashes (load-hashes hash-file-path)
        entry {:source source-hash : allowed}]
    (tset valid-hashes key-hash entry)
    (save-hashes hash-file-path valid-hashes)))

(lambda allow-source [allowed]
  (local project (get-lua-project))
  (when project
    (allow-project-source project.path project.source allowed)))

(comment "FIXME Do not use `tset`, update table without mutating")

(comment (init-hash-file)
  (load-hashes hash-file-path)
  (allow-source (.. (vim.fs.root 0 :.nvim) :/.nvim/project.lua) true)
  (autoload-project-fnl))

(fn autoload-project-fnl []
  (local project (get-lua-project))
  (when project
    (let [key-hash (compute-hash project.path)
          source-hash (compute-hash project.source)
          valid-hashes (load-hashes hash-file-path)
          errors (hash-valid? valid-hashes key-hash source-hash)]
      (if (= nil errors)
          (do
            (vim.cmd.source project.path)
            (vim.notify "Project file valid, loaded" vim.log.levels.DEBUG))
          (= :rejected (. errors :error))
          (vim.notify "Project file is rejected" vim.log.levels.DEBUG)
          (= :mismatch (. errors :error))
          (vim.notify "Project file was changed but has not been approved or rejected"
                      vim.log.levels.DEBUG)
          :else
          (vim.notify "A new project file exists but has not been approved or rejected"
                      vim.log.levels.DEBUG)))))

(fn setup []
  (vim.api.nvim_create_autocmd :VimEnter
                               {:group :wildignore-group
                                :pattern "*"
                                :callback autoload-project-fnl})
  (vim.api.nvim_create_autocmd :DirChanged
                               {:group :wildignore-group
                                :pattern :global
                                :callback autoload-project-fnl}))

{: setup : allow-source}
