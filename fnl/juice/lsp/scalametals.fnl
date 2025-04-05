(local {: autoload} (require :nfnl.module))
(local statusline (autoload :juice.statusline))
(local util (autoload :juice.util))

(fn initialize-metals []
  (let [juice-lsp (autoload :juice.lsp)
        metals (autoload :metals)
        config (metals.bare_config)
        tvp (autoload :metals.tvp)
        options {:signcolumn "yes:1"
                 :shortmess (.. vim.go.shortmess :c)
                 :statusline (statusline.build ["%{g:metals_status}" " ●"])}
        metals-settings {:inlayHints {:hintsInPatternMatch {:enable true}
                                      :implicitArguments {:enable true}
                                      :implicitConversions {:enable true}
                                      :inferredTypes {:enable true}
                                      :typeParameters {:enable true}}}
        metals-maps (lambda [bufnr]
                      [[:v
                        :K
                        metals.type_of_range
                        {:desc "[metals] show type of visual selection"
                         :buffer bufnr}]
                       [:n
                        :<localleader>mw
                        #(metals.hover_worksheet {:border :rounded})
                        {:desc "[metals] show (m)etals (w)orksheet output in popup"
                         :buffer bufnr}]
                       [:n
                        :<localleader>mt
                        tvp.toggle_tree_view
                        {:desc "[metals] (m)etals (t)oggle tree view"
                         :buffer bufnr}]
                       [:n
                        :<localleader>mr
                        tvp.reveal_in_tree
                        {:desc "[metals] (m)etals (r)eveal current member in tree view"
                         :buffer bufnr}]])]
    (set config.settings metals-settings)
    (set config.init_options.statusBarProvider :on)
    (set config.capabilities (vim.lsp.protocol.make_client_capabilities))
    (tset config :tvp {:panel_alignment :right
                       :toggle_node_mapping :<CR>
                       :node_command_mapping :r})
    ;; (set config.handlers juice-lsp.handlers)
    (set config.on_attach
         (lambda [client bufnr]
           (juice-lsp.set-buffer-opts client bufnr)
           (util.set-keys (metals-maps bufnr))
           (util.assoc-in vim.opt_local options)))
    (comment "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)")
    (vim.api.nvim_create_autocmd :FileType
                                 {:pattern [:scala :java]
                                  :callback #(metals.initialize_or_attach config)
                                  :group (vim.api.nvim_create_augroup :metals-group
                                                                      {:clear true})})
    (vim.api.nvim_create_user_command :MetalsInit
                                      #(metals.initialize_or_attach config)
                                      {:desc "Re-attach to a Metals server"})
    (comment "Initialize Metals for the first time")
    (tset vim.g :metals_status "Initializing Metals...")
    (metals.initialize_or_attach config)))

{: initialize-metals}
