import XMonad
import XMonad.Actions.Volume
import XMonad.Config.Gnome
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig

-- Custom hotkeys.
customKeysP =
    [
      -- Application shortcuts.
      ("M-c", spawn "google-chrome --profile-directory=Default"),
      ("M-x", spawn "google-chrome --profile-directory=\"Profile 1\""),
      ("M-S-x", spawn "google-chrome --incognito"),
      ("M-a", spawn "hipchat"),
      ("M-v", spawn "spotify"),
      ("M-z", spawn "gvim ~/.xmonad/xmonad.hs"),

      -- Volume shortcuts. These require that 'xmonad-extras' is installed.
      ("M-<Up>", raiseVolume 3 >> return ()),
      ("M-<Down>", lowerVolume 3 >> return ())
    ]

-- Key unbindings.
customUnkeysP =
    [
      -- default
      --   run program launcher.
      -- reason
      --   kupfer handles its own keys.
      "M-p"
    ]

-- Custom settings overriding defaults from 'gnomeConfig'.
customConfig = gnomeConfig
    {
      -- Switch from using <Ctrl> as the window manager key to <Super> (also known as the
      -- windows key).
      modMask = mod4Mask,

      -- Switch to using terminator as the default terminal emulator.
      terminal = "terminator",

      -- Fix for chrome + fullscreen
      -- (https://wiki.archlinux.org/index.php/Xmonad#Chromium.2FChrome_will_not_go_fullscreen).
      handleEventHook = fullscreenEventHook,

      -- Fix for java swing applications.
      startupHook = setWMName "LG3D"
    }

-- Start XMonad.
main = (xmonad (additionalKeysP (removeKeysP customConfig customUnkeysP) customKeysP))
