<#
.SYNOPSIS
Boostraps a dev system

.DESCRIPTION
Installs chocolatey, msys2 and bash.

.EXAMPLE
just run this file on powershell

.NOTES
General notes
#>
function install() {
    Write-ColorOutput cyan ">>"
    Write-ColorOutput cyan "Boostrapping system..."
    #
    #Set-ExecutionPolicy Bypass -Scope Process #uncomment this to activate bypass mode in PS
    ##
    if (Get-Command choco -errorAction SilentlyContinue) {
        Write-ColorOutput cyan "Chocolatey is Instaled >> Proceeding..."
    }
    ##
    else {
        try {
            Write-ColorOutput cyan "Installing Installing Chocolatey";
            Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
        } catch {
            LogCodeAndExit "Error installing mysys2 Chocolatey" $_
        }
    }
    ##
    if (Get-Command msys2 -errorAction SilentlyContinue) {
        Write-ColorOutput cyan "msys2 is Instaled >> Proceeding..."
    }
    else {
        try {
            Write-ColorOutput cyan "Installing msys2";
            choco.exe install msys2;
        } catch {
            LogCodeAndExit "Error installing mysys2" $_
        }
    }
    #
    if (Get-Command winget -errorAction SilentlyContinue) {
        Write-ColorOutput cyan "winget is installed >> Proceeding...";
    } else {
        try {
            Write-ColorOutput cyan "Installing winget";
            $WebClient = New-Object System.Net.WebClient
            $WebClient.DownloadFile("https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle","C:\temp\winget.msixbundle")
            Add-AppPackage -path "C:\temp\winget.msixbundle"
        } catch {
            LogCodeAndExit "Error installing winget" $_
        } finally {
            Remove-Item "C:\temp\winget.msixbundle"
        }
    }
    #
    if (Get-Command oh-my-posh -errorAction SilentlyContinue) {
        try {
            Write-ColorOutput cyan "oh-my-posh is installed >> Proceeding...";
            winget upgrade JanDeDobbeleer.OhMyPosh -s winget
        } catch {
            LogCodeAndExit "Error installing oh-my-posh!" $_
        }
    }
    else {
        try {
            Write-ColorOutput cyan "Installing oh-my-posh...";
            winget install JanDeDobbeleer.OhMyPosh -s winget --VERSION 8.7.0
        } catch {
            LogCodeAndExit "Error installing oh-my-posh!" $_
        }
    }
    ##
    Write-ColorOutput cyan "Customizing powershell profile...";
    try {
        $theme = "$PSScriptRoot\oh-my-posh.json"
        "oh-my-posh init pwsh --config $theme | Invoke-Expression" | Out-File $PROFILE
        Write-ColorOutput cyan ">> Init oh-my-posh";
        #oh-my-posh init pwsh --config "$theme" | Invoke-Expression
    } catch {
        LogCodeAndExit "Error on init oh-my-posh!" $_
    }
    ##
    Write-ColorOutput cyan "Installing zsh..."
    try {
        ./install-zsh.cmd
    } catch {
        LogCodeAndExit "Error installing zsh" $_
    }
    Write-ColorOutput cyan ">>"
    Write-ColorOutput cyan "Instalation complete! Enjoy your system!"
    Write-ColorOutput cyan ">>"
}
##

function ExitWithCode($exitcode) {
  $host.SetShouldExit($exitcode)
  exit $exitcode
}

function LogCodeAndExit($message, $exception) {
    Write-ColorOutput red $message
    Write-ColorOutput red $exception
    ExitWithCode 666
}

##
function Write-ColorOutput($ForegroundColor) {
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = $ForegroundColor

    # output
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }

    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}

install;