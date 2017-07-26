import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig

myTerminal :: String

myTerminal = "termite"

myBorderWidth :: Dimension

myBorderWidth = 2

myWorkspaces = ["1:main","2:www","3:chat","4:media","5:other"] 

baseConfig = desktopConfig

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig { font = "9x15,xft:inconsolata"
                      , bgColor  = "#2b2b2b"
                      , fgColor  = "grey"
                      , promptBorderWidth = 0
                      , position = Top
                      , height   = 15
                      , historySize = 256 }

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ baseConfig {
        normalBorderColor = "#101313",
        focusedBorderColor = "#2b2b2b",
        manageHook  = manageDocks <+> manageHook baseConfig,
        layoutHook  = avoidStruts $ layoutHook baseConfig,
        workspaces  = myWorkspaces,
        terminal    = myTerminal,
        borderWidth = myBorderWidth
    } `additionalKeysP`
      [ -- apps
        ("M-c", spawn myTerminal),
        ("M-w", spawn "qutebrowser"),

        -- rofi
        ("M-p", spawn "rofi -show run"),

        -- pass
        ("M-o", passPrompt myXPConfig),

        -- lock
        ("M-<Esc>", spawn "xlock -mode blank"),

        -- volume
        ("M-<F10>", spawn "amixer set Master toggle"),
        ("M-<F11>", spawn "amixer set Master 2-"),
        ("M-<F12>", spawn "amixer set Master 2+"),

        -- window control
        ("M-x", kill)]

