(local core (require :nfnl.core))
(local conf (require :nfnl.config))
(local str (require :nfnl.string))
(local default (conf.default))

(fn map-path [fnl-path]
  (let [rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
    (if (= rel-fnl-path :fnl/init.fnl)
        (default.fnl-path->lua-path :init.lua)

        ; Special case for top-level nvim directories
        (string.match rel-fnl-path :fnl/after)
        (let [segments (str.split rel-fnl-path "/")
              path (core.butlast (core.rest segments))
              file (string.gsub (core.last segments) :.fnl :.lua)
              out (str.join "/" (core.concat path [file]))]
          (default.fnl-path->lua-path out))

        ; Output all others in lua/ directory
        (default.fnl-path->lua-path (.. rel-fnl-path)))))

{:fnl-path->lua-path map-path}
