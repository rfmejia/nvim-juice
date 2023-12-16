{1 "projekt0n/github-nvim-theme"
 :lazy false
 :priority 1000
 :config (fn []
           (let [theme (require "github-theme")
                 dark-palette {:github_dark_high_contrast {:bg0 "#0000FF"
                                                           :bg1 "#0000FF"
                                                           :bg2 "#0000FF"
                                                           :bg3 "#0000FF"
                                                           :bg4 "#0000FF"
                                                           }}]
             (theme.setup {:palettes dark-palette})
             (vim.cmd "colorscheme github_dark_high_contrast")))}
