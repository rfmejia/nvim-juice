(module markdown
  {autoload {a aniseed.core
             u util}
   import-macros [[ac :aniseed.macros.autocmds]]})

(local nmap u.nmap)
(local noremap u.noremap)
(local silent u.silent)

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.textwidth 80)
(set vim.opt.wrap true)
(set vim.opt.spell true)
(set vim.opt.spelllang "en_us")
(set vim.opt.signcolumn "no")

(defn render-markdown-to-html []
  (let [tmp-file (vim.fn.system ["mktemp" "--suffix=.html"])
        current-file (vim.fn.expand "%:p")]
    (vim.fn.system "$DOTFILES/pandoc/md-to-html" current-file tmp-file "&& ${BROWSER}" tmp-file)
    ))

(defn insert-yaml-metadata []
  (let [filename (vim.fn.expand "%:t:r")
        now (vim.fn.strftime "%FT%T%z" (vim.fn.localtime))
        meta ["---" "title: " filename "created: "  now "tags: []" "---"]]
    (print meta)
    ; (vim.fn.append (line "0" meta))
    ; call append(line('0'), meta)
    ))

(defn load-journal-tools []
  (nmap "<localleader>m" (u.lua-cmd "require('juice.filetypes.markdown')['insert-yaml-metadata']()") [noremap silent])
  (nmap "<localleader>v" (u.lua-cmd "require('juice.filetypes.markdown')['render-markdown-to-html']()") [noremap silent])
  (nmap "<localleader>d" ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n\\n'<cr>O" [noremap silent])
  (vim.api.nvim_del_user_command :LoadJournalTools)
  (a.println "Loaded journal tools")
  )

; (vim.api.nvim_create_user_command :LoadJournalTools "lua require('juice.filetypes.markdown')['load-journal-tools']()" {})
(vim.api.nvim_create_user_command :LoadJournalTools load-journal-tools {:bang true})
