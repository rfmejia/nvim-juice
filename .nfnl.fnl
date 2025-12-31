(fn map-path [fnl-path]
  (let [core (require :nfnl.core)
        conf (require :nfnl.config)
        str (require :nfnl.string)
        default (conf.default)
        rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
    (if (= rel-fnl-path :fnl/init.fnl)
        (default.fnl-path->lua-path :init.lua)
        (or (string.match rel-fnl-path :fnl/after)
            (string.match rel-fnl-path :fnl/lsp)
            (string.match rel-fnl-path :fnl/pack)
            (string.match rel-fnl-path :fnl/plugin))
        (let [segments (str.split rel-fnl-path "/")
              path (core.butlast (core.rest segments))
              file (string.gsub (core.last segments) :.fnl :.lua)
              out (str.join "/" (core.concat path [file]))]
          (default.fnl-path->lua-path out))
        :else
        (default.fnl-path->lua-path rel-fnl-path))))

{:fnl-path->lua-path map-path}
