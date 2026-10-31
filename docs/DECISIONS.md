# Lab Design Decisions

This document records the main design and implementation decisions made while building the Active Directory home lab. It explains the configuration choices and provides context for anyone reviewing or reproducing the project.

## 1. Virtualization Platform

**Decision:** Use Oracle VirtualBox.

**Reason:** VirtualBox provides a way to run the Windows Server domain controller and Windows client as separate virtual machines on one physical computer.

**Implementation:**
- One Windows Server 2019 virtual machine.
- One Windows 10 Pro virtual machine.
- Both virtual machines use the same isolated internal VirtualBox network for domain communication.

## 2. Domain Controller Operating System

**Decision:** Use Windows Server 2019 Standard Evaluation with Desktop Experience.

**Reason:** The Desktop Experience installation provides a graphical interface for learning and configuring Windows Server roles and Active Directory.

**Implementation:**
- Server name: `DC`
- Operating system: Windows Server 2019 Standard Evaluation
- Virtual memory: 2 GB
- Virtual processors: 4
- Virtual disk: 40 GB, dynamically allocated

## 3. Active Directory Domain

**Decision:** Create a new Active Directory forest using `mydomain.com`.

**Implementation:**
- DNS domain: `mydomain.com`
- NetBIOS name: `MYDOMAIN`
- Forest functional level: Windows Server 2016
- Domain functional level: Windows Server 2016
- DNS Server role installed with Active Directory Domain Services.

**Reason:** A new forest provides a standalone environment for learning domain controller installation, DNS integration, domain administration, and client domain joining.

**Lab note:** `mydomain.com` is used for this isolated lab environment. It should not be treated as a production domain recommendation.

## 4. Network Design

**Decision:** Use two network adapters on the domain controller.

| Adapter | VirtualBox mode | Purpose | Address |
|---|---|---|---|
| INTERNET | NAT | External network and internet access | 10.0.2.15 |
| INTERNAL | Internal Network (`intnet`) | Communication with lab machines | 172.16.0.1/24 |

**Reason:** Separating the external and internal network connections allows the domain controller to provide routing and network services to the internal lab network.

**Additional configuration:**
- Internal adapter has no default gateway.
- Preferred DNS on the domain controller is `127.0.0.1`.
- The Windows client connects only to the internal `intnet` network.

## 5. Routing and Remote Access

**Decision:** Install and configure Routing and Remote Access (RRAS) with NAT.

**Implementation:**
- Install the Remote Access role with DirectAccess and VPN (RAS) and Routing.
- Configure the `INTERNET` adapter as the public interface.
- Configure the `INTERNAL` adapter as the private interface.
- Enable NAT for internal network internet access.

**Reason:** The Windows client uses the internal network, while the domain controller routes its internet traffic through the NAT configuration.

## 6. DHCP Configuration

**Decision:** Use the domain controller as the DHCP server for the internal network.

**Implementation:**

| Setting | Configuration |
|---|---|
| Network | 172.16.0.0/24 |
| Scope name | 172.16.0.100-200 |
| Start address | 172.16.0.100 |
| End address | 172.16.0.200 |
| Subnet mask | 255.255.255.0 |
| Exclusions | None |
| Lease duration | 8 days |
| Default gateway | 172.16.0.1 |
| DNS server | 172.16.0.1 |
| DNS domain | mydomain.com |

**Reason:** Centralized DHCP configuration allows internal client machines to receive their network settings automatically.

**Validation:** The DHCP server was authorized, the scope was created and activated, and the client obtained a DHCP lease.

## 7. Active Directory Organizational Units

**Decision:** Separate administrative accounts and standard user accounts into dedicated organizational units.

**Implementation:**
- `_ADMINS`: Dedicated administrative account.
- `_USERS`: Bulk-generated lab user accounts.

**Reason:** Separating administrative and standard user accounts makes the directory easier to organize and demonstrates basic Active Directory account management.

## 8. Dedicated Administrative Account

**Decision:** Create a separate domain account for administrative work rather than relying only on the built-in Administrator account.

**Implementation:**
- Create a dedicated administrative account in `_ADMINS`.
- Add the account to the Domain Admins group.
- Confirm that the account can sign in to the domain.

**Reason:** This demonstrates the use of a separate administrative identity for domain management.

**Security note:** The account has Domain Admin privileges, so it should only be used for administration within this isolated lab.

## 9. Bulk User Creation

**Decision:** Use the PowerShell user-creation script from the tutorial to generate lab user accounts.

**Implementation:**
- Use `names.txt` as the source list.
- Run `1_CREATE_USERS.ps1` from an elevated PowerShell ISE session.
- Allow the script to create the `_USERS` organizational unit and populate it with accounts.
- Use the common lab password configured by the tutorial.

**Observed result:** The source file contained 1,002 lines, while 1,000 user accounts were created. Investigation identified duplicate generated usernames, including `smolder` and `trollins`.

**Security note:** The common password is for this isolated practice environment only. It must not be reused for real accounts or production systems.

## 10. Windows Client

**Decision:** Use Windows 10 Pro as the domain client.

**Implementation:**
- Computer name: `CLIENT1`
- Network: Internal VirtualBox network (`intnet`)
- IP configuration: DHCP
- Initial Windows setup: Local account
- Domain: `mydomain.com`

**Reason:** Windows 10 Pro supports joining an Active Directory domain and provides a client machine for testing domain connectivity and authentication.

**Validation:** CLIENT1 received its network configuration, accessed the internet, resolved the lab domain, joined the domain, and successfully signed in using a generated domain user account.

## 11. Password and Account Scope

**Decision:** Keep all generated accounts and passwords limited to the isolated lab.

**Reason:** The purpose of the generated accounts is to provide test identities for learning Active Directory administration and authentication.

**Security considerations:**
- Do not use real employee or customer information.
- Do not reuse personal or production passwords.
- Do not use these lab credentials outside the virtual environment.
- Avoid publishing screenshots or files that expose credentials or personal account details.

## 12. Optional PowerShell Helper Scripts

**Decision:** Keep the repository's additional PowerShell helper scripts separate from the tutorial's bulk user-creation process.

**Implementation:**
- `scripts/New-LabUsers.ps1` is an optional helper for creating lab accounts.
- `scripts/Test-LabDomain.ps1` is an optional helper for basic domain checks.

**Important:** These helper scripts were not used to build the current lab. They are included as supplementary examples and should not be confused with the tutorial script used for bulk account creation.

## 13. Current Lab Scope

The current implementation focuses on:
- Windows Server installation and configuration.
- Active Directory Domain Services.
- DNS integration.
- Organizational units and domain accounts.
- Routing and NAT.
- DHCP.
- Windows client configuration.
- Domain joining and user authentication.
- Basic PowerShell administration.

Additional topics such as Group Policy design, advanced permissions, centralized logging, and security monitoring can be added as separate learning milestones.