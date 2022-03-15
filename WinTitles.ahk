; WinTitle reference: https://autohotkey.com/docs/misc/WinTitle.htm#multi
class WinTitles
{
    static ModernApp := "ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe"

    static ModernSkype := [WinTitles.ModernApp, "Skype"]
    static ModernPhotos := [WinTitles.ModernApp, "Photos"]
    static Vlc := "ahk_exe vlc.exe"
    static Goland := "ahk_exe goland64.exe"
    static IntellijIdea := "ahk_exe idea64.exe"
    static CorsairCUE := "ahk_class CUEBorderlessWindow ahk_exe iCUE.exe"
    static BattleNet := "ahk_exe Battle.net.exe"
    static Firefox := "ahk_class MozillaWindowClass"
    static Chrome := "ahk_class Chrome_WidgetWin_1"
    static Skype := "ahk_exe Skype.exe"
    static TeamViewerSponsoredSession := "Sponsored session ahk_exe TeamViewer.exe"
    static TeamViewer := "TeamViewer ahk_exe TeamViewer.exe"
    static ACDSee := "ahk_exe ACDSeeProfessional2018.exe"
    static MsTeams := "ahk_exe Teams.exe"
    static Telegram := "ahk_exe telegram.exe ahk_class Qt5153QWindowIcon"
    static SublimeText := "ahk_exe sublime_text.exe"
    static tf2 := "ahk_exe hl2.exe"
}
