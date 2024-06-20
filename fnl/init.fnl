; check and install `nfnl` and `lazy.nvim`
((-> (require :juice.bootstrap)
     (. :setup)))

(local {: autoload} (require :nfnl.module))
(local statusline (autoload :juice.statusline))
(local util (autoload :juice.util))

(comment "---- LEADER KEYS ----")
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(comment "---- BEHAVIOR ----")
(util.set-opts {; use linux system clipboard
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
                :undofile true})

(comment "---- VISUAL ----")
(util.set-opts {; show line numbers
                :number true
                ; show numbers relative to current line
                :relativenumber true
                ; display line column
                :signcolumn "yes:1"
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
(util.set-opts {; turn on highlight search
                :hlsearch true
                ; search as the query is typed
                :incsearch true
                ; do not wrap search scans
                :wrapscan false
                ; ignore case when using lowercase in search
                :ignorecase true
                ; but don't ignore it when using upper case
                :smartcase true})

(comment "---- FILETYPES ----")
(vim.filetype.add {:extension {:edn :clojure :sbt :scala :sc :scala :txt :text}
                   :filename {:Jenkinsfile :groovy :tmux.conf :tmux}})

(comment "---- COMPLETION ----")
(util.set-opts {; remove imports, add spellchecker to completion sources
                :complete ".,w,b,u,t,kspell"
                :completeopt "menu,menuone,noselect,noinsert"
                ; search in current file's directory or pwd (do not use **)
                :path ".,,"
                ; Set order of completion matches
                :wildmode "lastused,longest,full"
                ; ignore these files when searching
                :wildignore "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class"
                ; ignore case when filtering results
                :wildignorecase true
                ; use popup to show results
                :wildoptions :pum})

(comment "use ripgrep as grepprg if available")
(when (util.executable? :rg)
  (util.set-opts {:grepprg "rg --smart-case --hidden --follow --no-heading --vimgrep"
                  :grepformat "%f:%l:%c:%m,%f:%l:%m"}))

(comment "---- AUTOCMDS ----")
(comment "Remember the cursor position of the last editing")
(vim.api.nvim_create_autocmd :BufReadPost
                             {:pattern "*"
                              :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})

(vim.api.nvim_create_augroup :highlight-group [])
(comment "highlight yanked text")
(vim.api.nvim_create_autocmd :TextYankPost
                             {:group :highlight-group
                              :pattern "*"
                              :callback #(vim.highlight.on_yank {:timeout 200
                                                                 :on_visual false})})

(comment "highlight TODO, FIXME and Note: keywords")
(vim.api.nvim_create_autocmd [:WinEnter :VimEnter]
                             {:group :highlight-group
                              :pattern "*"
                              :command ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})

(vim.api.nvim_create_augroup :terminal-group [])
(comment "remove signcolumn in terminal mode")
(vim.api.nvim_create_autocmd :TermOpen
                             {:group :terminal-group
                              :pattern "*"
                              :command "set signcolumn=no"})

(util.auto-setup :juice.plugins)
(util.auto-setup :juice.mappings)
(util.auto-setup :juice.git)
(util.auto-setup :juice.tmux-nav)
(util.auto-setup :juice.whitespace)
