# Setup Guide

Use this as a checklist while following the tutorial. Record your own settings in the table below; do not blindly copy an IP address if your chosen virtual network differs.

## 1. Prepare the host

1. Confirm hardware virtualization is enabled.
2. Install Oracle VirtualBox from its official website.
3. Download installation media from official Microsoft sources.
4. Create a dedicated folder for ISO files and keep track of the versions.
5. Do not download OS images from unofficial file-sharing sites.

## 2. Create the domain controller VM

1. Create a VM named `DC01` (or another name you document).
2. Select the appropriate Windows Server 64-bit guest type.
3. Allocate RAM, CPU, and virtual disk space based on your host capacity.
4. Add two network adapters only if following the tutorial's dual-NIC NAT/routing design:
   - Adapter 1: VirtualBox NAT for outbound connectivity.
   - Adapter 2: Internal Network for the private lab segment.
5. Install Windows Server with Desktop Experience if you want the graphical management tools.
6. Install VirtualBox Guest Additions if compatible with your setup.

## 3. Configure the private network

Use a dedicated private subnet that does not conflict with your home LAN or VPN. The tutorial uses a sample private subnet; you should document your own final values.

| Setting | Your value |
|---|---|
| Lab domain (example: `ad.example.test`) | TODO |
| Domain controller hostname | TODO |
| Private subnet/CIDR | TODO |
| Domain controller private IP | TODO |
| DHCP range | TODO |
| Default gateway for clients | TODO |
| DNS server for clients | TODO |
| Client hostname | TODO |

Set a static IP on the server's **private-facing** adapter. Do not accidentally configure the internet-facing adapter with the private static address. Label the adapters clearly.

## 4. Install AD DS and create the domain

1. Rename the server and restart if prompted.
2. Install the Active Directory Domain Services role.
3. Promote the server to a new forest/domain for this isolated lab.
4. Use a lab-only domain name. Avoid using a real public domain that you do not own.
5. Confirm DNS is installed/configured as part of the domain-controller setup.
6. After restart, sign in using the domain administrator context.
7. Verify that the domain and DNS zones appear in their management consoles.

## 5. Configure routing/NAT and DHCP (optional for the core AD learning goal)

The video configures Remote Access/NAT and DHCP so the client on the private network can obtain an address and reach the internet through the server.

- Configure the DHCP scope for the private subnet.
- Ensure the DHCP options point clients to the correct gateway and DNS server.
- If using NAT, configure it only for the lab's private interface and outbound path.
- Do not expose internal services to the internet.
- If the goal is only to learn AD DS, you can initially omit client internet access and add it later.

## 6. Create lab users with PowerShell

1. Create a dedicated OU for test accounts in Active Directory Users and Computers.
2. Open PowerShell with appropriate administrative permissions on the domain controller.
3. Review `scripts/New-LabUsers.ps1` before running it.
4. Start with a small number of users (for example, 5) to validate the process.
5. Use a lab-only password entered interactively. Do not store it in the script or repository.
6. Verify that the accounts appear in the intended OU.

## 7. Create and join the client VM

1. Create a client VM using a Windows edition that supports domain joining. Windows Home does not support traditional Active Directory domain joining.
2. Connect its virtual network adapter to the same Internal Network as the server's private-facing adapter.
3. Confirm it receives the expected IP configuration.
4. Confirm it can resolve the lab domain using the domain controller as DNS.
5. Rename the client, then join it to the lab domain.
6. Restart and sign in using a lab domain account.
7. Run the checks in `TESTING.md` and record the actual output/results.

## 8. Clean up before publishing

- Replace TODO fields with your actual non-sensitive settings.
- Add screenshots you personally captured and redact host usernames, public IPs, email addresses, license keys, and other private details.
- Never commit VM disks, ISOs, passwords, or exported credentials.
- Document any differences from the tutorial, especially OS versions and network design.

## Domain Controller Virtual Machine

| Configuration | Value |
|---|---|
| VM Name | DC |
| Operating System | Windows Server 2019 Evaluation |
| Memory | 2 GB |
| Virtual Processors | 4 |
| Virtual Disk | 40 GB |
| Disk Allocation | Dynamically allocated |

The Domain Controller VM will host Active Directory Domain Services and DNS.

### Windows Server Installation

- Operating System: Windows Server 2019 Standard Evaluation
- Installation Mode: Desktop Experience
- Installation Type: Custom
- Installation Status: Completed
- Initial Administrator Login: Successful

