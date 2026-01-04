(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(core.merge! vim.opt_local {:shiftwidth 2
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
        author (or vim.env.AUTHOR_NAME vim.env.USER)
        now (vim.fn.strftime "%FT%T%z" (vim.fn.localtime))
        headers {:title filename : author :created now :tags "[]"}
        template "---\ntitle: %s\nauthor: %s\ncreated: %s\ntags: []\n---\n"
        text (string.format template filename author now)]
    (vim.api.nvim_paste text false -1)))

(util.set-keys [[:n
                 :<localleader>m
                 insert-yaml-metadata
                 {:desc "[markdown] insert metadata as a YAML header"
                  :buffer true
                  :silent true}]
                [:n
                 :<localleader>v
                 render-markdown-to-html
                 {:desc "[markdown] convert to HTML and show preview in browser"
                  :buffer true
                  :silent true}]])
