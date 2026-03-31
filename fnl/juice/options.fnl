(local {: autoload} (require :nfnl.module))
(local statusline (autoload :juice.statusline))
(local util (autoload :juice.util))
(local core (autoload :nfnl.core))

(comment "---- GENERAL OPTIONS ----")
(local map-leaders {:mapleader " " :maplocalleader ","})

(local behavior {; use linux system clipboard
                 :clipboard :unnamedplus
                 ; indent new line in special cases
                 :smartindent true
                 ; number of spaces for *existing* tabs
                 :shiftwidth 2
                 ; number of spaces for *inserting* tabs
                 :tabstop 2
                 ; number of spaces for (auto)indenting, e.g. >> & <<
                 :softtabstop 2
                 ; convert tabs to spaces
                 :expandtab true
                 ; disable block folding
                 :foldenable false
                 ; disable mouse
                 :mouse ""
                 ; customize messages
                 :shortmess :filnxtToOF
                 ; increase the number of undos
                 :undolevels 5000
                 ; persist undo logs per file inside `undodir`
                 :undofile true
                 :virtualedit :block})

(local visual {; show line numbers
               :number false
               ; show numbers relative to current line
               :relativenumber false
               ; hide line column
               :signcolumn :no
               ; highlight cursor position row
               :cursorline true
               ; prefer adding horizontal split below
               :splitbelow true
               ; prefer adding a vertical split on the right
               :splitright true
               ; do not wrap text
               :wrap false
               ; when wrapping is turned on, wrap on a line break
               :linebreak true
               ; show single status line only
               :laststatus 3
               :statusline (statusline.build [])})

(comment "---- SEARCH OPTIONS ----")
(local search {; turn on highlight search
               :hlsearch true
               ; search as the query is typed
               :incsearch true
               ; do not wrap search scans
               :wrapscan false
               ; ignore case when using lowercase in search
               :ignorecase true
               ; but don't ignore it when using upper case
               :smartcase true})

(comment "---- COMPLETION ----")
(local completion {; remove imports, add spellchecker to completion sources
                   :complete ["." :w :b :u :t :kspell]
                   :completeopt [:menuone :popup :fuzzy :noselect :preview]
                   ; search in current file's directory or pwd (do not use ** edit: experimenting)
                   :path ["." "" "**"]
                   ; Set order of completion matches
                   :wildmode [:lastused :full]
                   ; ignore case when filtering results
                   :wildignorecase true
                   ; use popup to show results
                   :wildoptions [:fuzzy :pum]
                   :pumborder :rounded})

(comment "use ripgrep as grepprg if available")
(local grep-options
       (if (util.executable? :rg)
           {:grepprg "rg --smart-case --hidden --follow --no-heading --vimgrep"
            :grepformat "%f:%l:%c:%m,%f:%l:%m"}))

{:setup (fn []
          (core.merge! vim.g map-leaders)
          (core.merge! vim.opt behavior visual search completion grep-options))}
