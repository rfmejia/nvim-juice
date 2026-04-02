(local commands
       {:ClipFilename ["let @+ = getreg('%')"
                       {:desc "copy current file path to clipboard"}]
        :LoadEnv [#(let [{: autoload} (require :nfnl.module)
                         util (autoload :juice.util)]
                     (util.call :juice.dotenvrc :load-env)
                     (vim.notify "Loaded environment variables"))
                  {:desc "(Re)load environment variables"}]
        :PackUpdate [#(vim.pack.update) {:desc "Update remote vim packages"}]})

{:setup #(each [cmd-name args (pairs commands)]
           (vim.api.nvim_create_user_command cmd-name (unpack args)))}
