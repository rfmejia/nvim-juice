(module colors
  {autoload {u util}
   import-macros [[ac :aniseed.macros.autocmds]]})

(defn- color-attr [hl-group attribute]
  "Extract an attribute from an existing highlight group"
  (. (vim.api.nvim_get_hl 0 {:name hl-group}) attribute))

(def- custom-colors {:normal-bg (color-attr :Normal :bg)
                     :info-fg (color-attr :DiagnosticInfo :fg)
                     :error-fg (color-attr :DiagnosticError :fg)
                     :warn-fg (color-attr :DiagnosticWarn :fg)
                     :statusline-bg (color-attr :StatusLine :bg)
                     :dark-gray :#3d3d3d
                     :dark-green :#009000
                     :light-gray :#707070})

(local c custom-colors)
(def- groups {:Comment {:fg c.light-gray :style :italic}
              :Conceal {:link :Comment}
              :CursorLine {:bg c.normal-bg}
              :CursorLineNr {:link :Normal}
              :DiagnosticVirtualTextError {:fg c.error-fg :style :italic}
              :DiagnosticVirtualTextWarn {:fg c.warn-fg :style :italic}
              :ExtraWhitespace {:fg c.error-fg :undercurl true}
              :FloatBorder {:fg c.light-gray}
              :LineNr {:fg c.dark-gray :bg c.cursor-bg}
              :LineNrAbove {:fg c.dark-gray :bg c.normal-bg}
              :LineNrBelow {:fg c.dark-gray :bg c.normal-bg}
              :MsgArea {:fg c.light-gray}
              :NormalFloat {:bg c.normal-bg}
              :SpellBad {:fg c.warn-fg :style :undercurl}
              :StatusLine {:fg c.light-gray :bg c.normal-bg}
              :StatusLineInfo {:fg c.info-fg :bg c.statusline-bg}
              :StatusLineError {:fg c.error-fg :bg c.statusline-bg}
              :StatusLineWarn {:fg c.warn-fg :bg c.statusline-bg}
              :Todo {:link :ModeMsg}
              :WinSeparator {:fg c.dark-green :bg c.normal-bg}
              })

(defn show-extra-whitespace []
  (vim.api.nvim_set_hl 0 :ExtraWhitespace groups.ExtraWhitespace))

(defn- get-gnome-colorscheme [dark-scheme light-scheme]
  "If in Gnome check the current system theme and set nvim theme"
  (let [gsettings-cmd [:gsettings :get :org.gnome.desktop.interface :color-scheme]]
    (if (u.executable? :gsettings)
      (do
        (local system-theme (vim.fn.system gsettings-cmd))
        (if (or (string.find system-theme :default)
                (string.find system-theme :prefer-light))
          light-scheme
          dark-scheme))
      dark-scheme)
    ))

(defn setup []
  (let [theme (require :github-theme)
        options {:transparent true}]
    (theme.setup {: options :groups {:all groups}})
    (comment vim.cmd.colorscheme (get-gnome-colorscheme :github_dark :github_light))
    (vim.cmd.colorscheme :github_dark)
    ))
