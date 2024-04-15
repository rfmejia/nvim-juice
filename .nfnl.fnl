(fn map-path [fnl-path]
  (let [core (require :nfnl.core)
        conf (require :nfnl.config)
        str (require :nfnl.string)
        default (conf.default)
        rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
    (if (= rel-fnl-path :fnl/init.fnl)
        (default.fnl-path->lua-path :init.lua)
        (= rel-fnl-path :fnl/bootstrap.fnl)
        (default.fnl-path->lua-path :bootstrap.lua)
        (string.match rel-fnl-path :fnl/after)
        (let [segments (str.split rel-fnl-path "/")
              path (core.butlast (core.rest segments))
              file (string.gsub (core.last segments) :.fnl :.lua)
              out (str.join "/" (core.concat path [file]))]
          (default.fnl-path->lua-path out))
        (default.fnl-path->lua-path (.. rel-fnl-path)))))

{:fnl-path->lua-path map-path}
