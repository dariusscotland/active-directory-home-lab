# Lab Screenshots and Evidence

This directory contains screenshots captured during the construction, configuration, and testing of the Active Directory home lab.

The screenshots provide visual evidence of the work completed and help document the implementation process.

## Screenshot Numbering

The screenshot filenames follow the order in which evidence was captured during the lab.

The numbering is not strictly sequential.

Some numbers are repeated because:
- Multiple screenshots were needed to document the same stage.
- Some configuration screens required separate screenshots to show all relevant settings.
- Some screenshots were captured at different points during the build.

For example:

- `08a-dc-adapter1-nat.png` and `08b-dc-adapter2-internal.png` document the two domain controller network adapters.
- `09a-dc-nat-adapter-details.png` and `09b-dc-internal-adapter-details.png` show the details of those adapters.

The existing filenames have been retained to preserve the original evidence. A missing number does not necessarily mean a particular configuration step was skipped.

## 1. Virtual Machine Preparation and Windows Server Installation

These screenshots document the domain controller virtual machine configuration and Windows Server installation.

- `01-dc-system-settings.png`
- `01-dc-vm-hardware.png`
- `02-dc-system-settings.png`
- `03-dc-system-settings.png`
- `03-windows-server-installation.png`
- `04-windows-server-edition.png`
- `05-server-disk-selection.png`
- `06-windows-server-installation-progress.png`
- `07-windows-server-first-login.png`

## 2. Domain Controller Network Configuration

These screenshots document the domain controller's NAT and internal network adapters, IP configuration, and hostname.

- `08a-dc-adapter1-nat.png`
- `08b-dc-adapter2-internal.png`
- `09a-dc-nat-adapter-details.png`
- `09b-dc-internal-adapter-details.png`
- `10-internal-static-ip.png`
- `11-dc-ipconfig-verification.png`
- `12-dc-hostname.png`

## 3. Active Directory Domain Services Installation

These screenshots document the AD DS role installation and domain controller promotion.

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

## 4. Administrative Accounts and Organizational Units

These screenshots document the creation of the administrative organizational unit and dedicated domain administrator account.

- `25-my-admins-organizational-unit.png`
- `26-domain-admin-account-created.png`
- `27-a-dscotland-domain-admin-membership.png`
- `28-labadmin-login-verification.png`

Review these screenshots before using the repository as a public portfolio. Remove or redact personal account identifiers where necessary. Confirm that each filename accurately describes the screenshot before renaming it.

## 5. Routing and Remote Access Configuration

These screenshots document the Remote Access role installation and RRAS NAT configuration.

- `29-remote-access-routing-selection.png`
- `30-remote-access-role-installed.png`
- `31-rras-nat-configuration.png`
- `32-rras-nat-internet-interface.png`
- `33-rras-nat-running.png`

## 6. DHCP Server Configuration

These screenshots document DHCP role installation, scope creation, address allocation settings, DHCP options, and interface binding.

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

There are two screenshots using the `46` prefix. Both filenames have been retained because they document separate evidence.

## 7. Internet Explorer Enhanced Security Configuration

- `48-ie-enhanced-security-disabled.png`

This screenshot documents the Internet Explorer Enhanced Security Configuration change on the domain controller.

## 8. Bulk Active Directory User Creation

These screenshots document the PowerShell bulk user creation process and the resulting Active Directory accounts.

- `50-powershell-user-creation.png`
- `51-active-directory-generated-users.png`

## 9. Windows Client Configuration and Domain Joining

These screenshots document the Windows 10 client network configuration, connectivity checks, domain joining, and domain login verification.

- `52-client1-network-configuration.png`
- `53-client1-ip-configuration.png`
- `54-client1-internet-connectivity.png`
- `55-client1-domain-connectivity.png`
- `56-client1-domain-join-success.png`
- `57-client1-domain-login-verification.png`

## 10. Additional Evidence to Confirm or Capture

The following evidence would strengthen the final documentation. These filenames are proposed additions and are not currently present in the repository's screenshot inventory.

| Proposed filename | Evidence to capture |
|---|---|
| `58-dhcp-client1-address-lease.png` | CLIENT1 appearing in the DHCP Address Leases list. |
| `59-client1-active-directory-computer-object.png` | CLIENT1 appearing in the Active Directory Computers container. |
| `60-client1-generated-user-login.png` | Successful sign-in to CLIENT1 using one of the generated domain user accounts. |

Some of these activities were completed during the lab build, but the corresponding screenshots are not currently listed in the repository.

Only add these files if the screenshots are available or can be captured again.

## 11. Screenshot Guidelines

When adding new evidence:

- Capture screenshots from the actual working lab.
- Use descriptive filenames.
- Preserve existing filenames unless there is a good reason to rename them.
- Use letter suffixes such as `a` and `b` when multiple screenshots document one stage.
- Make sure screenshots are readable and show the relevant configuration or result.
- Avoid unnecessary desktop clutter.
- Redact passwords, product keys, personal account identifiers, and other sensitive information.
- Never use tutorial screenshots as evidence of your own lab implementation.

## 12. Evidence Limitations

The screenshot collection reflects the evidence captured during the build. It is not a perfectly numbered, step-by-step recording of every action.

Some steps may have been completed without a corresponding screenshot, and some configuration stages required multiple screenshots to show the full result.

The written documentation provides additional context where screenshots are missing or incomplete.