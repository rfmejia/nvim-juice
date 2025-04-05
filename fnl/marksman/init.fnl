(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(comment (let [id 1
               group :marksman]
           (vim.fn.sign_getdefined)
           (vim.fn.sign_getplaced)
           (vim.fn.sign_define :test {:text ">" :texthl :WarningMsg})
           (vim.fn.sign_place 1 "" :test 0 {:lnum 2})
           (vim.fn.sign_unplace "" {:id 1})))

(local set-opfunc
       (let [viml-fn (.. "\n" "func s:set_opfunc(val)" "let &opfunc = a:val"
                         :endfunc "echon get(function('s:set_opfunc'), 'name')")]
         (vim.fn (vim.api.nvim_exec2 viml-fn true))))

(fn toggle-mark [marker line-num]
  "Sets or removes `marker` on the sign column at a given line number"
  "'Route' by:"
  "  1. If marker exists and is on the same location, delete marker+sign"
  "  2. If marker exists and is on a new location, delete marker+sign and recur to add"
  "  3. If marker does not exist, add marker+sign")

(lambda init-store []
  (set (. vim.g :marksman-marks) {})
  (set (. vim.g :marksman-opts) {}))

(lambda get-mark [mark]
  (?. vim.g.marksman :marks mark))

(lambda set-mark [mark lnum buf?]
  "Add new or update existing mark at the specified line number and (optional) buffer")

(lambda del-mark [mark]
  "Delete a mark")

(fn sync-vimmarks []
  "Convert marks in vim into plugin marks"
  (let [vimmarks (vim.fn.getmarklist)] ;; filter a-zA-Z
    (vim.print vimmarks)))

(fn define-signs []
  (vim.fn.sign_define [{:name :marksman-a :text :a :texthl :Comment}
                       {:name :marksman-b :text :b :texthl :Comment}
                       {:name :marksman-c :text :c :texthl :Comment}
                       {:name :marksman-d :text :d :texthl :Comment}
                       {:name :marksman-e :text :e :texthl :Comment}
                       {:name :marksman-f :text :f :texthl :Comment}
                       {:name :marksman-g :text :g :texthl :Comment}
                       {:name :marksman-h :text :h :texthl :Comment}
                       {:name :marksman-i :text :i :texthl :Comment}
                       {:name :marksman-j :text :j :texthl :Comment}
                       {:name :marksman-k :text :k :texthl :Comment}
                       {:name :marksman-l :text :l :texthl :Comment}
                       {:name :marksman-m :text :m :texthl :Comment}
                       {:name :marksman-n :text :n :texthl :Comment}
                       {:name :marksman-o :text :o :texthl :Comment}
                       {:name :marksman-p :text :p :texthl :Comment}
                       {:name :marksman-q :text :q :texthl :Comment}
                       {:name :marksman-r :text :r :texthl :Comment}
                       {:name :marksman-s :text :s :texthl :Comment}
                       {:name :marksman-t :text :t :texthl :Comment}
                       {:name :marksman-u :text :u :texthl :Comment}
                       {:name :marksman-v :text :v :texthl :Comment}
                       {:name :marksman-w :text :w :texthl :Comment}
                       {:name :marksman-x :text :x :texthl :Comment}
                       {:name :marksman-y :text :y :texthl :Comment}
                       {:name :marksman-z :text :z :texthl :Comment}]))

(comment (vim.fn.sign_getplaced 0)
  (vim.fn.sign_place 1 :marksman :marksman-a 4 {:lnum 21})
  (vim.fn.sign_unplace :marksman {:buffer 4 :id 1})
  (vim.fn.sign_unplace "*"))

;; local set_opfunc = vim.fn[vim.api.nvim_exec([[
;;   func s:set_opfunc(val)
;;     let &opfunc = a:val
;;   endfunc
;;   echon get(function('s:set_opfunc'), 'name')
;; ]], true)]

(fn setup []
  (set (. vim.g :marksman-marks :a) {:sign-id 1 :buf-num 1})
  (print vim.g.marksman.marks.a)
  (init-store)
  (?. vim.g :marksman-marks :a))

(fn test []
  (core.assoc-in vim.g [:marksman] {:marks {}})
  (table.insert vim.g.marksman.marks.a :test)
  (core.nil? (?. vim.g :marksman))
  (core.nil? (?. vim.g :marksman :marks))
  (core.nil? (?. vim.g :marksman :marks :a))
  (core.assoc-in vim.g [:marksman :marks :a] {:sign-id 1 :buf-num 1}))

{: set-opfunc}
