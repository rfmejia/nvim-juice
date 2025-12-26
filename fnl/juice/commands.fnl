(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(local commands
       {:ClipFilename ["let @+ = getreg('%')"
                       {:desc "copy current file path to clipboard"}]
        :LoadEnv [(fn []
                    (util.call :juice.dotenvrc :load-env)
                    (vim.notify "Loaded environment variables"))
                  {:desc "(Re)load environment variables"}]})

{:setup #(each [cmd-name args (pairs commands)]
           (vim.api.nvim_create_user_command cmd-name (unpack args)))}
