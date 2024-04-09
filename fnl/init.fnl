(local {: autoload} (require :nfnl.module))
(local {: build-statusline} (autoload :juice.statusline))
(local {: auto-setup : executable? : set-opts} (autoload :juice.util))

(comment "---- LEADER KEYS ----")
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(comment "---- BEHAVIOR ----")
(set-opts {; use linux system clipboard
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
(set-opts {; show line numbers
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
           :statusline (build-statusline [])})

(comment "---- SEARCH OPTIONS ----")
(set-opts {; turn on highlight search
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
(vim.filetype.add {:extension {[:sbt :sc] :scala [:text :txt] :text}
                   :filename {:Jenkinsfile :groovy :tmux.conf :tmux}})

(comment "---- COMPLETION ----")
(set-opts {; remove imports, add spellchecker to completion sources
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

(comment "use ripgrep if available")
(when (executable? :rg)
  (set-opts {; use ripgrep as the grepprg
             :grepprg "rg --smart-case --hidden --follow --no-heading --vimgrep"
             :grepformat "%f:%l:%c:%m,%f:%l:%m"}))

(auto-setup :juice.plugins)
(auto-setup :juice.mappings)
(auto-setup :juice.autocmds)
