(comment (let [id 1
               group :marksman]
           (vim.fn.sign_getdefined)
           (vim.fn.sign_getplaced)
           (vim.fn.sign_define :test {:text ">" :texthl :WarningMsg})
           (vim.fn.sign_place 1 "" :test 0 {:lnum 2})
           (vim.fn.sign_unplace "" {:id 1})))

(local set-opfunc
       (let [viml-fn (mkstring "\n" "func s:set_opfunc(val)"
                               "let &opfunc = a:val" :endfunc
                               "echon get(function('s:set_opfunc'), 'name')")]
         (vim.fn (vim.api.nvim_exec2 viml-fn true))))

;; local set_opfunc = vim.fn[vim.api.nvim_exec([[
;;   func s:set_opfunc(val)
;;     let &opfunc = a:val
;;   endfunc
;;   echon get(function('s:set_opfunc'), 'name')
;; ]], true)]

{: set-opfunc}
