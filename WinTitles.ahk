; WinTitle reference: https://autohotkey.com/docs/misc/WinTitle.htm#multi
class WinTitles
{
    static ModernApp := "ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe"

    static ModernSkype := [WinTitles.ModernApp, "Skype"]
    static ModernPhotos := [WinTitles.ModernApp, "Photos"]
    static ModernMediaPlayer := [WinTitles.ModernApp, "Media Player"]
    static ModernDolbyAccess := [WinTitles.ModernApp, "Dolby Access"]
    static Vlc := "ahk_exe vlc.exe"
    static IntellijIdea := "ahk_exe idea64.exe"
    static CorsairCUE := "ahk_class CUEBorderlessWindow ahk_exe iCUE.exe"
    static BattleNet := "ahk_exe Battle.net.exe"
    static Firefox := "ahk_class MozillaWindowClass"
    static Chrome := "ahk_class Chrome_WidgetWin_1"
    static Skype := "ahk_exe Skype.exe"
    static TeamViewerSponsoredSession := "Sponsored session ahk_exe TeamViewer.exe"
    static TeamViewer := "TeamViewer ahk_exe TeamViewer.exe"
    static ACDSee := "ahk_exe ACDSeeProfessional2018.exe"
    static Feces := "ahk_exe Teams.exe"
    static Telegram := "ahk_exe telegram.exe"
    static SublimeText := "ahk_exe sublime_text.exe"
    static tf2 := "ahk_exe hl2.exe"
    static windowsCredentials := "Windows Security"
    static FlowLauncher := "ahk_exe Flow.Launcher.exe"
    static ArmouryCrate := "ARMOURY CRATE ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe"
    static Obsidian := "ahk_exe Obsidian.exe"
    static BeatSlayer := "ahk_exe BeatSlayer.exe"
    static Bitwarden := "ahk_exe Bitwarden.exe"
}

class Paths {
    static FlowLauncher := "D:\all\all\FlowLauncher\Flow.Launcher.exe"
}

class Process {
     static FlowLauncher := "Flow.Launcher.exe"
}
