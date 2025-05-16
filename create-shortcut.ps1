$WshShell = New-Object -ComObject WScript.Shell
$CurrentDir = Split-Path $MyInvocation.MyCommand.Path
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\BalanceFlow.lnk")
$Shortcut.TargetPath = "$CurrentDir\start-balanceflow.bat"
$Shortcut.WorkingDirectory = "$CurrentDir"
$Shortcut.IconLocation = "$CurrentDir\src\main\resources\images\app-icon.ico,0"
$Shortcut.Description = "BalanceFlow - Persönliches Finanzmanagement"
$Shortcut.Save()
