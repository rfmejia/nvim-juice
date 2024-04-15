(local base-path (.. (vim.fn.stdpath :data) :/lazy))

(fn ensure-installed [options]
  "Clone bootstrap plugins if not installed and add to `runtimepath`"
  (let [install-path (string.format "%s/%s" base-path options.repo)
        assert-string (fn [value err-msg]
                        (when (not (= (type value) :string))
                          (error err-msg)))
        path-exists? ((. (or vim.uv vim.loop) :fs_stat) install-path)]
    (assert-string options.user)
    (assert-string options.repo)
    (assert-string options.branch)
    (when (not path-exists?)
      (print (string.format "Cloning %s/%s:%s to %s..." options.user
                            options.repo options.branch install-path))
      (vim.fn.system [:git
                      :clone
                      "--filter=blob:none"
                      (string.format "https://github.com/%s/%s.git"
                                     options.user options.repo)
                      (string.format "--branch=%s" options.branch)
                      install-path]))
    (vim.opt.rtp:prepend install-path)))

(fn setup []
  (ensure-installed {:user :Olical :repo :nfnl :branch :main})
  (ensure-installed {:user :folke :repo :lazy.nvim :branch :stable}))

{: setup}
