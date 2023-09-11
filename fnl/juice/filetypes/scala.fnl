(module scala
  {autoload {a aniseed.core
             s aniseed.string
             u util}} )

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.expandtab true)
(set vim.opt.textwidth 100)

(defn run-scalafmt [path]
  (let [filename (if (s.blank? path) (vim.fn.expand "%:p")
                   path)]
    ;; FIXME How do we update the file in-place? Or should we just run ".!"?
    (vim.fn.system ["scalafmt" "--config" ".scalafmt.conf" filename]))
  )

(vim.api.nvim_create_user_command :ScalafmtApply run-scalafmt {:bang true})

; (u.nmap "<localleader>cf" (u.lua-cmd "require('juice.filetypes.scala')['run-scalafmt']") [u.noremap u.silent])
(vim.api.nvim_set_keymap "n" "<localleader>cf" "" {:callback (fn [] 
                                                               (->> (vim.fn.expand "%:p")
                                                                    (run-scalafmt)))})

(vim.api.nvim_set_keymap "n" "<localleader>cs" ":'<,'>sort<cr>" {})
