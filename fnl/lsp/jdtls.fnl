(local handlers (require :vim.lsp.handlers))
(local env {:HOME (vim.uv.os_homedir)
            :JDTLS_JVM_ARGS (os.getenv :JDTLS_JVM_ARGS)
            :XDG_CACHE_HOME (os.getenv :XDG_CACHE_HOME)})

(fn get-cache-dir []
  (or (and env.XDG_CACHE_HOME env.XDG_CACHE_HOME) (.. env.HOME :/.cache)))

(fn get-jdtls-cache-dir [] (.. (get-cache-dir) :/jdtls))
(fn get-jdtls-config-dir [] (.. (get-jdtls-cache-dir) :/config))
(fn get-jdtls-workspace-dir [] (.. (get-jdtls-cache-dir) :/workspace))
(fn get-jdtls-jvm-args []
  (let [args {}]
    (each [a (string.gmatch (or env.JDTLS_JVM_ARGS "") "%S+")]
      (local arg (string.format "--jvm-arg=%s" a))
      (table.insert args arg))
    (unpack args)))

(fn fix-zero-version [workspace-edit]
  (when (and workspace-edit workspace-edit.documentChanges)
    (each [_ change (pairs workspace-edit.documentChanges)]
      (local text-document change.textDocument)
      (when (and text-document text-document.version
                 (= text-document.version 0))
        (set text-document.version nil))))
  workspace-edit)

(fn on-textdocument-codeaction [err actions ctx]
  (each [_ action (ipairs actions)]
    (if (= action.command :java.apply.workspaceEdit)
        (set action.edit
             (fix-zero-version (or action.edit (. action.arguments 1))))
        (and (= (type action.command) :table)
             (= action.command.command :java.apply.workspaceEdit))
        (set action.edit
             (fix-zero-version (or action.edit (. action.command.arguments 1))))))
  ((. handlers ctx.method) err actions ctx))

(fn on-textdocument-rename [err workspace-edit ctx]
  ((. handlers ctx.method) err (fix-zero-version workspace-edit) ctx))

(fn on-workspace-applyedit [err workspace-edit ctx]
  ((. handlers ctx.method) err (fix-zero-version workspace-edit) ctx))

(fn on-language-status [_ result]
  (let [command vim.api.nvim_command]
    (command "echohl ModeMsg")
    (command (string.format "echo \"%s\"" result.message))
    (command "echohl None")))

{:cmd [:jdtls
       :-configuration
       (get-jdtls-config-dir)
       :-data
       (get-jdtls-workspace-dir)
       (get-jdtls-jvm-args)]
 :filetypes [:java]
 :handlers {:language/status (vim.schedule_wrap on-language-status)
            :textDocument/codeAction on-textdocument-codeaction
            :textDocument/rename on-textdocument-rename
            :workspace/applyEdit on-workspace-applyedit}
 :init_options {:jvm_args {}
                :os_config nil
                :workspace (get-jdtls-workspace-dir)}
 :single_file_support true}
