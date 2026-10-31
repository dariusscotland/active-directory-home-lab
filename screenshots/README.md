# Lab Screenshots and Evidence

This directory contains screenshots captured during the construction, configuration, and testing of the Active Directory home lab.

The screenshots document the actual implementation process and provide visual evidence of the completed lab.

## Screenshot Index

The original screenshot filenames and numbering have been preserved.

### Virtual Machine Preparation and Windows Server Installation

- `01-dc-system-settings.png`
- `01-dc-vm-hardware.png`
- `02-dc-system-settings.png`
- `03-dc-system-settings.png`
- `03-windows-server-installation.png`
- `04-windows-server-edition.png`
- `05-server-disk-selection.png`
- `06-windows-server-installation-progress.png`
- `07-windows-server-first-login.png`

### Domain Controller Network Configuration

- `08a-dc-adapter1-nat.png`
- `08b-dc-adapter2-internal.png`
- `09a-dc-nat-adapter-details.png`
- `09b-dc-internal-adapter-details.png`
- `10-internal-static-ip.png`
- `11-dc-ipconfig-verification.png`
- `12-dc-hostname.png`

### Active Directory Domain Services

- `13-adds-role-selection.png`
- `14-adds-role-installed.png`
- `15-new-forest-configuration.png`
- `16-domain-controller-options.png`
- `17-dns-options.png`
- `18-netbios-domain-name.png`
- `19-active-directory-paths.png`
- `20-active-directory-review-options.png`
- `21-domain-controller-prerequisites.png`
- `22-domain-controller-promoted.png`
- `23-active-directory-verification.png`

### Administrative Accounts and Organizational Units

- `25-my-admins-organizational-unit.png`
- `26-domain-admin-account-created.png`
- `27-a-dscotland-domain-admin-membership.png`
- `28-labadmin-login-verification.png`

### Routing and Remote Access

- `29-remote-access-routing-selection.png`
- `30-remote-access-role-installed.png`
- `31-rras-nat-configuration.png`
- `32-rras-nat-internet-interface.png`
- `33-rras-nat-running.png`

### DHCP Configuration

- `35-dhcp-server-role-installed.png`
- `37-dhcp-new-scope.png`
- `38-dhcp-scope-name.png`
- `39-dhcp-ip-address-range.png`
- `40-dhcp-exclusions.png`
- `41-dhcp-lease-duration.png`
- `42-dhcp-default-gateway.png`
- `43-dhcp-domain-dns-configuration.png`
- `44-dhcp-wins-configuration.png`
- `45-dhcp-scope-created.png`
- `46-dhcp-options-verification.png`
- `46-dhcp-scope-created.png`
- `47-dhcp-interface-binding.png`

### Internet Explorer Enhanced Security Configuration

- `48-ie-enhanced-security-disabled.png`

### PowerShell Bulk User Creation

- `50-powershell-user-creation.png`
- `51-active-directory-generated-users.png`

### Windows Client Configuration and Domain Joining

- `52-client1-network-configuration.png`
- `53-client1-ip-configuration.png`
- `54-client1-internet-connectivity.png`
- `55-client1-domain-connectivity.png`
- `56-client1-domain-join-success.png`
- `57-client1-domain-login-verification.png`
- `58-dhcp-client1-address-lease.png`
- `59-client1-active-directory-computer-object.png`

## Evidence

The screenshots document:

- Virtual machine creation and operating system installation.
- Domain controller network configuration.
- Active Directory Domain Services installation and promotion.
- Organizational units and administrative accounts.
- Routing, NAT, and DHCP configuration.
- PowerShell-based user creation.
- Windows client network configuration.
- Domain joining and authentication.
- DHCP lease and Active Directory computer object verification.

## Documentation Notes

The filenames and numbering reflect the original screenshot collection.

Some stages are documented using multiple screenshots to show the relevant configuration and results.

The screenshots should be considered alongside the supporting documentation:

- `docs/SETUP.md`
- `docs/TESTING.md`
- `docs/TROUBLESHOOTING.md`
- `docs/LAB-WALKTHROUGH.md`
- `configs/network-plan.md`

This collection represents the actual evidence captured during the lab implementation.