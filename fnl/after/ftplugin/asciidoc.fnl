(local {: autoload} (require :nfnl.module))
(local {: executable? : set-opts} (autoload :juice.util))
(local util (autoload :juice.util))

(util.set-opts {:shiftwidth 2
                :tabstop 2
                :textwidth 80
                :wrap true
                :spell true
                :spelllang :en_us})

(util.set-keys [[:n
                 :<localleader>d
                 ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k"
                 {:desc "insert current date as an h2 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>t
                 ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A"
                 {:desc "insert current time as an h3 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]])

(lambda preview-in-browser [in out browser-cmd]
  (if (util.executable? :asciidoctor)
      (match (vim.fn.system [:asciidoctor :-o out in])
        ok (vim.fn.system [browser-cmd out])
        (nil err-msg) (error (.. "Could not run asciidoctor: " err-msg)))))

(when vim.env.BROWSER
  (let [in (vim.fn.expand "%:p")
        out :/tmp/preview.html]
    (vim.keymap.set :n :<localleader>p
                    #(preview-in-browser in out vim.env.BROWSER)
                    {:desc "convert to HTML and show preview in browser"
                     :buffer (vim.api.nvim_get_current_buf)})))
