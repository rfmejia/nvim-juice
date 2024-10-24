(local {: autoload} (require :nfnl.module))
(local gh-theme (autoload :github-theme))
(local util (autoload :juice.util))

(lambda color-attr [hl-group attribute]
  "Extract an attribute from an existing highlight group"
  (. (vim.api.nvim_get_hl 0 {:name hl-group}) attribute))

(local custom-colors {:normal-bg "#000000"
                      :info-fg (color-attr :DiagnosticInfo :fg)
                      :error-fg (color-attr :DiagnosticError :fg)
                      :warn-fg (color-attr :DiagnosticWarn :fg)
                      :hint-fg (color-attr :DiagnosticHint :fg)
                      :info-fg (color-attr :DiagnosticInfo :fg)
                      :ok-fg (color-attr :DiagnosticOk :fg)
                      :statusline-bg "#000000"
                      :dark-gray "#3d3d3d"
                      :darker-gray "#1d1d1d"
                      :dark-green "#009000"
                      :light-gray "#707070"})

(local c custom-colors)
(local custom-groups
       {:Comment {:fg c.light-gray :style :italic}
        :Conceal {:link :Comment}
        :CursorLine {:bg c.normal-bg}
        :CursorLineNr {:link :Normal}
        :DiagnosticVirtualTextError {:fg c.error-fg :style :italic}
        :DiagnosticVirtualTextWarn {:fg c.warn-fg :style :italic}
        :DiagnosticVirtualTextHint {:fg c.hint-fg :style :italic}
        :DiagnosticVirtualTextInfo {:fg c.info-fg :style :italic}
        :DiagnosticVirtualTextOk {:fg c.ok-fg :style :italic}
        :FloatBorder {:fg c.light-gray}
        :LineNr {:fg c.dark-gray :bg c.cursor-bg}
        :LineNrAbove {:fg c.dark-gray :bg c.normal-bg}
        :LineNrBelow {:fg c.dark-gray :bg c.normal-bg}
        :MsgArea {:fg c.light-gray}
        :Normal {:bg c.normal-bg}
        :NormalFloat {:bg c.normal-bg}
        :SpellBad {:fg c.warn-fg :style :undercurl}
        :StatusLine {:fg c.light-gray :bg c.normal-bg}
        :StatusLineInfo {:fg c.info-fg :bg c.statusline-bg}
        :StatusLineError {:fg c.error-fg :bg c.statusline-bg}
        :StatusLineWarn {:fg c.warn-fg :bg c.statusline-bg}
        :TelescopeSelection {:bg c.darker-gray}
        :Todo {:link :ModeMsg}
        :WinSeparator {:fg c.dark-green :bg c.normal-bg}})

(lambda get-gnome-colorscheme [dark-scheme light-scheme]
  "If in Gnome check the current system theme and set nvim theme"
  (let [gsettings-cmd [:gsettings
                       :get
                       :org.gnome.desktop.interface
                       :color-scheme]]
    (if (util.executable? :gsettings)
        (do
          (local system-theme (vim.fn.system gsettings-cmd))
          (if (or (string.find system-theme :default)
                  (string.find system-theme :prefer-light))
              light-scheme
              dark-scheme))
        dark-scheme)))

(fn setup []
  (let [groups {:github_dark custom-groups}
        options {:transparent true}]
    (gh-theme.setup {: options : groups})
    (comment vim.cmd.colorscheme
      (get-gnome-colorscheme :github_dark :github_light))
    (comment vim.cmd.colorscheme :github_dark)
    (vim.cmd "set notermguicolors")
    (vim.cmd.colorscheme :default)))

{: setup : color-attr}
