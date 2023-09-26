(module scalametals
  {autoload {s aniseed.string
             u util
             lsp juice.lsp
             sl juice.statusline
             metals metals}
   })

(defn initialize-metals []
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
    (u.vmap "K" (. (require :metals) :type_of_range) [u.noremap u.silent])
    (u.nmap "<localleader>cw" (fn [] ((. (require :metals) :hover_worksheet) {:border "rounded"})) [u.noremap u.silent])
    (u.nmap "<localleader>mm" (. (require :metals) :commands) [u.noremap u.silent])
    (u.nmap "<localleader>tt" (. (require :metals.tvp) :toggle_tree_view) [u.noremap u.silent])
    (u.nmap "<localleader>tr" (. (require :metals.tvp) :reveal_in_tree) [u.noremap u.silent])
    )

  (set config.on_attach on-attach)

  (metals.initialize_or_attach config))

(defn register-init-command []
  (vim.api.nvim_create_user_command :MetalsInit
                                    (fn [] (initialize-metals))
                                    {:desc "Start and connect to a Metals server"}))
