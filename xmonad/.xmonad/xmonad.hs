import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Prompt
import XMonad.Prompt.Pass
import XMonad.Util.NamedWindows
import XMonad.Util.Run
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

myTerminal :: String

myTerminal = "termite"

myBorderWidth :: Dimension

myBorderWidth = 2

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myUrgencyHook = LibNotifyUrgencyHook

myWorkspaces = ["one","two","three","four","five", "six", "seven", "eight", "nine"]

baseConfig = desktopConfig

main = do
    xmproc <- spawnPipe "xmobar -d"
    xmonad $ withUrgencyHook myUrgencyHook
           $ ewmh
           $ baseConfig {
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

        -- rofi
        ("M-p", spawn "rofi -show run"),
        ("M-o", spawn "passdmenu"),

        -- lock
        ("M-<Esc>", spawn "slock"),

        -- brightness
        ("M-<F1>", spawn "brightnessctl set 15%-"),
        ("M-<F2>", spawn "brightnessctl set +15%"),

        -- screenshots
        ("M-<F4>", spawn "scrot --focused -e 'mv $f ~/'"),
        ("M-S-<F4>", spawn "sleep 0.3; scrot --select -e 'mv $f ~/'"),

        -- terminal style (toggle colors)
        ("M-<F5>", spawn "termstyle toggle"),

        -- volume
        ("M-<F10>", spawn "amixer set Master toggle && notify-send 'xmonad' 'Volume muted.'"),
        ("M-<F11>", spawn "amixer set Master 2-"),
        ("M-<F12>", spawn "amixer set Master 2+"),

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

        -- Urgent
        ("M-u", focusUrgent),
        ("M-S-u", clearUrgents),

        -- window control
        ("M-x", kill)]

