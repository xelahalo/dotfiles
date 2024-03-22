param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

'running with full privileges'

# Download Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# check that chocolatey is installed
choco -?
choco install spotify discord firefox microsoft-edge 1password 1password-cli obsidian docker-desktop postman wezterm vscode powertoys wsl gimp git nodejs windirstat -y --ignore-checksum

# setup wsl
wsl --set-default-version 2
wsl -s Ubuntu

# symlink configs
cmd /c mklink /d "$env:USERPROFILE\.config\wezterm" "$env:USERPROFILE\dotfiles\config\wezterm"
