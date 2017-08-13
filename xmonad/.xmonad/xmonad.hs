import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Prompt
import XMonad.Prompt.Pass
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig

myTerminal :: String

myTerminal = "termite"

myBorderWidth :: Dimension

myBorderWidth = 2

myWorkspaces = ["one","two","three","four","five"] ++ map show [6..9]

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
    xmproc <- spawnPipe "xmobar -d"
    xmonad $ baseConfig {
        normalBorderColor = "#101313",
        focusedBorderColor = "#2b2b2b",
        manageHook  = manageDocks <+> manageHook baseConfig,
        layoutHook  = avoidStruts $ layoutHook baseConfig,
        logHook = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "#657b83" "" . shorten 100
            , ppCurrent = xmobarColor "#657b83" "" . wrap "" ""
            , ppSep     = xmobarColor "#c0c0c0" "" " | "
            , ppUrgent  = xmobarColor "#ff69b4" ""
            , ppLayout = const "" -- to disable the layout info on xmobar
        },
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

        -- terminal style (toggle colors)
        ("M-<F5>", spawn "termstyle toggle"),

        -- volume
        ("M-<F10>", spawn "amixer set Master toggle"),
        ("M-<F11>", spawn "amixer set Master 2-"),
        ("M-<F12>", spawn "amixer set Master 2+"),

        -- window control
        ("M-x", kill)]

