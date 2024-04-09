(local {: autoload} (require :nfnl.module))
(local {: autocmd : augroup : nmap : user-command : vmap} (autoload :juice.util))
(local {: build-statusline} (autoload :juice.statusline))

(fn initialize-metals []
  (let [lsp (autoload :juice.lsp)
        metals (autoload :metals)
        config (metals.bare_config)
        telescope (autoload :telescope)]
    (set vim.opt.signcolumn "yes:1")
    (set vim.go.shortmess (.. vim.go.shortmess :c))
    (set vim.opt.statusline (build-statusline ["%{g:metals_status}"]))
    (tset vim.g :metals_status "Initializing Metals...")
    (set config.settings
         {:showImplicitArguments true
          :showImplicitConversionsAndClasses true
          :showInferredType true
          :decorationColor :Conceal
          :serverVersion :latest.snapshot
          :scalafixRulesDependencies ["com.nequissimus::sort-imports:0.6.1"]})
    (set config.init_options.statusBarProvider :on)
    (set config.capabilities (vim.lsp.protocol.make_client_capabilities))
    (tset config :tvp {:panel_alignment :right
                       :toggle_node_mapping :<CR>
                       :node_command_mapping :r})
    (set config.on_attach
         (fn [client bufnr]
           (lsp.set-buffer-opts client bufnr)
           (set vim.opt.omnifunc "v:lua.vim.lsp.omnifunc")
           (vmap :K (fn [] (metals.type_of_range)) [:noremap :silent])
           (nmap :<localleader>mw
                 (fn [] (metals.hover_worksheet {:border :rounded}))
                 [:noremap :silent])
           (nmap :<localleader>mm
                 (fn [] (telescope.extensions.metals.commands))
                 [:noremap :silent])
           (nmap :<localleader>mt (. (autoload :metals.tvp) :toggle_tree_view)
                 [:noremap :silent])
           (nmap :<localleader>mr (. (autoload :metals.tvp) :reveal_in_tree)
                 [:noremap :silent])))
    (comment "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)")
    (augroup :metals-group [])
    (autocmd :FileType
             {:group :metals-group
              :pattern [:scala :sbt :java]
              :callback (fn [] (metals.initialize_or_attach config))})
    (comment "Initialize Metals for the first time")
    (metals.initialize_or_attach config)))

(fn register-init-command []
  (user-command :MetalsInit (fn [] (initialize-metals))
                {:desc "Start and connect to a Metals server"}))

{: register-init-command}
