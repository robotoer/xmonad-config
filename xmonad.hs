import XMonad
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.Volume
import XMonad.Config.Gnome
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig

-- Custom hotkeys.
customKeysP :: [(String, X ())]
customKeysP =
    [
      -- Application shortcuts.
      ("M-c", spawn "google-chrome --profile-directory=Default"),
      ("M-x", spawn "google-chrome --profile-directory=\"Profile 1\""),
      ("M-S-x", spawn "google-chrome --incognito"),
      ("M-a", spawn "hipchat"),
      ("M-v", spawn "spotify"),
      ("M-z", spawn "gvim ~/.xmonad/xmonad.hs"),
      ("M-i", spawn "/home/robert/lib/idea/bin/idea.sh"),

      -- Volume shortcuts. These require that 'xmonad-extras' is installed.
      ("M-<Up>", raiseVolume 3 >> return ()),
      ("M-<Down>", lowerVolume 3 >> return ()),

      -- Find empty workspace shortcuts.
      ("M-y", viewEmptyWorkspace),
      ("M-S-y", tagToEmptyWorkspace),

      -- Launcher shortcut.
      ("M-;", spawn "/usr/bin/dmenu_run")
    ]

-- Key unbindings.
customUnkeysP =
    [
      -- Default
      --   Run program launcher.
      -- Reason
      --   This hotkey has a race condition with the monitor switch gnome keybinding.
      "M-p"
    ]

customWorkspaces =
    [
      "1:edit",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9:web"
    ]

customManageHook = composeAll
    [
      -- Send browser windows to the web workspace.
      appName =? "google-chrome" --> doShift "9:web",

      -- Send IDE to the edit workspace.
      className =? "jetbrains-idea-ce" --> doShift "1:edit",
      className =? "jetbrains-idea" --> doShift "1:edit",

      -- Float xmessage windows.
      className =? "Xmessage" --> doFloat
    ]

-- Custom settings overriding defaults from 'gnomeConfig'.
-- customConfig = ewmh gnomeConfig
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
      startupHook = setWMName "LG3D",

      -- Use custom workspaces.
      workspaces = customWorkspaces,

      -- Create certain programs in specific workspaces.
      manageHook = manageDocks <+> customManageHook <+> manageHook gnomeConfig
    }

-- Start XMonad.
main :: IO ()
main = (xmonad (additionalKeysP (removeKeysP customConfig customUnkeysP) customKeysP))
