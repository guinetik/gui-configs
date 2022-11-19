<#
.SYNOPSIS
    Installs common software using chocolatey
#>
#Requires -RunAsAdministrator
# ENTRY POINT MAIN()
Param(
    [Alias("a")]
    [Parameter(Mandatory = $false)]
    [bool] $installAll = $false,
    [Alias("s")]
    [Parameter(Mandatory = $false)]
    [bool] $skipCheck = $false,
    [Alias("p")]
    [Parameter(Mandatory=$false)]
    [String] $packageFile = "packages.txt"
)
function Install-Robot() {
    $ChocoInstalled = $false
    ## Check if chocolatey is installed
    if(!$skipCheck) {
        Write-ColorOutput blue "Checking if chocolatey is installed...";
        $ChocoInstalled = $false
        if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
            $ChocoInstalled = $true
        }
        else {
            $choice = Get-SelectionFromUser -Options @('Install', 'Skip') -Prompt $Prompt
            if ($choice -eq 'Install') {
                try {
                    Write-ColorOutput cyan "Installing Installing Chocolatey";
                    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
                    $ChocoInstalled = true;
                }
                catch {
                    LogCodeAndExit "Error installing Chocolatey" $_
                }
            }
        }
    } else {
        Write-ColorOutput green "Skipping chocolatey check...";
        $ChocoInstalled = $true
    }
    ## If choco is installed, read the packages file and install the packages
    if ($ChocoInstalled) {
        ##
        Write-ColorOutput blue "Reading packages from file...";
        $packages = (Get-Content $packageFile) -notmatch '^\s*$' -notmatch '^#' | Where-Object { $_.trim() -ne "" }
        ##
        Write-ColorOutput Yellow $packages
        Write-ColorOutput cyan "Chocolatey installed. Proceeding...";
        ##
        #loop through the packages, running install safe for each of them
        foreach ($package in $packages) {
            $Prompt = "Install $package ?"
            if (!$installAll) {
                $choice = Get-SelectionFromUser -Options @('Install', 'Skip') -Prompt $Prompt
                if ($choice -eq 'Install') {
                    Install-Safe($package);
                }
            }
            else {
                Install-Safe($package);
            }
        }
    }
    else {
        Write-ColorOutput red "Chocolatey not installed. Skipping..."
    }
}

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
function Invoke-Choco($package) {
    choco.exe install -y -r $package
    if ($LASTEXITCODE -ne 0) {
        throw "Error installing: $package";
    }
}
function Install-Safe($package) {
    try {
        Write-ColorOutput cyan "Installing $package"
        Invoke-Choco($package);
    }
    catch {
        Write-ColorOutput red $_
    }
}
function Get-SelectionFromUser {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$Options,
        [Parameter(Mandatory = $true)]
        [string]$Prompt        
    )
    
    [int]$Response = 0;
    [bool]$ValidResponse = $false    

    while (!($ValidResponse)) {            
        [int]$OptionNo = 0

        Write-Host $Prompt -ForegroundColor DarkYellow
        Write-Host "[0]: Cancel"

        foreach ($Option in $Options) {
            $OptionNo += 1
            Write-Host ("[$OptionNo]: {0}" -f $Option)
        }

        if ([Int]::TryParse((Read-Host), [ref]$Response)) {
            if ($Response -eq 0) {
                # if cancel return with code zero
                exit 0
            }
            elseif ($Response -le $OptionNo) {
                $ValidResponse = $true
            }
        }
    }

    return $Options.Get($Response - 1)
}
function LogCodeAndExit($message, $exception) {
    Write-ColorOutput red $message
    Write-ColorOutput red $exception
    ExitWithCode 666
}
Install-Robot;
Write-ColorOutput cyan "Done! I'm outta here!"