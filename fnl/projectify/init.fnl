(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local hash-command :md5sum)
(local hash-file-path (.. vim.env.XDG_STATE_HOME :/nvim/projectify.json))

(comment {:TODO ["Find ergonomic way to initialize project"
                 "Create init hash only if file does not exist"
                 "Create function to read only chmod 600 init-hash and project files"
                 "Move effectful functions to the edges"]
          :FIXME ["Do not use `tset`, update table without mutating"]}
  (init-hash-file))

(lambda load-hashes [path]
  (vim.json.decode (core.slurp path) {}))

(lambda save-hashes [path obj]
  (let [now (os.time)]
    (tset obj :updated now)
    (core.spit path (vim.json.encode obj))))

(fn init-hash-file []
  (let [now (os.time)]
    (save-hashes hash-file-path {:created (os.time)})))

(lambda compute-hash [input-string]
  "Given a string, compute its hash"
  (let [result (: (vim.system [hash-command] {:text true :stdin [input-string]})
                  :wait)]
    (if (= (. result :code) 0) (. (vim.fn.split (. result :stdout) " ") 1)
        (do
          (vim.notify (.. "Could not compute hash" (. result :stderr))
                      vim.log.levels.ERROR)
          nil))))

(fn read-local-project-file []
  (local path (-?> (vim.fs.root 0 :.nvim)
                   (.. :/.nvim/project.lua)))
  (local source (-?> path
                     (core.slurp)))
  (when (and source (> (length source) 0))
    {: path : source}))

(fn project-allowed? [project]
  (if (not (and project project.path project.source)) {:error :nil-project}
      (let [key-hash (compute-hash project.path)
            source-hash (compute-hash project.source)
            hash-lookup (load-hashes hash-file-path)
            valid-hash (. hash-lookup key-hash)]
        (if (= nil valid-hash) {:error :missing}
            (not= source-hash (. valid-hash :source)) {:error :mismatch}
            (not (. valid-hash :allowed)) {:error :disallowed}
            :else nil))))

(lambda allow-project [{: path : source} allowed]
  (let [key-hash (compute-hash path)
        source-hash (compute-hash source)
        valid-hashes (load-hashes hash-file-path)
        entry {:source source-hash : allowed}]
    (tset valid-hashes key-hash entry)
    (save-hashes hash-file-path valid-hashes)
    (vim.cmd.source path)))

(lambda ask-allow-project [project ?prompt]
  (local prompt (.. (if ?prompt (.. ?prompt "; ") "") "Allow source? (y/N) "))
  (vim.ui.input {: prompt}
                #(let [answer (or (= $1 :y) (= $1 :Y))]
                   (allow-project project answer)
                   (if answer
                       (vim.notify "Project allowed and loaded"
                                   vim.log.levels.INFO)
                       (vim.notify "Project disallowed" vim.log.levels.INFO)))))

(fn load-project [project]
  (let [errors (project-allowed? project)]
    (if (= nil errors)
        (do
          (vim.cmd.source project.path)
          (vim.notify "Project file loaded" vim.log.levels.INFO))
        (or (= :nil-project (. errors :error))
            (= :disallowed (. errors :error)))
        (comment "do nothing")
        (= :mismatch (. errors :error))
        (ask-allow-project project "Project file was updated")
        :else
        (ask-allow-project project "New project file found"))))

(fn load-local-project []
  (load-project (read-local-project-file)))

(fn setup []
  (vim.api.nvim_create_autocmd :VimEnter
                               {:group :wildignore-group
                                :pattern "*"
                                :callback load-local-project})
  (vim.api.nvim_create_autocmd :DirChanged
                               {:group :wildignore-group
                                :pattern :global
                                :callback load-local-project})
  (vim.api.nvim_create_user_command :ProjectifyInitHash init-hash-file
                                    {:desc "[projectify] Initialize hash file"})
  (vim.api.nvim_create_user_command :ProjectifyLoad load-local-project
                                    {:desc "[projectify] Load project file"})
  (vim.api.nvim_create_user_command :ProjectifyAllow
                                    #(do
                                       (allow-project (read-local-project-file)
                                                      true)
                                       (vim.notify "Project allowed and loaded"
                                                   vim.log.levels.INFO))
                                    {:desc "[projectify] Allow and load project file"})
  (vim.api.nvim_create_user_command :ProjectifyDisallow
                                    #(do
                                       (allow-project (read-local-project-file)
                                                      false)
                                       (vim.notify "Project disallowed"
                                                   vim.log.levels.INFO))
                                    {:desc "[projectify] Disallow project file"}))

(comment :Tests
  (assert (assert (= :missing (. (hash-valid? {} :a :1234) :error)))
          (assert (= :mismatch (. (hash-valid? {:a {:source :1234
                                                    :allowed true}}
                                               :a :12345)
                                  :error)))
          (assert (= :disallowed (. (hash-valid? {:a {:source :1234
                                                      :allowed false}}
                                                 :a :1234)
                                    :error)))
          (assert (= nil (hash-valid? {:a {:source :1234 :allowed true}} :a
                                      :1234)))))

{: setup : load-local-project : ask-allow-project}
