<#
.SYNOPSIS
    Performs basic checks for an Active Directory lab.
.DESCRIPTION
    Run on the domain controller or a system with the relevant management tools.
    Review output before sharing it publicly because it may include lab details.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

Write-Host "=== Computer ===" -ForegroundColor Cyan
hostname

Write-Host "`n=== IP configuration ===" -ForegroundColor Cyan
ipconfig /all

Write-Host "`n=== Domain controller discovery ===" -ForegroundColor Cyan
try {
    Import-Module ActiveDirectory -ErrorAction Stop
    $domain = Get-ADDomain
    Write-Host "Domain DNS root: $($domain.DNSRoot)"
    Write-Host "Domain NetBIOS name: $($domain.NetBIOSName)"
    nltest "/dsgetdc:$($domain.DNSRoot)"
}
catch {
    Write-Warning "Could not query AD domain details. Confirm the AD module is installed and this machine can contact the domain. $($_.Exception.Message)"
}

Write-Host "`n=== DNS lookup ===" -ForegroundColor Cyan
try {
    if ($domain -and $domain.DNSRoot) {
        Resolve-DnsName $domain.DNSRoot -ErrorAction Stop
    }
    else {
        Write-Warning "Domain name unavailable; run Resolve-DnsName manually with your lab domain."
    }
}
catch {
    Write-Warning "DNS lookup failed: $($_.Exception.Message)"
}
