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
    #Set-ExecutionPolicy Bypass -Scope Process. #uncomment this to activate bypass mode in PS
    ##
    if (Get-Command choco -errorAction SilentlyContinue) {
        Write-ColorOutput cyan "Chocolatey is Instaled >> Proceeding..."
    }
    ##
    else {
        Write-ColorOutput cyan "Installing Installing Chocolatey";
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
    }
    ##
    if (Get-Command msys2 -errorAction SilentlyContinue) {
        Write-ColorOutput cyan "msys2 is Instaled >> Proceeding..."
    }
    else {
        Write-ColorOutput cyan "Installing msys2";
        choco.exe install msys2;
    }
    if (Get-Command oh-my-posh -errorAction SilentlyContinue) {
        Write-ColorOutput cyan "oh-my-posh is installed >> Proceeding...";
        winget upgrade JanDeDobbeleer.OhMyPosh -s winget
    }
    else {
        Write-ColorOutput cyan "Installing oh-my-posh...";
        winget install JanDeDobbeleer.OhMyPosh -s winget
    }
    ##
    Write-ColorOutput cyan "Customizing powershell profile...";
    $theme = "oh-my-posh.json"
#    $theme = "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json"
    "oh-my-posh init pwsh --config $theme | Invoke-Expression" | Out-File $PROFILE
    Write-ColorOutput cyan ">> Init oh-my-posh";
    oh-my-posh init pwsh --config "$theme" | Invoke-Expression
    ##
    Write-ColorOutput cyan "Installing zsh..."
    ./install-zsh.cmd
}
##

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