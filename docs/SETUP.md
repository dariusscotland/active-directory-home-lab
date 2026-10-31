# Active Directory Home Lab Setup Guide

## Project Overview

This project documents the creation of a basic Active Directory home lab using Oracle VirtualBox and Windows Server 2019.

The environment consists of a Windows Server 2019 domain controller and a Windows 10 Pro client workstation connected through an isolated internal virtual network.

The lab was built by following Josh Madakor's Active Directory home lab tutorial.

### Lab Environment Summary

| Component | Configuration |
|---|---|
| Hypervisor | Oracle VirtualBox |
| Domain Controller | Windows Server 2019 Standard Evaluation |
| Client Workstation | Windows 10 Pro |
| Active Directory Domain | mydomain.com |
| NetBIOS Domain | MYDOMAIN |
| Internal Network | intnet |
| Internal Subnet | 172.16.0.0/24 |
| Domain Controller | DC |
| Client Workstation | CLIENT1 |

---

## 1. Host and Virtualization Preparation

Oracle VirtualBox and its Extension Pack were installed on the host computer.

Hardware virtualization was enabled, allowing the creation and operation of virtual machines.

VirtualBox was used to create an isolated lab environment containing a domain controller and a Windows client.

## 2. Domain Controller Virtual Machine

A virtual machine named `DC` was created to host Active Directory Domain Services, DNS, DHCP and routing services.

| Configuration | Value |
|---|---|
| VM Name | DC |
| Operating System | Windows Server 2019 Standard Evaluation |
| Installation Mode | Desktop Experience |
| Memory | 2 GB |
| Virtual Processors | 4 |
| Virtual Disk | 40 GB |
| Disk Allocation | Dynamically allocated |
| Guest Additions | Installed |

### Windows Server Installation

- Windows Server 2019 Standard Evaluation was installed.
- Desktop Experience was selected.
- Custom installation was completed.
- Initial Administrator login was successful.
- VirtualBox Guest Additions were installed.

### VirtualBox Guest Additions

Guest Additions were installed to provide:

- Improved mouse integration.
- Automatic display resizing.
- Shared clipboard functionality.

## 3. Domain Controller Network Configuration

Two network adapters were configured on the domain controller to provide internet access and a separate private lab network.

| Adapter | VirtualBox Network | IP Address |
|---|---|---|
| INTERNET | NAT | 10.0.2.15 |
| INTERNAL | Internal Network | 172.16.0.1 |

### Internal Network Configuration

| Setting | Value |
|---|---|
| IP Address | 172.16.0.1 |
| Subnet Mask | 255.255.255.0 |
| Default Gateway | None |
| Preferred DNS Server | 127.0.0.1 |

The internal network adapter uses a static IP address so that the domain controller can provide DNS and DHCP services to the client workstation.

### Domain Controller Hostname

The original server hostname was changed to `DC`.

- New hostname: DC
- Computer restart: Completed
- Hostname verification: Successful

## 4. Active Directory Domain Services Installation

The Active Directory Domain Services role was installed using Server Manager.

| Component | Result |
|---|---|
| Server | DC |
| Role | Active Directory Domain Services |
| Installation | Successful |
| Domain Controller Promotion | Successful |

### Domain Controller Promotion

The server was promoted to a new forest with the domain name `mydomain.com`.

#### Active Directory Forest Configuration

| Configuration | Value |
|---|---|
| Domain Controller | DC |
| Forest Root Domain | mydomain.com |
| NetBIOS Domain | MYDOMAIN |
| Forest Functional Level | Windows Server 2016 |
| Domain Functional Level | Windows Server 2016 |
| DNS Server | Enabled |
| Global Catalog | Enabled |
| Read-Only Domain Controller | Disabled |

### Promotion Verification

- AD DS role installation: Successful.
- New forest creation: Successful.
- Domain controller promotion: Successful.
- Domain Administrator login: Successful.

### Active Directory Organizational Units

The following organizational units were created:

| OU Name | Purpose |
|---|---|
| `_ADMINS` | Stores dedicated administrative accounts |
| `_USERS` | Stores generated employee accounts |

### Dedicated Domain Administrator Account

A separate domain administrator account was created inside the `_ADMINS` OU.

| Configuration | Result |
|---|---|
| Account Type | Dedicated domain administrator |
| Organizational Unit | `_ADMINS` |
| Security Group | Domain Admins |
| Account Creation | Successful |
| Group Membership | Verified |
| Domain Login | Successful |

The account was used to verify administrative access to the domain.

## 5. Routing and Remote Access Installation

The Remote Access role was installed through Server Manager.

| Component | Status |
|---|---|
| Remote Access Role | Installed |
| DirectAccess and VPN (RAS) | Installed |
| Routing | Installed |
| Web Application Proxy | Not installed |

### RRAS and NAT Configuration

Routing and Remote Access (RRAS) was configured to provide Network Address Translation (NAT) for the internal lab network.

| Component | Configuration |
|---|---|
| RRAS Server | DC |
| RRAS Status | Running |
| NAT | Enabled |
| Public Interface | INTERNET |
| Public Interface IP | 10.0.2.15 |
| Internal Interface | INTERNAL |
| Internal Interface IP | 172.16.0.1 |
| Private Network | intnet |

The INTERNET interface provides the outbound connection, while the INTERNAL interface connects to the private lab network.

## 6. DHCP Server Configuration

