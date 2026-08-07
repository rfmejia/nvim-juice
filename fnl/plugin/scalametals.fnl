(vim.pack.add ["https://github.com/scalameta/nvim-metals"])

(fn configure-metals []
  "Configure metals for the first time"
  (let [{: autoload} (require :nfnl.module)
        core (autoload :nfnl.core)
        statusline (autoload :juice.statusline)
        util (autoload :juice.util)
        metals (autoload :metals)
        tvp (autoload :metals.tvp)
        options {:signcolumn "yes:1"
                 :shortmess (.. vim.go.shortmess :c)
                 :statusline (statusline.build ["%{g:metals_status}" " ●"])}
        metals-settings {:disabledMode true
                         :defaultBspToBuildTool true
                         :enableBestEffort true
                         :enableSemanticHighlighting true
                         :enableStripMarginOnTypeFormatting true
                         :inlayHints {:byNameParameters {:enable true}
                                      :hintsInPatternMatch {:enable true}
                                      :implicitArguments {:enable true}
                                      :implicitConversions {:enable true}
                                      :inferredTypes {:enable true}
                                      :typeParameters {:enable true}}
                         :serverProperties [:-Xmx4g]
                         :showImplicitArguments true
                         :showImplicitConversionsAndClasses true
                         :showInferredType true
                         :shutdownBloopOnEditorClose true
                         :startMcpServer true}
        metals-buf-maps (lambda [bufnr]
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
                             :buffer bufnr}]])
        tvp-settings {:panel_alignment :right
                      :toggle_node_mapping :<CR>
                      :node_command_mapping :r}
        config (metals.bare_config)]
    (set config.settings metals-settings)
    (set config.init_options.statusBarProvider :on)
    (set config.capabilities (vim.lsp.protocol.make_client_capabilities))
    (set config.tvp tvp-settings)
    (set config.on_attach
         (lambda [client bufnr]
           (util.set-keys (metals-buf-maps bufnr))
           (core.merge! vim.opt_local options)))
    (comment "Initialize Metals for the first time")
    (set vim.g.metals_status "Initializing Metals...")
    (metals.initialize_or_attach config)
    (comment "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)")
    (vim.api.nvim_del_augroup_by_name :metals-group)
    (vim.api.nvim_create_autocmd :FileType
                                 {:pattern [:scala :java]
                                  :callback #(metals.initialize_or_attach config)
                                  :group (vim.api.nvim_create_augroup :metals-group
                                                                      {:clear true})})))

(vim.api.nvim_create_autocmd :FileType
                             {:pattern [:scala :java]
                              :callback configure-metals
                              :group (vim.api.nvim_create_augroup :metals-group
                                                                  {:clear true})})
