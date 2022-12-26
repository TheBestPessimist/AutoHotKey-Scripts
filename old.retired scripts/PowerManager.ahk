; Toggle between "Power saver" and "Balanced" powers schemes
TogglePowerScheme()
{
  static SchemeIndex

  AllPowerSchemes := [["Power saver", "a1841308-3541-4fab-bc81-f71556f20b4a"], ["Balanced", "381b4222-f694-41f0-9685-ff5bb260df2e"], ["High performance", "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"]]
  ; ; get the current active power plan
  if (SchemeIndex = "") {
    SchemeIndex := 0
  }

  scheme := AllPowerSchemes[1+SchemeIndex]

  RunWaitCommand("powercfg /setActive " . scheme[2])

  Tippy("Power Plan " . scheme[1], 3000)

  ; ToolTipFM("Power Plan " . scheme[1])
  ; Sleep, 1000
  ; ToolTipFM()

  SchemeIndex := Mod((SchemeIndex + 1), AllPowerSchemes.MaxIndex())
}



; Run a command in cmd and return it's output
RunWaitCommand(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}
