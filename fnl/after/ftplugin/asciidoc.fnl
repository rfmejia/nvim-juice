(local {: autoload} (require :nfnl.module))
(local {: println} (autoload :nfnl.core))
(local {: executable? : bufmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2
           :tabstop 2
           :textwidth 80
           :wrap true
           :spell true
           :spelllang :en_us})

(bufmap (vim.api.nvim_get_current_buf)
        {:n {:<localleader>d [":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k"
                              [:noremap :silent]
                              "insert current date as an h2 header"]
             :<localleader>t [":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A"
                              [:noremap :silent]
                              "insert current time as an h3 header"]}})

(lambda preview-in-browser [in out browser-cmd]
  (if (executable? :asciidoctor)
      (match (vim.fn.system [:asciidoctor :-o out in])
        ok (vim.fn.system [browser-cmd out])
        (nil err-msg) (error (.. "Could not run asciidoctor: " err-msg)))))

(when vim.env.BROWSER
  (let [in (vim.fn.expand "%:p")
        out :/tmp/preview.html]
    (bufmap (vim.api.nvim_get_current_buf)
            {:n {:<localleader>p [(fn []
                                    (preview-in-browser in out vim.env.BROWSER))
                                  [:noremap :silent]
                                  "convert to HTML and show preview in browser"]}})))
