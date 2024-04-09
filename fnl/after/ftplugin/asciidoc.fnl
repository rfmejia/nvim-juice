(local {: autoload} (require :nfnl.module))
(local {: nmap} (autoload :juice.util))

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.textwidth 80)
(set vim.opt.wrap true)
(set vim.opt.spell true)
(set vim.opt.spelllang :en_us)
(nmap :<localleader>D
      ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k"
      [:noremap :silent])

(nmap :<localleader>t
      ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A"
      [:noremap :silent])
