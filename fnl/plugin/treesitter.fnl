(local {: autoload} (require :nfnl.module))
(local nvim-treesitter (autoload :nvim-treesitter))

(vim.pack.add ["https://github.com/nvim-treesitter/nvim-treesitter"])

(local ts-languages [:clojure :fennel :java :json :lua :markdown :scala :yaml])

(fn setup []
  ;; `install` is a no-op for languages already installed
  (nvim-treesitter.install ts-languages)
  (vim.treesitter.start)
  ;; Indentation support (experimental)
  (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()"))

(fn on-update [ev]
  (when (and (= ev.data.spec.name :nvim-treesitter)
             (= ev.data.spec.kind :update))
    (vim.cmd :TSUpdate)))

(vim.api.nvim_create_autocmd :FileType {:pattern ts-languages :callback setup})
(vim.api.nvim_create_autocmd :PackChanged {:callback on-update})
