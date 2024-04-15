(lambda ensure-installed [user repo branch]
  "Clone bootstrap plugins if not installed and add to `runtimepath`"
  (let [base-path (.. (vim.fn.stdpath :data) :/lazy)
        install-path (string.format "%s/%s" base-path repo)
        path-exists? ((. (or vim.uv vim.loop) :fs_stat) install-path)]
    (when (not path-exists?)
      (let [message (string.format "Cloning %s/%s:%s to %s..." user repo branch
                                   install-path)
            git-cmd [:git
                     :clone
                     "--filter=blob:none"
                     (string.format "https://github.com/%s/%s.git" user repo)
                     (string.format "--branch=%s" branch)
                     install-path]]
        (print message)
        (vim.fn.system git-cmd)))
    (vim.opt.rtp:prepend install-path)))

(fn setup []
  (ensure-installed :Olical :nfnl :main)
  (ensure-installed :folke :lazy.nvim :stable))

{: setup}
