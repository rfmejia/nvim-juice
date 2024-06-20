(local {: autoload} (require :nfnl.module))
(local statusline (autoload :juice.statusline))
(local util (autoload :juice.util))

(fn initialize-metals []
  (let [juice-lsp (autoload :juice.lsp)
        metals (autoload :metals)
        config (metals.bare_config)
        telescope (autoload :telescope)
        tvp (autoload :metals.tvp)
        options {:signcolumn "yes:1"
                 :shortmess (.. vim.go.shortmess :c)
                 :statusline (statusline.build ["%{g:metals_status}" " ●"])}
        metals-settings {:showImplicitArguments true
                         :showImplicitConversionsAndClasses true
                         :showInferredType true}
        metals-maps (lambda [bufnr]
                      [[:v
                        :K
                        metals.type_of_range
                        {:desc "show type of visual selection" :buffer bufnr}]
                       [:n
                        :<localleader>mw
                        #(metals.hover_worksheet {:border :rounded})
                        {:desc "show (m)etals (w)orksheet output in popup"
                         :buffer bufnr}]
                       [:n
                        :<localleader>mc
                        telescope.extensions.metals.commands
                        {:desc "list (m)etals (c)commands" :buffer bufnr}]
                       [:n
                        :<localleader>mt
                        tvp.toggle_tree_view
                        {:desc "(m)etals (t)oggle tree view" :buffer bufnr}]
                       [:n
                        :<localleader>mr
                        tvp.reveal_in_tree
                        {:desc "(m)etals (r)eveal current member in tree view"
                         :buffer bufnr}]])]
    (util.set-opts options)
    (comment "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)")
    (vim.api.nvim_create_augroup :metals-group [])
    (vim.api.nvim_create_autocmd :FileType
                                 {:group :metals-group
                                  :pattern [:scala :sbt :java]
                                  :callback #(metals.initialize_or_attach config)})
    (set config.settings metals-settings)
    (set config.init_options.statusBarProvider :on)
    (set config.capabilities (vim.lsp.protocol.make_client_capabilities))
    (tset config :tvp {:panel_alignment :right
                       :toggle_node_mapping :<CR>
                       :node_command_mapping :r})
    (set config.handlers juice-lsp.handlers)
    (set config.on_attach
         (lambda [client bufnr]
           (juice-lsp.set-buffer-opts client bufnr)
           (util.set-keys (metals-maps bufnr))))
    (comment "Initialize Metals for the first time")
    (tset vim.g :metals_status "Initializing Metals...")
    (metals.initialize_or_attach config)))

(fn register-init-command []
  (vim.api.nvim_create_user_command :MetalsInit #(initialize-metals)
                                    {:desc "Start and connect to a Metals server"}))

{: register-init-command}
