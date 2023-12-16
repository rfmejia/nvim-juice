{1 "lewis6991/gitsigns.nvim"
 :event ["BufReadPre" "BufNewFile"]
 :config (fn []
           (let [gitsigns (require :gitsigns)]
             (gitsigns.setup))
           )}
