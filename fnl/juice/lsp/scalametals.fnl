(local {: autoload} (require :nfnl.module))
(local {: bufmap} (autoload :juice.util))

(local {: build-statusline} (autoload :juice.statusline))

(fn initialize-metals []
  (let [juice-lsp (autoload :juice.lsp)
        metals (autoload :metals)
        config (metals.bare_config)
        telescope (autoload :telescope)]
    (set vim.opt.signcolumn "yes:1")
    (set vim.go.shortmess (.. vim.go.shortmess :c))
    (set vim.opt.statusline (build-statusline ["%{g:metals_status}" " ●"]))
    (tset vim.g :metals_status "Initializing Metals...")
    (set config.settings {:showImplicitArguments true
                          :showImplicitConversionsAndClasses true
                          :showInferredType true
                          ; :serverVersion :1.2.2
                          })
    (set config.init_options.statusBarProvider :on)
    (set config.capabilities (vim.lsp.protocol.make_client_capabilities))
    (tset config :tvp {:panel_alignment :right
                       :toggle_node_mapping :<CR>
                       :node_command_mapping :r})
    (set config.handlers juice-lsp.handlers)
    (set config.on_attach
         (lambda [client bufnr]
           (let [tvp (autoload :metals.tvp)
                 metals-maps {:v {:K [metals.type_of_range
                                      [:noremap :silent]
                                      "show type of visual selection"]}
                              :n {:<localleader>mw [#(metals.hover_worksheet {:border :rounded})
                                                    [:noremap :silent]
                                                    "show (m)etals (w)orksheet output in popup"]
                                  :<localleader>mc [telescope.extensions.metals.commands
                                                    [:noremap :silent]
                                                    "list (m)etals (c)commands"]
                                  :<localleader>mt [tvp.toggle_tree_view
                                                    [:noremap :silent]
                                                    "(m)etals (t)oggle tree view"]
                                  :<localleader>mr [tvp.reveal_in_tree
                                                    [:noremap :silent]
                                                    "(m)etals (r)eveal current member in tree view"]}}]
             (juice-lsp.set-buffer-opts client bufnr)
             (bufmap bufnr metals-maps))))
    (comment "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)")
    (vim.api.nvim_create_augroup :metals-group [])
    (vim.api.nvim_create_autocmd :FileType
                                 {:group :metals-group
                                  :pattern [:scala :sbt :java]
                                  :callback #(metals.initialize_or_attach config)})
    (comment "Initialize Metals for the first time")
    (metals.initialize_or_attach config)))

(fn register-init-command []
  (vim.api.nvim_create_user_command :MetalsInit #(initialize-metals)
                                    {:desc "Start and connect to a Metals server"}))

{: register-init-command}
