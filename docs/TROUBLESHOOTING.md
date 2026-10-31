# Troubleshooting and Lessons Learned

## Overview

This document records issues, unexpected behavior, troubleshooting steps and resolutions encountered while building the Active Directory home lab.

The purpose is to document the actual problems experienced during implementation, explain how they were investigated, and record what was learned.

The lab was built using Oracle VirtualBox, Windows Server 2019, Active Directory Domain Services, DHCP, DNS, RRAS/NAT and a Windows 10 Pro client.

---

## 1. Windows 10 ISO Download Redirect

### Issue

While attempting to download the Windows 10 ISO directly from Microsoft's website, the browser repeatedly redirected to the general Windows 10 download page.

The expected ISO edition selection option was not available.

### Investigation

The direct ISO download page was opened multiple times, but the browser continued redirecting to the general Windows 10 update/download page.

### Resolution

Microsoft's Media Creation Tool was used instead.

The following process was completed:

1. Opened Microsoft's official Windows 10 download page.
2. Downloaded the Media Creation Tool.
3. Selected Create installation media for another PC.
4. Selected the appropriate language and 64-bit architecture.
5. Selected ISO file as the installation media.
6. Saved the generated ISO file for use in VirtualBox.

### Verification

The resulting ISO was successfully attached to the CLIENT1 virtual machine and used to install Windows 10 Pro.

**Status:** RESOLVED

### Lesson Learned

When Microsoft's direct ISO selection page is unavailable or redirects unexpectedly, the official Media Creation Tool provides an alternative method of obtaining installation media.

---

## 2. PowerShell User Creation Script Selection

### Issue

The GitHub script initially provided was:

`Generate-Names-Create-Users.ps1`

However, the tutorial's user creation stage uses a different script named:

`1_CREATE_USERS.ps1`

There was uncertainty about which script should be used to reproduce the tutorial.

### Investigation

The contents of Josh Madakor's AD_PS repository and the tutorial's accompanying files were reviewed.

The tutorial's process involved using:

- `1_CREATE_USERS.ps1`
- `names.txt`

The names file was also intended to include an additional personal name before execution.

### Resolution

The correct tutorial files were downloaded from the AD_PS repository.

The ZIP archive was extracted, and `names.txt` was updated before opening `1_CREATE_USERS.ps1` in PowerShell ISE as Administrator.

The execution policy was set to Unrestricted for the current PowerShell process:

```powershell
Set-ExecutionPolicy Unrestricted -Scope Process
```

The working directory was set to the extracted folder containing the script and names file before execution.

### Verification

The script completed successfully.

A total of 1,000 Active Directory accounts were subsequently verified in the `_USERS` organizational unit.

**Status:** RESOLVED

### Lesson Learned

When following a tutorial, verify that the script being used matches the actual tutorial workflow. A repository can contain multiple scripts with different purposes and configurations.

---

## 3. Difference Between Input Names and Created User Accounts

### Issue

The `names.txt` file contained 1,002 entries, but the PowerShell script resulted in 1,000 Active Directory accounts.

The difference needed to be investigated.

### Investigation

The number of entries in the names file was checked:

```powershell
(Get-Content .\names.txt).Count
```

Result:

```text
1002
```

The number of generated Active Directory accounts was checked:

```powershell
Get-ADUser -SearchBase "OU=_USERS,DC=mydomain,DC=com" -Filter * |
Measure-Object
```

Result:

```text
Count : 1000
```

A PowerShell command was then used to identify duplicate usernames generated from the names file.

```powershell
$names = Get-Content .\names.txt

$usernames = foreach ($n in $names) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    "$($first.Substring(0,1))$last"
}

$usernames | Group-Object |
Where-Object Count -gt 1 |
Select-Object Name, Count
```

### Findings

Two duplicate usernames were identified.

| Generated Username | Occurrences |
|---|---:|
| smolder | 2 |
| trollins | 2 |

The duplicate usernames explained why 1,002 input entries resulted in 1,000 unique accounts.

### Resolution

No additional accounts needed to be created.

The existing 1,000 accounts were retained, and sample accounts were checked to confirm that they were enabled.

```powershell
Get-ADUser -SearchBase "OU=_USERS,DC=mydomain,DC=com" -Filter * |
Select-Object Name, SamAccountName, Enabled |
Select-Object -First 10
```

### Verification

- Input entries: 1,002.
- Duplicate usernames identified: 2.
- Unique usernames: 1,000.
- Active Directory accounts created: 1,000.
- Sample account status: Enabled.

**Status:** INVESTIGATED AND VERIFIED

### Lesson Learned

