import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig

myTerminal :: String

myTerminal = "termite"

myBorderWidth :: Dimension

myBorderWidth = 2

baseConfig = desktopConfig

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ baseConfig {
        normalBorderColor = "#101313",
        focusedBorderColor = "#2b2b2b",
        manageHook  = manageDocks <+> manageHook baseConfig,
        layoutHook  = avoidStruts $ layoutHook baseConfig,
        terminal    = myTerminal,
        borderWidth = myBorderWidth
    } `additionalKeysP`
      [ -- apps
        ("M-c", spawn myTerminal),
        ("M-w", spawn "qutebrowser"),

        -- rofi
        ("M-p", spawn "rofi -show run"),

        -- lock
        ("M-<Esc>", spawn "xlock -mode blank"),

        -- volume
        ("M-m", spawn "amixer set Master toggle"),

        -- window control
        ("M-x", kill)]