The DHCP Server role was installed and configured on the domain controller.

The server was authorized in Active Directory, and a DHCP scope was created for the internal network.

### DHCP Scope Configuration

| Setting | Configuration |
|---|---|
| DHCP Server | DC.mydomain.com |
| Authorization | Authorized in Active Directory |
| Scope Name | 172.16.0.100-200 |
| Network | 172.16.0.0/24 |
| Start IP Address | 172.16.0.100 |
| End IP Address | 172.16.0.200 |
| Subnet Mask | 255.255.255.0 |
| Exclusions | None |
| Lease Duration | 8 days |
| Default Gateway | 172.16.0.1 |
| DNS Server | 172.16.0.1 |
| DNS Domain Name | mydomain.com |
| Scope Status | Active |

### DHCP Configuration Notes

- The DHCP scope provides addresses to devices on the internal network.
- The internal network interface uses 172.16.0.1.
- DHCP options provide clients with the correct default gateway and DNS server.
- The DHCP server was authorized in Active Directory.
- DHCP interface bindings were checked to verify the intended network interface configuration.

## 7. Internet Explorer Enhanced Security Configuration

Internet Explorer Enhanced Security Configuration (IE ESC) was disabled on the Windows Server 2019 domain controller to simplify browser access during the lab setup.

| Setting | Configuration |
|---|---|
| Administrators | Off |
| Users | Off |

**Note:** This setting was changed for lab convenience. Disabling IE ESC reduces browser security protections and is not recommended as a general security practice.

## 8. Bulk Active Directory User Creation

A PowerShell script from Josh Madakor's AD_PS repository was used to generate employee accounts in Active Directory.

The script used was `1_CREATE_USERS.ps1`, with names supplied through `names.txt`.

### User Creation Results

| Setting | Configuration |
|---|---|
| Script | 1_CREATE_USERS.ps1 |
| Names File | names.txt |
| Input Entries | 1,002 |
| Unique Usernames | 1,000 |
| Accounts Created | 1,000 |
| Organizational Unit | `_USERS` |
| Account Status | Enabled |

### User Creation Notes

- The `names.txt` file was updated with an additional name before execution.
- The PowerShell script generated usernames using the supplied names.
- Two usernames appeared twice: `smolder` and `trollins`.
- The duplicate usernames account for the difference between the number of input entries and unique accounts.
- A total of 1,000 accounts were verified in the `_USERS` OU.
- Sample accounts were checked and confirmed to be enabled.

The script used a common lab password for the generated accounts. The password is intentionally not recorded in this repository.

## 9. Windows 10 Client Configuration

A Windows 10 Pro virtual machine was created in Oracle VirtualBox to act as a domain client.

### Client Virtual Machine Configuration

| Setting | Configuration |
|---|---|
| Virtual Machine Name | CLIENT1 |
| Operating System | Windows 10 Pro |
| RAM | 4 GB |
| Processors | 2 |
| Network Adapter | Internal Network |
| Internal Network Name | intnet |
| Adapter 2 | Disabled |
| IP Configuration | DHCP |
| Computer Name | CLIENT1 |
| Active Directory Domain | mydomain.com |

Shared Clipboard and Drag and Drop were both configured as Bidirectional.

### Client Network Configuration

CLIENT1 was connected to the same internal network as the domain controller.

The workstation successfully received its network configuration from the DHCP server.

| Setting | Configuration |
|---|---|
| IP Address | Assigned through DHCP |
| Subnet Mask | 255.255.255.0 |
| Default Gateway | 172.16.0.1 |
| DNS Server | 172.16.0.1 |
| DNS Domain | mydomain.com |

### Connectivity Verification

The following connectivity checks were successfully completed:

- DHCP successfully assigned an IP address to CLIENT1.
- `ping google.com` successfully tested internet connectivity and DNS resolution.
- `ping mydomain.com` successfully tested domain name resolution and connectivity.
- CLIENT1 appeared in the DHCP Address Leases list.
- CLIENT1 appeared in the Active Directory Computers container.

### Domain Join

CLIENT1 was successfully joined to the `mydomain.com` Active Directory domain.

The workstation was restarted after the domain join and accessed using domain credentials.

### Employee Account Authentication

A generated employee account was used to sign in to CLIENT1.

- Domain authentication: Successful.
- User profile creation: Successful.
- `whoami` verification: Successful.

This confirmed that generated Active Directory employee accounts could authenticate on the domain-joined Windows 10 workstation.

---

## 10. Final Lab Configuration

The completed environment contains the following components:

| Component | Status |
|---|---|
| Windows Server 2019 Domain Controller | Complete |
| Active Directory Domain Services | Complete |
| Dedicated Domain Administrator Account | Verified |
| Active Directory Organizational Units | Created |
| RRAS and NAT | Running |
| DHCP Server | Configured and Verified |
| DNS | Configured and Verified |
| 1,000 Active Directory Employee Accounts | Created and Verified |
| Windows 10 Pro Client | Installed |
| CLIENT1 Domain Join | Successful |
| Employee Account Authentication | Successful |

### Project Notes

- This lab was created for learning and experimentation.
- The configuration is intended for an isolated virtual environment, not production deployment.
- Screenshots are stored in the project's `screenshots/` directory.
- Credentials, passwords, virtual machine disks and other sensitive files must not be committed to the public repository.
- Personal usernames and other identifying information should be redacted from public screenshots and documentation.