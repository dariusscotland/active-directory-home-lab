# Active Directory Home Lab Testing and Verification

## Project Overview

This document records the testing and verification performed during the creation of the Active Directory home lab.

The tests cover the domain controller, Active Directory, DHCP, generated employee accounts, network connectivity, domain membership and user authentication.

Only tests that were actually performed are recorded as passed.

---

## 1. Domain Controller Verification

**Test Date:** October 29, 2026

The following PowerShell commands were used to verify the domain controller configuration.

### 1.1 Verify User Identity

```powershell
whoami
```

**Expected Result:**

```text
mydomain\administrator
```

**Observed Result:** Domain Administrator identity displayed successfully.

**Status:** PASSED

### 1.2 Verify Computer Name

```powershell
hostname
```

**Expected Result:**

```text
DC
```

**Observed Result:** DC

**Status:** PASSED

### 1.3 Verify Active Directory Domain

```powershell
Get-ADDomain
```

**Expected Result:**
- Domain: mydomain.com
- NetBIOS Name: MYDOMAIN
- Domain Mode: Windows Server 2016

**Observed Result:** Domain information returned successfully.

**Status:** PASSED

### 1.4 Verify Active Directory Forest

```powershell
Get-ADForest
```

**Expected Result:**
- Forest Root Domain: mydomain.com
- Forest Mode: Windows Server 2016

**Observed Result:** Forest information returned successfully.

**Status:** PASSED

### Domain Controller Verification Summary

| Test | Result |
|---|---|
| User Identity | PASSED |
| Computer Name | PASSED |
| Active Directory Domain | PASSED |
| Active Directory Forest | PASSED |

All four verification tests completed successfully.

The server successfully operates as a domain controller for the mydomain.com Active Directory forest.

---

## 2. Dedicated Domain Administrator Verification

A dedicated administrative account was created inside the `_ADMINS` organizational unit.

The following checks were performed to verify the account.

### 2.1 Verify Domain Login

```powershell
whoami
```

**Expected Result:** The dedicated administrative account is displayed with the MYDOMAIN domain prefix.

**Observed Result:** Successful domain authentication.

**Status:** PASSED

### 2.2 Verify Domain Administrator Group Membership

```powershell
whoami /groups
```

**Expected Result:** The Domain Admins security group appears in the account's group membership.

**Observed Result:** Domain Admins membership confirmed.

**Status:** PASSED

### Dedicated Administrator Verification Summary

| Test | Result |
|---|---|
| Domain Login | PASSED |
| Domain Admins Membership | PASSED |
| Administrative Account Login | PASSED |

The dedicated domain administrator account successfully authenticated and had the expected Domain Admins membership.

---

## 3. DHCP Server Verification

The DHCP Server was configured on the domain controller to provide IP addresses to devices connected to the internal network.

### 3.1 Verify DHCP Server Authorization

```powershell
Get-DhcpServerInDC
```

**Expected Result:** The domain controller appears as an authorized DHCP server in Active Directory.

**Observed Result:** DC.mydomain.com appeared in the authorized server listing.

**Status:** PASSED

### 3.2 Verify DHCP Scope

```powershell
Get-DhcpServerv4Scope
```

**Expected Result:**

| Setting | Expected Value |
|---|---|
| Scope ID | 172.16.0.0 |
| Start Range | 172.16.0.100 |
| End Range | 172.16.0.200 |
| Subnet Mask | 255.255.255.0 |
| State | Active |

**Observed Result:** DHCP scope appeared with an Active state.

**Status:** PASSED

### 3.3 Verify DHCP Options

```powershell
Get-DhcpServerv4OptionValue -ScopeId 172.16.0.0
```

**Expected Configuration:**

| Option | Expected Value |
|---|---|
| Router (003) | 172.16.0.1 |
| DNS Servers (006) | 172.16.0.1 |
| DNS Domain Name (015) | mydomain.com |

**Observed Result:** DHCP options were verified successfully.

**Status:** PASSED

### 3.4 Verify DHCP Interface Bindings

```powershell
Get-DhcpServerv4Binding
```

**Expected Configuration:**

| Interface | Expected State |
|---|---|
| INTERNAL | Enabled |
| INTERNET | Disabled |

**Observed Result:** DHCP interface bindings were checked and confirmed.

**Status:** PASSED

### DHCP Server Verification Summary

| Test | Result |
|---|---|
| DHCP Authorization | PASSED |
| DHCP Scope | PASSED |
| DHCP Options | PASSED |
| DHCP Interface Bindings | PASSED |

---

## 4. Bulk Active Directory User Verification

A PowerShell script was used to generate employee accounts in Active Directory.

The script used was `1_CREATE_USERS.ps1`, with names supplied through `names.txt`.

### 4.1 Verify Account Count

```powershell
Get-ADUser -SearchBase "OU=_USERS,DC=mydomain,DC=com" -Filter * |
Measure-Object
```

**Expected Result:** 1,000 accounts.

**Observed Result:** 1,000 accounts returned.

**Status:** PASSED

### 4.2 Verify Sample Accounts

```powershell
Get-ADUser -SearchBase "OU=_USERS,DC=mydomain,DC=com" -Filter * |
Select-Object Name, SamAccountName, Enabled |
Select-Object -First 10
```

**Expected Result:** Sample employee accounts display `Enabled = True`.

**Observed Result:** Sample accounts displayed `Enabled = True`.

**Status:** PASSED

### 4.3 Investigate Duplicate Usernames

The names.txt file contained 1,002 entries.

A PowerShell check was used to identify duplicate usernames generated from the names.

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

