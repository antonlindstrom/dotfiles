import System.IO
import XMonad
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies, wsContainingCopies)
import XMonad.Actions.FloatKeys
import XMonad.Actions.WindowGo (title, raiseMaybe, runOrRaise)
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
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

-- Toggle global window
toggleGlobal :: X ()
toggleGlobal = do
    ws <- wsContainingCopies
    if null ws
    then windows copyToAll
    else killAllOtherCopies

baseConfig = desktopConfig

myManageHookFloat = composeAll
    [ isFullscreen                     --> doFullFloat
    , isDialog                         --> doCenterFloat
    , className =? "Gimp"              --> doFloat
    , className =? "Steam"             --> doFloat
    , className =? "mpv"               --> doCenterFloat
    , className =? "Pinentry"          --> doCenterFloat
    , className =? "Zenity"            --> doCenterFloat
    , className =? "Pavucontrol"       --> (doRectFloat $ W.RationalRect (1/6) (1/6) (4/6) (4/6))
    , className =? "Slack"             --> (doRectFloat $ W.RationalRect (1/6) (1/6) (4/6) (4/6))
    , className =? "plexmediaplayer"   --> (doRectFloat $ W.RationalRect (1/6) (1/6) (4/6) (4/6))
    , title     =? "gtop-win"          --> (doRectFloat $ W.RationalRect (1/6) (1/6) (4/6) (4/6))
    , title     =? "htop-win"          --> (doRectFloat $ W.RationalRect (1/6) (1/6) (4/6) (4/6))
    ]

main = do
    xmproc <- spawnPipe "xmobar -d"
    spawn "feh --bg-center $(cat ${HOME}/.desktopbg) &"
    spawn "xcompmgr"
    xmonad $ withUrgencyHook myUrgencyHook
           $ ewmh
           $ baseConfig {
        normalBorderColor = "#101313",
        focusedBorderColor = "#657b83",
        manageHook  = manageDocks <+> myManageHookFloat <+> manageHook baseConfig,
        layoutHook  = smartBorders . avoidStruts $ layoutHook baseConfig,
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
      [
        -- apps
        ("M-a s", raiseMaybe (spawn "slack") (className =? "Slack")),
        ("M-a v", raiseMaybe (spawn "pavucontrol") (className =? "Pavucontrol")),
        ("M-a g", runInTerm "-t gtop-win" "gtop"),
        ("M-a t", runInTerm "-t htop-win" "htop"),

        -- rofi
        ("M-o", spawn "rofi -combi-modi window,drun -show combi -modi combi"),
        ("M-p", spawn "passdmenu -x c"),

        -- lock
        ("M-<Esc>", spawn "slock"),

        -- brightness
        ("M-<F1>", spawn "brightnessctl set 15%-"),
        ("M-<F2>", spawn "brightnessctl set +15%"),

        -- screenshots
        ("<Print>", spawn "scrot --focused -e 'notify-send -u normal \"Screenshot saved\" \"$f\"'"),
        ("S-<Print>", spawn "sleep 0.3; scrot --select -e 'notify-send -u normal \"Screenshot saved\" \"$f\"'"),

        -- terminal style (toggle colors)
        ("M-<F5>", spawn "termstyle toggle"),

        -- volume
        ("M-<F11>", spawn "amixer set Master 2-"),
        ("M-<F12>", spawn "amixer set Master 2+"),

        -- layouts
        ("M-n", refresh),
        ("M-<Space>", sendMessage NextLayout),
        ("M-<Tab>", windows W.focusDown),
        ("M-j", windows W.swapDown),
        ("M-k", windows W.swapUp),
        ("M-<Return>", windows W.focusMaster),
        ("M-r", withFocused $ windows . W.sink),

        -- make a window stick to all workspaces.
        ("M-z", toggleGlobal),

        ("M-g", withFocused (keysResizeWindow (-10,0) (0,0))),
        ("M-f", withFocused (keysResizeWindow (10,0) (0,0))),
        ("M-S-g", withFocused (keysResizeWindow (0,-10) (0,0))),
        ("M-S-f", withFocused (keysResizeWindow (0,10) (0,0))),

        -- urgent
        ("M-u", focusUrgent),
        ("M-S-u", clearUrgents),

        -- window control
        ("M-S-x", kill)]

