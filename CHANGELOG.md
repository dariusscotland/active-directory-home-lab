# Changelog

All notable changes to this Active Directory home lab project are documented here.

## Completed Project

### Added

- Created a Windows Server 2019 virtual machine to serve as the domain controller.
- Configured separate NAT and Internal Network adapters in VirtualBox.
- Assigned the domain controller the static internal IP address `172.16.0.1`.
- Installed Active Directory Domain Services (AD DS).
- Created the `mydomain.com` Active Directory forest.
- Configured DNS as part of the domain controller deployment.
- Created the `_ADMINS` organizational unit.
- Created a dedicated domain administrator account and verified domain administrative access.
- Installed and configured Routing and Remote Access (RRAS).
- Configured Network Address Translation (NAT) to provide internet access to the internal network.
- Installed and authorized the DHCP server role.
- Created and activated the DHCP scope `172.16.0.100-200`.
- Configured DHCP options for the default gateway, DNS server, and domain name.
- Disabled Internet Explorer Enhanced Security Configuration for the lab server.
- Used the tutorial's `1_CREATE_USERS.ps1` script and `names.txt` to generate Active Directory user accounts.
- Created 1,000 lab user accounts in the `_USERS` organizational unit.
- Created a Windows 10 Pro virtual machine named `CLIENT1`.
- Configured CLIENT1 to obtain its network settings through DHCP.
- Successfully connected CLIENT1 to the internet and verified domain name resolution.
- Joined CLIENT1 to the `mydomain.com` domain.
- Verified successful domain authentication using a generated user account.
- Added screenshots documenting the implementation and validation process.

### Verified

- Active Directory domain and forest configuration.
- Domain controller identity and domain membership.
- Dedicated domain administrator account authentication.
- DHCP server authorization and scope configuration.
- DHCP options and interface binding.
- Successful DHCP address assignment to CLIENT1.
- CLIENT1 internet connectivity.
- CLIENT1 domain name resolution.
- Successful domain joining.
- CLIENT1 domain user authentication.
- CLIENT1 computer object appearing in Active Directory.

### Investigated

- Investigated the difference between the tutorial's `1_CREATE_USERS.ps1` script and a separate user-generation script.
- Investigated why a source file containing 1,002 lines resulted in 1,000 created user accounts.
- Identified duplicate generated usernames, including `smolder` and `trollins`.

### Documentation

- Expanded the Active Directory lab setup guide.
- Documented the lab testing and verification procedures.
- Added troubleshooting notes based on issues encountered during implementation.
- Documented network addressing and configuration.
- Updated lab design decisions and implementation details.
- Documented supplementary PowerShell scripts.
- Organized screenshot evidence by implementation stage.

## Project Status

The core Active Directory home lab has been implemented and the primary domain, network, DHCP, client connectivity, domain joining, and authentication checks have been completed.

Further improvements may include additional Group Policy configuration, permissions management, security monitoring, and more advanced PowerShell automation.