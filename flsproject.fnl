{:fennel-path "./fnl/?.fnl;./fnl/?/init.fnl;./fnl/juice/?.fnl;./fnl/after/ftplugin/?.fnl;./fnl/lsp/?.fnl"
 :lua-version :lua5.4
 :libraries {:nvim true}
 :extra-globals :unpack
 :lints {:unused-definition false
         :unknown-module-field true
         :unnecessary-method true
         :unnecessary-tset true
         :redundant-do true
         :match-should-case true
         :bad-unpack true
         :var-never-set true
         :op-with-no-arguments true
         :no-decreasing-comparison false}}
