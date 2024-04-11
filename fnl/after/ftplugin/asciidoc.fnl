(local {: autoload} (require :nfnl.module))
(local {: nmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2
           :tabstop 2
           :textwidth 80
           :wrap true
           :spell true
           :spelllang :en_us})

(nmap :<localleader>d
      ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k"
      [:noremap :silent :buffer])

(nmap :<localleader>t
      ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A"
      [:noremap :silent :buffer])
