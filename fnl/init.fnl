(comment "---- LEADER KEYS ----")
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(comment "---- LEADER KEYS ----")
(require :juice.plugins)
(require :juice.mappings)

(comment "---- BEHAVIOR ----")
(comment "Allow switching off unwritten buffers")
(set vim.opt.hidden true)
(comment "Detect and read external file changes")
(set vim.opt.autoread true)
(comment "Indent new line")
(set vim.opt.autoindent true)
(comment "Indent new line in special cases")
(set vim.opt.smartindent true)
(comment "Number of spaces for *existing* tabs")
(set vim.opt.shiftwidth 2)
(comment "Number of spaces for *inserting* tabs")
(set vim.opt.tabstop 2)
(comment "Number of spaces for (auto)indenting, e.g. >> & <<")
(set vim.opt.softtabstop 2)
(comment "Convert tabs to spaces")
(set vim.opt.expandtab true)
(comment "-")
(set vim.opt.smarttab true)
(comment "Disable block folding")
(set vim.opt.foldenable false)
(comment "-")
(set vim.opt.backspace "indent,eol,start")
(comment "-")
(set vim.opt.history 10000)
(comment "-")
(set vim.opt.ttyfast true)
(comment "-")
(set vim.opt.ttimeoutlen 50)
(comment "Disable mouse")
(set vim.opt.mouse "")
(comment "-")
(set vim.opt.shortmess :filnxtToOF)

(comment "---- VISUAL ----")
(comment "Show line numbers")
(set vim.opt.number true)
(comment "Show numbers relative to current line")
(set vim.opt.relativenumber true)
(comment "Display line column")
(set vim.opt.signcolumn "yes:1")
(comment "Highlight cursor position row")
(set vim.opt.cursorline true)
(comment "Prefer adding horizontal split below")
(set vim.opt.splitbelow true)
(comment "Prefer adding a vertical split on the right")
(set vim.opt.splitright true)
(comment "Do not wrap text")
(set vim.opt.wrap false)
(comment "When wrapping is turned on, wrap on a line break")
(set vim.opt.linebreak true)
(comment "Show queued up command keystrokes")
(set vim.opt.showcmd true)
(comment "Show a single status line only")
(set vim.opt.laststatus 3)
(comment "Jump to the previously used window when jumping to errors with |quickfix| commands")
(set vim.opt.switchbuf :uselast)

(comment "---- SEARCH OPTIONS ----")
(comment "Turn on highlight search")
(set vim.opt.hlsearch true)
(comment "Search as the query is typed")
(set vim.opt.incsearch true)
(comment "Do not wrap search scans")
(set vim.opt.wrapscan false)
(comment "Ignore case when using lowercase in search")
(set vim.opt.ignorecase true)
(comment "But don't ignore it when using upper case")
(set vim.opt.smartcase true)

(comment "---- COMPLETION ----")
(comment "remove imports, add spellchecker to completion sources")
(set vim.opt.complete ".,w,b,u,t,kspell")
(comment "-")
(set vim.opt.completeopt "menu,menuone,noselect,noinsert")
(comment "search in current file's directory or pwd (do not use **)")
(set vim.opt.path ".,,")

(comment "---- FILETYPES ----")
(vim.cmd "filetype plugin on")
(vim.filetype.add {:extension {[:sbt :sc] :scala [:text :txt] :text}
                   :filename {:Jenkinsfile :groovy :tmux.conf :tmux}})

(let [u (require :juice.util)]
  (when (u.has? :syntax)
    (vim.cmd "syntax enable"))
  (when (u.has? :clipboard)
    (comment "Use Linux system clipboard")
    (set vim.opt.clipboard :unnamedplus))
  (when (u.has? :persistent_undo)
    (comment "Increase the number of undos")
    (set vim.opt.undolevels 5000)
    (comment "Persist undo logs per file inside `undodir`")
    (set vim.opt.undofile true))
  (when (u.has? :wildmenu)
    (comment "-")
    (set vim.opt.wildmenu true)
    (comment "Set order of completion matches")
    (set vim.opt.wildmode "lastused,longest,full")
    (comment "-")
    (set vim.opt.wildignore
         "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class")
    (comment "ignore case when filtering results")
    (set vim.opt.wildignorecase true)
    (comment "use popup to show results")
    (set vim.opt.wildoptions :pum))
  (comment "use ripgrep")
  (when (u.executable? :rg)
    (set vim.opt.grepprg
         "rg\\ --smart-case\\ --hidden\\ --follow\\ --no-heading\\ --vimgrep")
    (set vim.opt.grepformat "%f:%l:%c:%m,%f:%l:%m")))

(let [sl (require :juice.statusline)]
  (set vim.opt.statusline (sl.build-statusline [])))

(vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})

(comment "---- AUTOCMDS ----")
(let [augroup vim.api.nvim_create_augroup
      autocmd vim.api.nvim_create_autocmd]
  (comment "Remember the cursor position of the last editing")
  (autocmd :BufReadPost
           {:pattern "*" :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  (autocmd [:BufEnter :BufWritePost]
           {:pattern "*"
            :callback (fn []
                        (local sl (require :juice.statusline))
                        (sl.git-file-status)
                        (sl.git-branch))})
  (augroup :highlight-group [])
  (comment "highlight yanked text")
  (autocmd :TextYankPost
           {:group :highlight-group
            :pattern "*"
            :callback (fn []
                        (vim.highlight.on_yank {:timeout 200 :on_visual false}))})
  (comment "highlight TODO, FIXME and Note: keywords")
  (autocmd [:WinEnter :VimEnter]
           {:group :highlight-group
            :pattern "*"
            :command ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  (autocmd [:BufWinEnter :InsertLeave]
           {:group :highlight-group
            :pattern "*"
            :callback (fn []
                        (local c (require :juice.colors))
                        (c.show-extra-whitespace)
                        (vim.cmd "match ExtraWhitespace /\\s\\+$/"))})
  (autocmd [:BufWinLeave :InsertEnter]
           {:group :highlight-group
            :pattern "*"
            :command "hi clear ExtraWhitespace"})
  (augroup :terminal-group [])
  (comment "remove signcolumn in terminal mode")
  (autocmd :TermOpen {:group :terminal-group
                      :pattern "*"
                      :command "set signcolumn=no"}))
