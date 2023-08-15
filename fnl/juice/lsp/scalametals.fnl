(module scalametals
  {autoload {s aniseed.string
             u util
             lsp juice.lsp
             sl juice.statusline
             metals metals}
   import-macros [[ac :aniseed.macros.autocmds]]})

(local nmap u.nmap)
(local noremap u.noremap)
(local silent u.silent)
(local lua-cmd u.lua-cmd)

(defn initialize-metals []
  (set vim.go.shortmess (.. vim.go.shortmess "c"))
  (set vim.opt.statusline (sl.build-statusline ["%{g:metals_status}"]))
  (tset vim.g :metals_status "Initializing Metals...")

  ; TODO delete this if the following works
  (nmap "<localleader>cw" (lua-cmd "require('metals').hover_worksheet()") [noremap silent])

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
                                    (lambda [opts] (initialize-metals))
                                    {:desc "Start and connect to a Metals server"}))
