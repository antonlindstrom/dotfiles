import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Prompt
import XMonad.Prompt.Pass
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

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
        focusedBorderColor = "#657b83",
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

        ("<XF86AudioMute>", spawn "amixer set Master toggle"),
        ("<XF86AudioLowerVolume>", spawn "amixer set Master 2-"),
        ("<XF86AudioRaiseVolume>", spawn "amixer set Master 2+"),

        -- brightness
        ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%"),
        ("<XF86MonBrightnessDown>", spawn "brightnessctl set -10%"),

        -- layouts
        ("M-n", refresh),
        ("M-<Space>", sendMessage NextLayout),
        ("M-<Tab>", windows W.focusDown),
        ("M-j", windows W.focusDown),
        ("M-k", windows W.focusUp),
        ("M-<Return>", windows W.focusMaster),
        ("M-S-j", windows W.swapDown),
        ("M-S-k", windows W.swapUp),
        ("M-g", sendMessage Shrink),
        ("M-l", sendMessage Expand),
        ("M-r", withFocused $ windows . W.sink),

        -- window control
        ("M-x", kill)]

