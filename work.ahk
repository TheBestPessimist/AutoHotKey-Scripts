::.work::{
    Run("D:/all/all/Vivaldi/Application/vivaldi.exe --profile-directory=`"Default`"")
    focusOrOpenApp(WinTitles.Obsidian, Paths.Obsidian)
    Run("C:/Users/" A_UserName "/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/JetBrains Toolbox/JetBrains Toolbox.lnk")
    Run("C:/ProgramData/Microsoft/Windows/Start Menu/Docker Desktop.lnk")
    sleep 4000
    Run("D:/all/all/Vivaldi/Application/vivaldi.exe --profile-directory=`"Profile 1`"")
}
