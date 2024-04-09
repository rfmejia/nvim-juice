(local {: autoload} (require :nfnl.module))
(local {: lua-cmd : nmap} (autoload :juice.util))

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.textwidth 80)
(set vim.opt.wrap true)
(set vim.opt.spell true)
(set vim.opt.spelllang :en_us)

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

(nmap :<localleader>m
      (lua-cmd "require('juice.filetypes.markdown')['insert-yaml-metadata']()")
      [:noremap :silent])

(nmap :<localleader>v
      (lua-cmd "require('juice.filetypes.markdown')['render-markdown-to-html']()")
      [:noremap :silent])

(nmap :<localleader>d
      ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n'<cr>"
      [:noremap :silent])

(nmap :<localleader>t
      ":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s ' | tr -d '\\n'<cr>A"
      [:noremap :silent])
