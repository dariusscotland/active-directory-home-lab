# Configuration Files

This directory contains documentation of the network configuration used in the Active Directory home lab.

## Files

| File | Description |
|---|---|
| `network-plan.md` | Documents the implemented lab network, including IP addressing, VirtualBox network adapters, DHCP settings, and routing configuration. |
| `network-plan.example.md` | Template for documenting the lab network configuration. |

## Network Overview

The lab uses two VirtualBox network connections:

- **NAT:** Provides external network connectivity to the domain controller.
- **Internal Network (`intnet`):** Provides private communication between the domain controller and Windows client.

The Windows Server 2019 domain controller provides the following services to the internal network:

- Active Directory Domain Services (AD DS)
- DNS
- DHCP
- Routing and Remote Access (RRAS)
- Network Address Translation (NAT)

## Network Addressing

| Device | Interface | IP Address |
|---|---|---|
| DC | INTERNET | 10.0.2.15 |
| DC | INTERNAL | 172.16.0.1 |
| CLIENT1 | Internal Network | DHCP: 172.16.0.100-200 |

**Active Directory domain:** `mydomain.com`

**Internal network:** `172.16.0.0/24`

## Documentation

For the complete network configuration, see [network-plan.md](network-plan.md).

These configurations document an isolated learning environment and are not intended as production network settings.