**Observed Result:**

| Duplicate Username | Occurrences |
|---|---:|
| smolder | 2 |
| trollins | 2 |

Two duplicate usernames were identified, explaining the difference between the 1,002 input entries and the 1,000 unique usernames.

### Bulk User Verification Summary

| Test | Result |
|---|---|
| Account Count | PASSED |
| Sample Account Verification | PASSED |
| Duplicate Username Investigation | COMPLETED |
| Total Accounts Verified | 1,000 |

---

## 5. Windows 10 Client Network Verification

The Windows 10 Pro client workstation, CLIENT1, was connected to the internal network.

The following tests were performed to verify network configuration and connectivity.

### 5.1 Verify IP Configuration

```cmd
ipconfig
```

**Expected Configuration:**

| Setting | Expected Value |
|---|---|
| IPv4 Address | Within 172.16.0.100–172.16.0.200 |
| Subnet Mask | 255.255.255.0 |
| Default Gateway | 172.16.0.1 |

**Observed Result:** CLIENT1 received the expected IP configuration from the DHCP server.

**Status:** PASSED

### 5.2 Verify Internet Connectivity

```cmd
ping google.com
```

**Expected Result:** Successful replies from google.com.

**Observed Result:** Ping requests completed successfully.

This verified internet connectivity and DNS resolution from CLIENT1.

**Status:** PASSED

### 5.3 Verify Domain Connectivity

```cmd
ping mydomain.com
```

**Expected Result:** The domain name resolves and responds successfully.

**Observed Result:** Successful ping replies.

This verified domain name resolution and connectivity from CLIENT1.

**Status:** PASSED

---

## 6. Windows 10 Domain Membership Verification

CLIENT1 was successfully joined to the mydomain.com Active Directory domain.

### 6.1 Verify Domain Membership

```cmd
systeminfo | findstr /B /C:"Domain"
```

**Expected Result:**

```text
Domain: mydomain.com
```

**Observed Result:** mydomain.com

**Status:** PASSED

### 6.2 Verify Computer Account in Active Directory

The Active Directory Users and Computers console was opened on the domain controller.

Navigation:

`mydomain.com → Computers`

**Expected Result:** A computer object named CLIENT1 appears in the Computers container.

**Observed Result:** CLIENT1 appeared in the Computers container.

**Status:** PASSED

### 6.3 Verify DHCP Lease Assignment

The DHCP management console was opened on the domain controller.

Navigation:

`DC.mydomain.com → IPv4 → Scope → Address Leases`

**Expected Result:** CLIENT1 appears in the DHCP Address Leases list.

**Observed Result:** CLIENT1 appeared in the Address Leases list.

**Status:** PASSED

---

## 7. Employee Account Authentication Verification

A generated employee account was used to sign in to the Windows 10 CLIENT1 workstation.

### 7.1 Verify Employee Account Login

**Expected Result:** Windows successfully authenticates the domain account and loads the user profile.

**Observed Result:** Employee account login successful.

**Status:** PASSED

### 7.2 Verify Logged-On Identity

```cmd
whoami
```

**Expected Result:** The authenticated account is displayed with the MYDOMAIN domain prefix.

**Observed Result:** Domain-qualified employee account displayed successfully.

**Status:** PASSED

---

## 8. Overall Testing Summary

The following table summarizes the completed lab verification.

| Component | Verification | Result |
|---|---|---|
| Domain Controller | Hostname and identity | PASSED |
| Active Directory | Domain information | PASSED |
| Active Directory | Forest information | PASSED |
| Domain Administration | Dedicated administrator login | PASSED |
| Domain Administration | Domain Admins membership | PASSED |
| DHCP | Server authorization | PASSED |
| DHCP | Scope configuration | PASSED |
| DHCP | DHCP options | PASSED |
| DHCP | Interface bindings | PASSED |
| Active Directory Users | 1,000 accounts verified | PASSED |
| Active Directory Users | Sample accounts enabled | PASSED |
| CLIENT1 | DHCP address assignment | PASSED |
| CLIENT1 | Internet connectivity | PASSED |
| CLIENT1 | Domain connectivity | PASSED |
| CLIENT1 | Domain membership | PASSED |
| CLIENT1 | Computer account in Active Directory | PASSED |
| CLIENT1 | Employee account authentication | PASSED |

### Final Result

The Active Directory home lab was successfully configured and tested.

The Windows Server 2019 domain controller provides Active Directory Domain Services, DNS, DHCP and NAT for the internal virtual network.

The Windows 10 Pro client successfully obtained its network configuration, accessed the internet, resolved the Active Directory domain, joined the domain and authenticated using a generated employee account.

The completed lab demonstrates basic Active Directory administration, Windows Server configuration, DHCP, DNS, network connectivity, domain joining and user authentication.

---

## 9. Evidence and Screenshots

Screenshots and supporting evidence are maintained in the project's `screenshots/` directory.

Evidence should include, where captured:

- Domain controller network configuration.
- Active Directory domain and forest verification.
- Dedicated administrator group membership.
- RRAS and NAT configuration.
- DHCP scope and configuration verification.
- PowerShell bulk user creation.
- Active Directory generated employee accounts.
- CLIENT1 IP configuration.
- CLIENT1 internet and domain connectivity.
- DHCP lease assigned to CLIENT1.
- CLIENT1 computer object in Active Directory.
- Successful employee account login.

Only screenshots actually captured should be included in the repository.

Personal usernames, passwords, credentials and other sensitive information should be redacted before publication.

Never commit passwords, exported credentials or virtual machine disk files.