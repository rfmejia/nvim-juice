(local {: autoload} (require :nfnl.module))
(local {: nmap} (autoload :juice.util))

(nmap :<localleader>du ":DBUIToggle<cr>" [:noremap :buffer])
(nmap "<localleader>d;" ":DB g:db " [:noremap :buffer])
(nmap :<localleader>dd ":.DB g:db<cr>" [:noremap :buffer])
(nmap :<localleader>db ":%DB g:db<cr>" [:noremap :buffer])
(nmap :<localleader>dp "vip:DB g:db<cr>" [:noremap :buffer])
