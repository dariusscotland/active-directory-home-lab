<#
.SYNOPSIS
    Creates synthetic test users in a dedicated OU in a lab Active Directory domain.

.DESCRIPTION
    Lab-only example. Review the code, create the OU first, and test with a small
    count before creating a larger batch. The password is requested interactively
    and is not stored in this script.

.EXAMPLE
    .\New-LabUsers.ps1 -TargetOU "OU=LabUsers,DC=ad,DC=example,DC=test" -Count 5

.NOTES
    Run only in your own isolated lab with permission to create AD users.
    Requires the ActiveDirectory PowerShell module and appropriate permissions.
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$TargetOU,

    [Parameter()]
    [ValidateRange(1, 1000)]
    [int]$Count = 5,

    [Parameter()]
    [string]$Prefix = "labuser"
)

$ErrorActionPreference = "Stop"

try {
    Import-Module ActiveDirectory -ErrorAction Stop
    $null = Get-ADOrganizationalUnit -Identity $TargetOU -ErrorAction Stop
}
catch {
    Write-Error "Could not load Active Directory tools or find TargetOU '$TargetOU'. Create the OU and check the distinguished name first. Details: $($_.Exception.Message)"
    exit 1
}

$securePassword = Read-Host "Enter a lab-only initial password for the test accounts" -AsSecureString
$created = 0
$skipped = 0

for ($i = 1; $i -le $Count; $i++) {
    $number = "{0:D4}" -f $i
    $sam = "$Prefix$number"
    $upnSuffix = (Get-ADDomain).DNSRoot
    $upn = "$sam@$upnSuffix"
    $displayName = "Lab User $number"

    $existing = Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction Stop
    if ($existing) {
        Write-Host "SKIP: $sam already exists."
        $skipped++
        continue
    }

    $params = @{
        Name                  = $displayName
        GivenName             = "Lab"
        Surname               = "User$number"
        DisplayName           = $displayName
        SamAccountName        = $sam
        UserPrincipalName     = $upn
        Path                  = $TargetOU
        AccountPassword       = $securePassword
        Enabled               = $true
        ChangePasswordAtLogon = $true
    }

    if ($PSCmdlet.ShouldProcess($sam, "Create lab Active Directory user")) {
        New-ADUser @params
        Write-Host "CREATED: $sam ($upn)"
        $created++
    }
}

Write-Host ""
Write-Host "Finished. Created: $created; skipped existing accounts: $skipped."
Write-Host "Verify the accounts in Active Directory Users and Computers before proceeding."
