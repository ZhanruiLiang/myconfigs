{-# LANGUAGE NoMonomorphismRestriction #-}
-- Ray's XMonad config file.
-- {{{
import XMonad hiding (Tall)
import Data.Monoid
import System.Exit
import Graphics.X11.ExtraTypes.XF86  
import XMonad.Actions.WindowMenu
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run
import XMonad.Util.Themes
import XMonad.Util.Font
import XMonad.Layout.DecorationMadness
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Minimize
import XMonad.Layout.Maximize
-- import XMonad.Layout.OneBig
import XMonad.Layout.HintedTile
-- import XMonad.Layout.IM
-- import XMonad.Layout.Roledex
-- import XMonad.Layout.DwmStyle
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.NoBorders
import XMonad.Layout.Cross
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
import XMonad.Layout.Decoration
import XMonad.Layout.DecorationAddons
import XMonad.Layout.ButtonDecoration
import XMonad.Layout.Circle
import XMonad.Layout.Column
-- import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed
import XMonad.Actions.GridSelect
import XMonad.Prompt
import XMonad.Prompt.Window
import System.IO  
-- import XMonad.Config.Gnome
-- import XMonad.Config.Bluetile

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- }}}
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "roxterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

-- workspaces {{{
myWorkspaces = [webSpace, codeSpace, codeSpace2, musicSpace, sysSpace, artSpace, downloadSpace, miscSpace1, miscSpace2] 

webSpace = "1.網"
codeSpace = "2.作"
codeSpace2 = "3.業"
musicSpace = "4.音楽"
sysSpace = "5.系統"
artSpace = "6.設計"
-- musicSpace = "4>music"
-- sysSpace = "5>sys"
-- artSpace = "6>design"
downloadSpace = "7.下載"
miscSpace1 = "8.雑"
miscSpace2 = "9.雑"
-- }}}

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#0f8f4f"

-- grid select
myGSConfig = defaultGSConfig 
    { gs_cellheight = 60
    , gs_cellwidth = 200
    , gs_cellpadding = 20
    }

------------------------------------------------------------------------
-- Layouts:
myLayout = onWorkspaces [webSpace] 
                (tabbed' ||| tiled ||| Mirror tiled ||| full) $
           onWorkspaces [codeSpace, codeSpace2] 
                (Mirror tiled ||| tiled ||| tabbed')$
           onWorkspaces [sysSpace] 
                (simpleCross ||| tiled ||| full)$
           onWorkspaces [artSpace] 
                (full ||| tiled ||| Mirror tiled) $
           -- onWorkspaces [musicSpace, artSpace, miscSpace1, miscSpace1] 
           -- default layout
           (Circle ||| tiled ||| Mirror tiled ||| tabbed' ||| full)
    where
         -- The default number of windows in the master pane
         nmaster = 1
         -- Default proportion of screen occupied by master pane
         ratio   = 4/7
         -- Percent of screen to increment by when resizing panes
         delta   = 3/100
         tiled   = HintedTile nmaster delta ratio TopLeft Tall

         tabbed' = tabbed shrinkText myTheme

         full = noBorders Full

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
-- {{{
-- mousekeyMask = myModMask .|. mod1Mask
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ 
    [ 
    -- launch a terminal
    ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- grid select
    , ((modm, xK_g), (goToSelected) defaultGSConfig)
    , ((modm, xK_s), spawnSelected myGSConfig ["xterm","gmplayer","gvim"])

    -- prompt select
    -- , ((modm .|. shiftMask, xK_g), windowPromptGoto defaultXPConfig)

    -- launch a terminal
    , ((mod1Mask .|. controlMask, xK_t), spawn $ XMonad.terminal conf)

    -- launch ncmpcpp
    , ((modm, xK_p), spawn "roxterm -e ncmpcpp")

    -- screenshot
    -- , ((0, xK_Print), spawn "scrot -s -cd 2 ~/shot.png")
    -- , ((0, xK_Print), spawn "~/bin/newshot.py")
    , ((0, xK_Print), spawn "deepin-scrot")

    -- -- control mouse, aka. mousekey
    -- , ((mousekeyMask, xK_h), spawn $ "/usr/local/bin/mkclient.py -12 0")
    -- , ((mousekeyMask, xK_j), spawn $ "/usr/local/bin/mkclient.py 0 10")
    -- , ((mousekeyMask, xK_k), spawn $ "/usr/local/bin/mkclient.py 0 -9")
    -- , ((mousekeyMask, xK_l), spawn $ "/usr/local/bin/mkclient.py 11 0")

    -- --  click mouse button
    -- , ((mousekeyMask, xK_Return), spawn $ "/usr/local/bin/mkclient.py L")
    -- , ((mousekeyMask, xK_backslash), spawn $ "/usr/local/bin/mkclient.py R")


    -- suspend
    -- , ((0, xF86XK_Sleep), spawn "sudo pm-suspend")
    , ((modm .|. shiftMask, xK_z), spawn "sudo pm-suspend")

    -- power off
    , ((modm, xF86XK_PowerOff), spawn "sudo shutdown -h now")

    -- volume setting
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%- -c 0") -- decrease volume  
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+ -c 0") -- increase volume  
    -- , ((0, xF86XK_AudioPlay), spawn "mpc toggle") -- toggle pause/play 
    -- , ((0, xF86XK_AudioPrev), spawn "mpc prev") 
    -- , ((0, xF86XK_AudioNext), spawn "mpc next") 
    -- , ((0, xF86XK_AudioStop), spawn "mpc stop") 

    -- launch folderviewer
    -- , ((modm, xK_f), spawn "spacefm")
    , ((modm, xK_f), spawn "roxterm -e ranger")

    -- launch dmenu
    -- , ((modm .|. shiftMask, xK_p), spawn "dmenu_run")
    , ((modm, xK_F2), spawn "dzen2")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p), spawn "gmrun")

    -- close focused window
    , ((modm , xK_c     ), kill)

    -- close focused window
    , ((mod1Mask, xK_F4     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- }}}
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
floatWindowNames = 
    [ "Main", "MPlayer", "Clock", "XClock", "INodeClient", "Cairo-dock", "Exaile.py"]
myManageHook = composeAll $
    [ className =? x --> doFloat | x <- floatWindowNames ] 
    ++
    [ className =? "Transmission" --> doShift downloadSpace
    , className =? "Amule" --> doShift downloadSpace
    , className =? "Firefox" --> doShift webSpace
    , className =? "Gnome-system-monitor" --> doShift sysSpace
    , className =? "Amarok" --> doShift musicSpace
    , className =? "Exaile" --> doShift musicSpace
    , className =? "DeepinScrot.py" --> doFullFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , isFullscreen --> doFullFloat
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------

dzenLogHook h = 
    dynamicLogWithPP $ defaultPP {
        ppCurrent           =   dzenColor "#ebac54" dzenBG . pad
      , ppVisible           =   dzenColor dzenFG dzenBG . pad
      , ppHidden            =   dzenColor dzenFG dzenBG . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" dzenBG . pad
      , ppUrgent            =   dzenColor "#ff0000" dzenBG . pad
      , ppWsSep             =   ""
      , ppSep               =   ":"
      , ppLayout            =   dzenColor "#ebac54" dzenBG .
                                (\x -> case x of
                                    "ResizableTall"             ->      "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Mirror ResizableTall"      ->      "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Full"                      ->      "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    "Simple Float"              ->      "~"
                                    _                           ->      x
                                )
      , ppTitle             =   (" " ++) . dzenColor dzenFG dzenBG . dzenEscape
      , ppOutput            =   hPutStrLn h
    }

xmobarLogHook h = 
    dynamicLogWithPP xmobarPP {
      ppOutput = System.IO.hPutStrLn h
    , ppTitle = xmobarColor "#ffffff" "" . shorten 50
    } 

myBitmapsDir = "/home/ray/.xmonad/dzen2"

dzenFG = "#F2F7B6"
-- dzenBG = "#44293F"
dzenBG = "#222222"
dzenHeight = "'18'"
 --dzenFont = "'Bitstream Vera Sans-8'"
-- dzenFont = "'Monospace:size=8'"
-- dzenFontLeft = "'hard gothic:size=10'"
-- dzenFontLeft = "'WenQuanYi Micro Hei:size=10'"
dzenFontLeft = "'SanaFon:size=11:bold'"
dzenFontRight = "'Bitstream Vera Sans Mono:size=8:bold'"
dzenLeftCmd = "dzen2  -y '0' -w '840' -h " ++ dzenHeight ++ " -ta 'l' -fg '" ++ dzenFG ++ "' -bg '" ++ dzenBG ++ "' -fn " ++ dzenFontLeft
dzenRightCmd = "dzen2 -x '840' -y '0' -w '426' -h " ++ dzenHeight ++ " -ta 'r' -bg '" ++ dzenBG ++ "' -fg '"++dzenFG ++ "' -fn " ++ dzenFontRight
dzenBgCmd = "dzen2 -h 20"

main = do
    -- debug
    writeFile "/tmp/xx" dzenLeftCmd
    writeFile "/tmp/yy" dzenRightCmd
    writeFile "/tmp/zz" dzenBgCmd
    -- xmproc <- spawnPipe "/usr/local/bin/xmobar"  
    dzenBgBar <- spawn dzenBgCmd
    dzenLeftBar <- spawnPipe $ "export LC_ALL=en_US.utf8 && " ++ dzenLeftCmd
    dzenRightBar <- spawn $ "export LC_ALL=en_US.utf8 && conky -c /home/ray/.xmonad/conky_dzen | " ++ dzenRightCmd
    imProc <- spawn "/usr/bin/fcitx"
    -- transdProc <- spawn "/usr/bin/transmission-daemon"
    -- trayProc <- spawn "/usr/bin/trayer --height 18 --transparent true --alpha 100 --width 10 --widthtype percent --edge top --align right --tint 0"
    xmonad $ defaultConfig{
        terminal = myTerminal
            , focusFollowsMouse  = myFocusFollowsMouse
            , borderWidth = myBorderWidth
            , modMask = myModMask
            , workspaces = myWorkspaces
            , normalBorderColor = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
            -- key bindings
            , keys = myKeys
            , mouseBindings = myMouseBindings
                -- hooks, layouts
            -- , layoutHook = buttonDeco shrinkText myTheme $ avoidStruts myLayout
            , layoutHook = avoidStruts myLayout
            , manageHook = manageDocks <+> myManageHook
            , handleEventHook = myEventHook
            , logHook = dzenLogHook dzenLeftBar >> fadeInactiveLogHook 0xaaaaaaaa
            , startupHook        = myStartupHook
       }


-- window decorations
minimizeButtonOffset :: Int
minimizeButtonOffset = 48

maximizeButtonOffset :: Int
maximizeButtonOffset = 25

closeButtonOffset :: Int
closeButtonOffset = 10

buttonSize :: Int
buttonSize = 10
-- myTheme = (theme deiflTheme) {
myTheme = defaultTheme {
    activeColor = "#49b3d7"
  , inactiveColor = "#222222"
  , urgentColor = "#e13f89"
  , activeBorderColor = myFocusedBorderColor
  , inactiveBorderColor = myNormalBorderColor
  , activeTextColor = "#222222"
  , inactiveTextColor = "#b1aead"
  , urgentTextColor = "#222222"
  , fontName = "xft:consolas:size=8:antialias=true"
  , decoHeight = 16
  , windowTitleAddons = [ (" (M)", AlignLeft)
        , ("_"   , AlignRightOffset minimizeButtonOffset)
        , ("[]"  , AlignRightOffset maximizeButtonOffset)
        , ("X"   , AlignRightOffset closeButtonOffset)
        ]
}