Generated usernames must be unique in Active Directory.

A large input file does not necessarily produce the same number of accounts because different names can generate identical usernames.

PowerShell can be used to identify duplicate values before or after account creation.

---

## 4. Windows 10 Initial Setup and Microsoft Account Prompt

### Issue

During the initial Windows 10 setup, the workstation requested a Microsoft account.

The lab required a temporary local Windows account before joining the Active Directory domain.

### Investigation

The available Windows setup options were reviewed to locate the offline account creation route.

### Resolution

The offline/local account option was selected instead of signing in with a Microsoft account.

A temporary local Windows account named `user` was created.

The workstation completed its initial setup and reached the Windows 10 desktop.

### Verification

CLIENT1 successfully reached the Windows desktop and was ready for network configuration and domain joining.

**Status:** RESOLVED

### Lesson Learned

A Windows workstation can initially use a local account before being joined to an Active Directory domain.

The local account and the later domain account serve different purposes.

---

## 5. DHCP Installation Evidence

### Observation

During DHCP Server role installation, the screenshot showing the initial Server Roles selection was missed.

### Investigation

The role was not reinstalled simply to recreate the missing screenshot.

Instead, subsequent evidence from the completed DHCP configuration was used to document the working DHCP setup.

### Resolution

The existing installation was retained, and the DHCP configuration was verified through the following checks:

- DHCP server authorization.
- DHCP scope creation and activation.
- DHCP options.
- DHCP interface bindings.
- CLIENT1 receiving a DHCP lease.

### Verification

- DHCP server authorization was confirmed.
- The DHCP scope was active.
- DHCP options were checked.
- Interface bindings were checked.
- CLIENT1 successfully received a DHCP lease.

**Status:** VERIFIED THROUGH SUBSEQUENT EVIDENCE

### Lesson Learned

A missed installation screenshot does not require reinstalling a working server role.

Subsequent configuration and verification evidence can document the completed implementation.

---

## 6. Successful Network and Domain Verification

The following stages were completed successfully without requiring troubleshooting changes.

| Component | Verification Result |
|---|---|
| Domain Controller Static IP | Verified |
| DHCP Scope | Active |
| DHCP Options | Verified |
| DHCP Interface Bindings | Verified |
| CLIENT1 DHCP Address | Successful |
| CLIENT1 Internet Connectivity | Successful |
| CLIENT1 Domain Connectivity | Successful |
| CLIENT1 Domain Join | Successful |
| CLIENT1 Computer Object | Present in Active Directory |
| Employee Account Authentication | Successful |

The successful checks are documented in `TESTING.md`.

---

## 7. General Troubleshooting Reference

The following commands are useful when investigating common Active Directory and network issues in this lab.

### Check IP Configuration

```cmd
ipconfig /all
```

Displays IP addresses, subnet masks, default gateways and DNS server configuration.

### Test Network Connectivity

```cmd
ping 172.16.0.1
```

Tests connectivity to the domain controller's internal interface.

### Test Domain Name Resolution

```cmd
nslookup mydomain.com
```

Checks whether the client can resolve the Active Directory domain through DNS.

### Verify Active Directory Domain Information

```powershell
Get-ADDomain
```

Returns information about the current Active Directory domain.

### Verify DHCP Scope

```powershell
Get-DhcpServerv4Scope
```

Displays configured DHCP scopes and their current states.

### Verify DHCP Server Authorization

```powershell
Get-DhcpServerInDC
```

Displays DHCP servers authorized in Active Directory.

### Verify Domain Controller Discovery

```cmd
nltest /dsgetdc:mydomain.com
```

Attempts to locate a domain controller for the specified domain.

These are reference commands. They should only be marked as tested when actually executed and verified.

---

## 8. Troubleshooting Documentation Template

Future problems should be recorded using the following structure.

### Issue Title

**Problem:**

Describe what happened and what was expected.

**Investigation:**

Record the commands, settings or checks used to identify the cause.

**Resolution:**

Explain what was changed or how the problem was resolved.

**Verification:**

Record the actual result after applying the resolution.

**Status:** OPEN / RESOLVED / INVESTIGATED

**Lesson Learned:**

Explain what the issue taught you about the technology or configuration.

---

## Conclusion

Troubleshooting was an important part of building this Active Directory environment.

The project involved identifying the correct tutorial resources, working around the Windows ISO download redirection, investigating duplicate generated usernames and completing Windows workstation setup.

The issues were investigated and documented without unnecessarily rebuilding working components.

This record provides a practical reference for future improvements and demonstrates the importance of testing, verification and accurate technical documentation.