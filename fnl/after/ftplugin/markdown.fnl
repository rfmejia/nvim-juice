(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :textwidth 100
                        :wrap true
                        :spell true
                        :spelllang :en_us})

(fn render-markdown-to-html [] ; TODO fix and verify this works
  (let [tmp-file (vim.fn.system [:mktemp :--suffix=.html])
        current-file (vim.fn.expand "%:p")]
    (vim.fn.system :$DOTFILES/pandoc/md-to-html current-file tmp-file
                   "&& ${BROWSER}" tmp-file)))

(fn insert-yaml-metadata []
  (let [filename (vim.fn.expand "%:t:r")
        now (vim.fn.strftime "%FT%T%z" (vim.fn.localtime))
        meta ["---" "title: " filename "created: " now "tags: []" "---"]]
    (vim.print meta) ; (vim.fn.append (line "0" meta)) ; call append(line('0'), meta)
    ))

(util.set-keys [[:n
                 :<localleader>m
                 (util.lua-cmd "require('juice.filetypes.markdown')['insert-yaml-metadata']()")
                 {:desc "insert metadata as a YAML header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>v
                 (util.lua-cmd "require('juice.filetypes.markdown')['render-markdown-to-html']()")
                 {:desc "convert to HTML and show preview in browser"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>d
                 ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n'<cr>"
                 {:desc "insert current date as an h2 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>t
                 ":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s ' | tr -d '\\n'<cr>A"
                 {:desc "insert current time as an h3 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]])
