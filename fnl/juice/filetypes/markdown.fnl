(module markdown
  {autoload {a aniseed.core
             u util}})

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.textwidth 80)
(set vim.opt.wrap true)
(set vim.opt.spell true)
(set vim.opt.spelllang "en_us")
(set vim.opt.signcolumn "no")

; TODO fix and verify this works
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
  (u.nmap "<localleader>m" (u.lua-cmd "require('juice.filetypes.markdown')['insert-yaml-metadata']()") [u.noremap u.silent])
  (u.nmap "<localleader>v" (u.lua-cmd "require('juice.filetypes.markdown')['render-markdown-to-html']()") [u.noremap u.silent])
  (u.nmap "<localleader>d" ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n\\n'<cr>O" [u.noremap u.silent])
  (u.nmap "<localleader>t" ":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s '<cr>kA " [u.noremap u.silent])
  (vim.api.nvim_del_user_command :LoadJournalTools))

(vim.api.nvim_create_user_command :LoadJournalTools load-journal-tools {:bang true})
