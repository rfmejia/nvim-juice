(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :textwidth 100
                        :wrap true
                        :spell true
                        :spelllang :en_us})

(fn render-markdown-to-html []
  (let [current-file (vim.fn.expand "%:p")
        tmp-file (vim.fn.system [:mktemp :--suffix=.html])
        pandoc-cmd [:pandoc
                    :--standalone
                    :--embed-resource
                    :-c
                    "~/.pandoc/github-markdown.css"
                    :-f
                    :gfm
                    :-t
                    :html
                    current-file
                    :-o
                    tmp-file]
        browser-cmd [vim.env.BROWSER tmp-file]]
    (and (vim.fn.system pandoc-cmd) (vim.fn.system browser-cmd))))

(fn insert-yaml-metadata []
  (let [filename (vim.fn.expand "%:t:r")
        now (vim.fn.strftime "%FT%T%z" (vim.fn.localtime))]
    (util.insert-lines "---" (.. "title: " filename) (.. "created: " now)
                       "tags: []" "---" "")))

(util.set-keys [[:n
                 :<localleader>m
                 insert-yaml-metadata
                 {:desc "[markdown] insert metadata as a YAML header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>v
                 render-markdown-to-html
                 {:desc "[markdown] convert to HTML and show preview in browser"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]])