### VirtualBox Guest Additions

Status: Installed

Purpose:
- Improved mouse integration
- Automatic display resizing
- Shared clipboard functionality

### Domain Controller Network Configuration

| Adapter | Configuration | IP Address |
|---|---|---|
| INTERNET | NAT | 10.0.2.15 |
| INTERNAL | Internal Network | 172.16.0.1 |

Internal Network settings:
- Subnet Mask: 255.255.255.0
- Default Gateway: None
- Preferred DNS: 127.0.0.1

### Domain Controller Hostname

- New hostname: DC
- Computer restart: Completed
- Hostname verification: Successful

## Active Directory Domain Services Installation

- Server: DC
- Role: Active Directory Domain Services (AD DS)
- Installation Status: Successful
- Promotion to Domain Controller: Pending

## Domain Controller Promotion

### Active Directory Forest

| Configuration | Value |
|---|---|
| Domain Controller | DC |
| Forest Root Domain | mydomain.com |
| NetBIOS Domain | MYDOMAIN |
| Forest Functional Level | Windows Server 2016 |
| Domain Functional Level | Windows Server 2016 |
| DNS Server | Enabled |
| Global Catalog | Enabled |

### Promotion Status

- AD DS Role Installation: Successful
- New Forest Creation: Successful
- Domain Controller Promotion: Successful
- Domain Administrator Login: Successful

### Active Directory Organizational Units

| OU Name | Purpose |
|---|---|
| _ADMINS | Stores dedicated administrative accounts |

### Dedicated Domain Administrator Account

| Configuration | Value |
|---|---|
| Account | Dedicated domain administrator |
| Logon Name | a-dscotland |
| Organizational Unit | _ADMINS |
| Security Group | Domain Admins |
| Account Creation | Successful |
| Group Membership | Verified |
| Domain Login | Successful |

## Routing and Remote Access Installation

| Component | Status |
|---|---|
| Remote Access Role | Installed |
| DirectAccess and VPN (RAS) | Installed |
| Routing | Installed |
| Web Application Proxy | Not installed |

Configuration Status: Pending

### RRAS and NAT Configuration

| Component | Configuration |
|---|---|
| RRAS | Successfully configured |
| NAT | Enabled |
| Public Interface | INTERNET |
| Public Interface IP | 10.0.2.15 |
| Private Network | intnet |
| Private Interface IP | 172.16.0.1 |

RRAS Status: Running

## Routing and Remote Access (RRAS)

| Component | Configuration |
|---|---|
| RRAS Server | DC |
| RRAS Status | Running |
| NAT | Enabled |
| Public Interface | INTERNET |
| Public IP | 10.0.2.15 |
| Internal Interface | INTERNAL |
| Internal IP | 172.16.0.1 |
| Private Network | intnet |

RRAS configuration completed successfully.

## DHCP Server Configuration

The DHCP Server role was installed and configured on the domain controller.

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

- The DHCP scope provides IP addresses to devices on the internal network.
- The internal network interface uses 172.16.0.1.
- DHCP options provide clients with the correct default gateway and DNS server.
- The DHCP server was authorized in Active Directory.
- DHCP interface bindings were checked to verify the intended network interface configuration.

## Internet Explorer Enhanced Security Configuration

Internet Explorer Enhanced Security Configuration (IE ESC) was disabled on the Windows Server 2019 domain controller to simplify browser access during the lab setup.

| Setting | Configuration |
|---|---|
| Administrators | Off |
| Users | Off |

**Note:** This setting was changed for lab convenience only. Disabling IE ESC reduces browser security protections.

## Bulk Active Directory User Creation

A PowerShell script from Josh Madakor's AD_PS repository was used
to generate employee accounts in Active Directory.

| Setting | Configuration |
|---|---|
| Script | 1_CREATE_USERS.ps1 |
| Names File | names.txt |
| Input Entries | 1,002 |
| Unique Usernames | 1,000 |
| Accounts Created | 1,000 |
| Organizational Unit | _USERS |
| Account Status | Enabled |

### User Creation Notes

- The names.txt file was updated with an additional name before execution.
- The PowerShell script generated usernames using the names in the file.
- Two generated usernames appeared twice: smolder and trollins.
- Duplicate usernames could not create separate Active Directory accounts.
- A total of 1,000 accounts were verified in the _USERS OU.