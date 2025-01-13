; Output is listed in a scratch buffer

; :Gh issue list

(let [callback (fn [output] (vim.print "output" output))
      raw (vim.system [:gh :issue :list :--json "number,title,body"] callback)]
  (vim.print "raw" raw))

;; (vim.api.nvim_echo [["test 1\ntest 2\ntest 3\n"]] false {})
