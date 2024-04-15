(fn setup []
  (let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)
        lazy-exists? ((. (or vim.uv vim.loop) :fs_stat) lazypath)]
    (when (not lazy-exists?)
      (vim.fn.system [:git
                      :clone
                      "--filter=blob:none"
                      "https://github.com/folke/lazy.nvim.git"
                      :--branch=stable
                      lazypath]))
    (vim.opt.rtp:prepend lazypath)))

{: setup}
