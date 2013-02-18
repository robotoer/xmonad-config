import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.PhysicalScreens
import XMonad.Config.Gnome
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

screenKeys = [
  (xK_w, 0),
  (xK_e, 1),
  (xK_r, 2) ]

main =
  xmonad $ gnomeConfig {
    terminal = "urxvt",
    modMask = mod4Mask
  }
  `additionalKeys` ([
    -- Application shortcuts
    ((mod4Mask, xK_c), spawn "google-chrome"),
    ((mod4Mask, xK_v), spawn "google-chrome --incognito"),

    -- Config for gridview
    ((mod4Mask, xK_g), goToSelected defaultGSConfig),

    -- Setup better Xinerama bindings for switching between screens.
    ((mod4Mask, xK_a), onPrevNeighbour W.view),
    ((mod4Mask, xK_o), onNextNeighbour W.view),
    ((mod4Mask .|. shiftMask, xK_a), onPrevNeighbour W.shift),
    ((mod4Mask .|. shiftMask, xK_o), onNextNeighbour W.shift),

    -- Setup cycling through workspaces.
    ((mod4Mask, xK_Right), nextWS),
    ((mod4Mask, xK_Left), prevWS),
    ((mod4Mask .|. shiftMask, xK_Right), shiftToNext),
    ((mod4Mask .|. shiftMask, xK_Left), shiftToPrev)
  ] ++ [
    ((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f)) -- Replace 'mod1Mask' with your mod key of choice.
        | (key, sc) <- screenKeys
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ])
