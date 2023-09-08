(module scalametals
  {autoload {s aniseed.string
             u util
             lsp juice.lsp
             sl juice.statusline
             metals metals}
   import-macros [[ac :aniseed.macros.autocmds]]})

(defn initialize-metals []
  (set vim.opt.signcolumn "yes:1")
  (set vim.go.shortmess (.. vim.go.shortmess "c"))
  (set vim.opt.statusline (sl.build-statusline ["%{g:metals_status}"]))
  (tset vim.g :metals_status "Initializing Metals...")

  ; TODO delete this if the following works
  (u.nmap "<localleader>cw" (u.lua-cmd "require('metals').hover_worksheet()") [u.noremap u.silent])

  (local config (metals.bare_config))
  (set config.settings {:showImplicitArguments true
                        :showInferredType true
                        :decorationColor "Conceal"
                        :scalafixRulesDependencies ["com.nequissimus::sort-imports:0.6.1"]
                        })
  (set config.init_options.statusBarProvider "on")
  (set config.capabilities (vim.lsp.protocol.make_client_capabilities))

  (set config.on_attach (lambda [client bufnr]
                          (lsp.set-buffer-opts client bufnr)))

  (metals.initialize_or_attach config))

(defn register-init-command []
  (vim.api.nvim_create_user_command :MetalsInit
                                    (fn [] (initialize-metals))
                                    {:desc "Start and connect to a Metals server"}))
