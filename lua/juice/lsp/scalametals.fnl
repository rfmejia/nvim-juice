(fn initialize-metals []
  (let [u (require :juice.util)
        sl (require :juice.statusline)
        lsp (require :juice.lsp)
        metals (require :metals)
        telescope (require :telescope)
        ]

    (set vim.opt.signcolumn "yes:1")
    (set vim.go.shortmess (.. vim.go.shortmess "c"))
    (set vim.opt.statusline (sl.build-statusline ["%{g:metals_status}"]))
    (tset vim.g :metals_status "Initializing Metals...")

    (local config (metals.bare_config))
    (set config.settings {:showImplicitArguments true
                          :showImplicitConversionsAndClasses true
                          :showInferredType true
                          :decorationColor "Conceal"
                          :serverVersion "latest.snapshot"
                          :scalafixRulesDependencies ["com.nequissimus::sort-imports:0.6.1"]
                          })
    (set config.init_options.statusBarProvider "on")
    (set config.capabilities (vim.lsp.protocol.make_client_capabilities))
    (tset config :tvp {:panel_alignment "right"
                       :toggle_node_mapping "<CR>"
                       :node_command_mapping "r"
                       })


    (fn on-attach [client bufnr]
      (lsp.set-buffer-opts client bufnr)
      (set vim.opt.omnifunc "v:lua.vim.lsp.omnifunc")
      (u.vmap "K" (fn [] (metals.type_of_range)) [:noremap :silent])
      (u.nmap "<localleader>mw" (fn [] (metals.hover_worksheet {:border "rounded"})) [:noremap :silent])
      (u.nmap "<localleader>mm" (fn [] (telescope.extensions.metals.commands)) [:noremap :silent])
      (u.nmap "<localleader>mt" (. (require :metals.tvp) :toggle_tree_view) [:noremap :silent])
      (u.nmap "<localleader>mr" (. (require :metals.tvp) :reveal_in_tree) [:noremap :silent]))

    (set config.on_attach on-attach)

    ; Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)
    (vim.api.nvim_create_augroup :metals-group [])
    (vim.api.nvim_create_autocmd :FileType {:group :metals-group
                                            :pattern ["scala" "sbt" "java"]
                                            :callback (fn [] (metals.initialize_or_attach config))})

    ; Initialize Metals for the first time
    (metals.initialize_or_attach config)))

(fn register-init-command []
  (vim.api.nvim_create_user_command :MetalsInit
                                    (fn [] (initialize-metals))
                                    {:desc "Start and connect to a Metals server"}))

{: register-init-command}
