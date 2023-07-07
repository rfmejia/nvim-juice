(module scalametals
  {autoload {s aniseed.string
             u util
             lsp juice.lsp
             sl juice.statusline
             metals metals
             dap dap
             dap-autocompl dap.ext.autocompl}
   import-macros [[ac :aniseed.macros.autocmds]]})

(local nmap u.nmap)
(local noremap u.noremap)
(local silent u.silent)
(local lua-cmd u.lua-cmd)

(defn- setup-debug-adapter-protocol []
  (set dap.configurations.scala [{:type "scala"
                                  :request "launch"
                                  :name "RunOrTest"
                                  :metals {:runType "runOrTestFile"}}
                                 {:type "scala"
                                  :request "launch"
                                  :name "Test Target"
                                  :metals {:runType "testTarget"}
                                  }])

  (nmap "<localleader>dc" (lua-cmd "require('dap').continue()") [noremap silent])
  (nmap "<localleader>dr" (lua-cmd "require('dap').repl.toggle()") [noremap silent])
  (nmap "<localleader>ds" (lua-cmd "require('lsp').show_scope()") [noremap silent])
  (nmap "<localleader>dK" (lua-cmd "require('dap').dap_ui_widgets.hover()") [noremap silent])
  (nmap "<localleader>db" (lua-cmd "require('dap').toggle_breakpoint()") [noremap silent])
  (nmap "<localleader>dso" (lua-cmd "require('dap').step_over()") [noremap silent])
  (nmap "<localleader>dsi" (lua-cmd "require('dap').step_into()") [noremap silent])
  (nmap "<localleader>dl" (lua-cmd "require('dap').run_last()") [noremap silent])

  (ac.augroup :dap-group
              [:FileType {:pattern "dap-repl"
                          :callback (lambda [] (dap-autocompl.attach))}]))

(defn initialize-metals []
  (set vim.go.shortmess (.. vim.go.shortmess "c"))
  (set vim.opt.statusline (sl.build-statusline ["%{g:metals_status}" " "]))
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
                          (lsp.set-buffer-opts client bufnr)
                          (metals.setup_dap)))

  (setup-debug-adapter-protocol)
  (metals.initialize_or_attach config))

(defn register-init-command []
  (vim.api.nvim_create_user_command :MetalsInit
                                    (lambda [opts] (initialize-metals))
                                    {:desc "Start and connect to a Metals server"}))
