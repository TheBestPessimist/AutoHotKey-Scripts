; WinTitle reference: https://autohotkey.com/docs/misc/WinTitle.htm#multi
global ahk_firefox := "ahk_class MozillaWindowClass"
global ahk_chrome := "ahk_class Chrome_WidgetWin_1"
global ahk_sublime := "ahk_exe sublime_text.exe"
global ahk_telegram := "ahk_exe telegram.exe ahk_class Qt5QWindowIcon"
global ahk_tf2 := "ahk_exe hl2.exe"
global ahk_teamviewer_sponsoredsession := "Sponsored session ahk_exe TeamViewer.exe"
global ahk_teamviewer := "TeamViewer ahk_exe TeamViewer.exe"
global ahk_Skype := "ahk_exe Skype.exe"


SetTimer, hideTeamviewerSponsoredsession, 5000







; 2018.09.07: no need for this as sublime text is licensed now!
; SetTimer, hideSublimeRegister, 1000
