(module startup
  {autoload {sl juice.statusline}
   import-macros [[ac :aniseed.macros.autocmds]]})

; -----------------------------------------------------------------------------
; GENERAL OPTIONS
(when (= (vim.fn.has "syntax") 1)
  (vim.cmd "syntax enable"))
(vim.cmd "filetype plugin on")

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

(when (= (vim.fn.has "clipboard") 1)
  (set vim.opt.clipboard "unnamedplus"))      ; Use Linux system clipboard

(when (= (vim.fn.has "persistent_undo") 1)
  (set vim.opt.undolevels 5000)               ; Increase the number of undos
  (set vim.opt.undofile true))                ; Persist undo logs per file inside `undodir`

; visual
(set vim.opt.number false)                    ; Hide line numbers
(set vim.opt.relativenumber false)            ; Hide numbers relative to current line
(set vim.opt.signcolumn "auto")               ; Display line column
(set vim.opt.cursorline true)                 ; Highlight cursor position row
(set vim.opt.splitbelow true)                 ; Prefer adding horizontal split below
(set vim.opt.splitright true)                 ; Prefer adding a vertical split on the right
(set vim.opt.wrap false)                      ; Do not wrap text
(set vim.opt.linebreak true)                  ; When wrapping is turned on, wrap on a line break
(set vim.opt.showcmd true)                    ; Show queued up command keystrokes
(set vim.opt.laststatus 2)                    ; Always show the status line
(set vim.opt.switchbuf "uselast")             ; Jump to the previously used window when jumping to errors with |quickfix| commands

; search options
(set vim.opt.hlsearch true)                   ; -
(set vim.opt.incsearch true)                  ; -
(set vim.opt.wrapscan false)                  ; Do not wrap search scans
(set vim.opt.ignorecase true)                 ; Ignore case when using lowercase in search
(set vim.opt.smartcase true)                  ; But don't ignore it when using upper case

;; completion
(set vim.opt.complete ".,w,b,u,t,kspell")     ; remove imports, add spellchecker to completion sources
(set vim.opt.completeopt "menu,menuone,noselect,noinsert") ; -
(set vim.opt.path ".,,")                      ; search in current file's directory or pwd (do not use **)
(set vim.opt.wildmenu true)                   ; -
(set vim.opt.wildmode "lastused,longest,full") ; Set order of completion matches
(set vim.opt.wildignore "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class")
(set vim.opt.wildignorecase true)             ; ignore case when filtering results
(set vim.opt.wildoptions "pum")               ; use popup to show results

; use ripgrep
(when (= (vim.fn.executable "rg") 1)
  (set vim.opt.grepprg "rg\\ --vimgrep\\ --no-heading")
  (set vim.opt.grepformat "%f:%l:%c:%m,%f:%l:%m"))

(set vim.opt.statusline (sl.build-statusline []))

; -----------------------------------------------------------------------------
; USER COMMANDS & AUTOCOMMANDS
(vim.api.nvim_create_user_command :TrimTrailingWhitespaces ":%s/\\s\\+$" {})

(ac.augroup :special-filetypes 
            [[:BufNewFile :BufRead] {:pattern ["*.txt" "*.text"] 
                                     :command "setf text"}]
            [[:BufNewFile :BufRead] {:pattern "tmux.conf"
                                     :command "setf tmux"}]
            [[:BufNewFile :BufRead] {:pattern ["*.sbt" "*.sc"]
                                     :command "setf scala"}])

(defn- highlight-extra-whitespaces []
  "Highlight trailing whitespaces"
  (vim.cmd "hi link ExtraWhitespace Error")
  (vim.cmd "match ExtraWhitespace /\\s\\+$/"))

(ac.augroup :highlight-group
            ; highlight yanked text
            [:TextYankPost {:pattern "*"
                            :callback (fn [] (vim.highlight.on_yank {:timeout 200
                                                                     :on_visual false}))}]

            ; highlight TODO and FIXME keywords
            [[:WinEnter :VimEnter] {:pattern "*"
                                    :command ":silent! call matchadd('Todo','TODO\\|FIXME', -1)"}]

            [[:BufWinEnter :InsertLeave]
             {:pattern "*"
              :callback (fn []
                          (vim.cmd "hi link ExtraWhitespace Error")
                          (vim.cmd "match ExtraWhitespace /\\s\\+$/"))}]

            [[:BufWinLeave :InsertEnter]
             {:pattern "*"
              :command "hi ExtraWhitespace ctermbg=NONE guibg=NONE"}])

;; -----------------------------------------------------------------------------
;; COLORS
(set vim.opt.termguicolors true)
(set vim.opt.background "dark")

; (vim.cmd "hi CursorLine cterm=NONE ctermbg=234 guibg=#1c1c1c")
; (vim.cmd "hi StatusLine ctermbg=NONE ctermfg=white guibg=NONE guifg=white")

; Note: make sure this is defined before the colorscheme is first set
(ac.augroup :colorscheme-group
            [:ColorScheme {:pattern "*"
                           :callback (fn []
                                       (when (= vim.o.background "dark")
                                         (vim.api.nvim_set_hl 0 "Normal" {:bg "black"})
                                         (vim.api.nvim_set_hl 0 "VertSplit" {:fg "black"})
                                         (vim.api.nvim_set_hl 0 "Todo" {:fg "yellow"}))
                                       )}

             ; Add special highlight groups for diagnostic counts on the statusline
             :ColorScheme {:pattern "*"
                           :callback (fn []
                                       (let [color-attr (lambda [hl-group attr]
                                                          (. (vim.api.nvim_get_hl 0 {:name hl-group}) attr))
                                             error-fg (color-attr "DiagnosticError" "fg")
                                             warn-fg (color-attr "DiagnosticWarn" "fg")
                                             statusline-bg (color-attr "StatusLine" "bg")]
                                         (vim.api.nvim_set_hl 0 "StatusLineError" {:fg error-fg :bg statusline-bg})
                                         (vim.api.nvim_set_hl 0 "StatusLineWarn" {:fg warn-fg :bg statusline-bg})))
                           }])

(require :mappings)
(require :packs)
