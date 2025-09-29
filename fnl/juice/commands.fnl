{:setup #(vim.api.nvim_create_user_command :ClipFilename "let @+ = getreg('%')"
                                           {:desc "copy current file path to clipboard"})}
