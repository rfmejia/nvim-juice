(module startup
  {autoload {sl juice.statusline
             u util}
   import-macros [[ac :aniseed.macros.autocmds]]})

; -----------------------------------------------------------------------------
; GENERAL OPTIONS
(when (u.has? "syntax")
  (vim.cmd "syntax enable"))

; behavior
(set vim.opt.hidden true)                     ; Allow switching off unwritten buffers
(set vim.opt.autoread true)                   ; Detect and read external file changes
(set vim.opt.autoindent true)                 ; Indent new line
(set vim.opt.smartindent true)                ; Indent new line in special cases
(set vim.opt.shiftwidth 2)                    ; Number of spaces for *existing* tabs
(set vim.opt.tabstop 2)                       ; Number of spaces for *inserting* tabs
(set vim.opt.softtabstop 2)                   ; Number of spaces for (auto)indenting, e.g. >> & <<
(set vim.opt.expandtab true)                  ; Convert tabs to spaces
(set vim.opt.smarttab true)                   ; -
(set vim.opt.foldenable false)                ; Disable block folding
(set vim.opt.backspace "indent,eol,start")    ; -
(set vim.opt.history 10000)                   ; -
(set vim.opt.ttyfast true)                    ; -
(set vim.opt.ttimeoutlen 50)                  ; -
(set vim.opt.mouse "")                        ; Disable mouse
(set vim.opt.shortmess "f")                   ;

(when (u.has? "clipboard")
  (set vim.opt.clipboard "unnamedplus"))      ; Use Linux system clipboard

(when (u.has? "persistent_undo")
  (set vim.opt.undolevels 5000)               ; Increase the number of undos
  (set vim.opt.undofile true))                ; Persist undo logs per file inside `undodir`

; visual
(set vim.opt.number true)                     ; Hide line numbers
(set vim.opt.relativenumber true)             ; Hide numbers relative to current line
(set vim.opt.signcolumn "yes:1")              ; Display line column
(set vim.opt.cursorline true)                 ; Highlight cursor position row
(set vim.opt.splitbelow true)                 ; Prefer adding horizontal split below
(set vim.opt.splitright true)                 ; Prefer adding a vertical split on the right
(set vim.opt.wrap false)                      ; Do not wrap text
(set vim.opt.linebreak true)                  ; When wrapping is turned on, wrap on a line break
(set vim.opt.showcmd true)                    ; Show queued up command keystrokes
(set vim.opt.laststatus 3)                    ; Show a single status line only
(set vim.opt.switchbuf "uselast")             ; Jump to the previously used window when jumping to errors with |quickfix| commands
(set vim.opt.statusline (sl.build-statusline []))

; search options
(set vim.opt.hlsearch true)                   ; -
(set vim.opt.incsearch true)                  ; -
(set vim.opt.wrapscan false)                  ; Do not wrap search scans
(set vim.opt.ignorecase true)                 ; Ignore case when using lowercase in search
(set vim.opt.smartcase true)                  ; But don't ignore it when using upper case

;; completion
(set vim.opt.complete ".,w,b,u,t,kspell")     ; remove imports, add spellchecker to completion sources
(set vim.opt.completeopt                      ; -
     "menu,menuone,noselect,noinsert")
(set vim.opt.path ".,,")                      ; search in current file's directory or pwd (do not use **)
(set vim.opt.wildmenu true)                   ; -
(set vim.opt.wildmode                         ; Set order of completion matches
     "lastused,longest,full")
(set vim.opt.wildignore                       ; -
     "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class")
(set vim.opt.wildignorecase true)             ; ignore case when filtering results
(set vim.opt.wildoptions "pum")               ; use popup to show results

; use ripgrep
(when (u.executable? "rg")
  (set vim.opt.grepprg "rg\\ --smart-case\\ --hidden\\ --follow\\ --no-heading\\ --vimgrep")
  (set vim.opt.grepformat "%f:%l:%c:%m,%f:%l:%m"))

; -----------------------------------------------------------------------------
; USER COMMANDS & AUTOCOMMANDS

; Remember the cursor position of the last editing
(ac.autocmd :BufReadPost {:pattern "*"
                          :command "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})

(vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})

(ac.augroup :highlight-group
            ; highlight yanked text
            [:TextYankPost {:pattern "*"
                            :callback (fn [] (vim.highlight.on_yank {:timeout 200
                                                                     :on_visual false}))}]

            ; highlight TODO and FIXME keywords
            [[:WinEnter :VimEnter] {:pattern "*"
                                    :command ":silent! call matchadd('Todo','TODO\\|FIXME', -1)"}]

            [[:BufWinEnter :InsertLeave] {:pattern "*"
                                          :callback (fn []
                                                      (vim.cmd "hi link ExtraWhitespace Error")
                                                      (vim.cmd "match ExtraWhitespace /\\s\\+$/"))}]

            [[:BufWinLeave :InsertEnter] {:pattern "*"
                                          :command "hi ExtraWhitespace ctermbg=NONE guibg=NONE"}])

(ac.augroup :terminal-group
            ; remove signcolumn in terminal mode
            [:TermOpen {:pattern "*"
                        :command "set signcolumn=no"}])

(require :colors)
(require :juice.filetypes)
(require :mappings)
(require :packs)
