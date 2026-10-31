# Active Directory Lab Network Plan

## 1. Network Overview

The lab uses two VirtualBox network types:

- NAT: Provides the domain controller with external network access.
- Internal Network (`intnet`): Provides private communication between the domain controller and Windows client.

The domain controller also provides routing, NAT, DHCP, DNS, and Active Directory services to the internal lab network.

## 2. Network Addressing

| Setting | Configuration |
|---|---|
| Internal network | 172.16.0.0/24 |
| Subnet mask | 255.255.255.0 |
| Domain controller | DC |
| Domain controller internal IP | 172.16.0.1 |
| Domain controller external IP | 10.0.2.15 |
| DNS domain | mydomain.com |
| NetBIOS domain | MYDOMAIN |

## 3. Domain Controller Network Adapters

### Adapter 1: INTERNET

| Setting | Value |
|---|---|
| VirtualBox mode | NAT |
| Interface name | INTERNET |
| IP address | 10.0.2.15 |
| Purpose | External network connectivity |

### Adapter 2: INTERNAL

| Setting | Value |
|---|---|
| VirtualBox mode | Internal Network |
| Internal network name | intnet |
| Interface name | INTERNAL |
| IP address | 172.16.0.1 |
| Subnet mask | 255.255.255.0 |
| Default gateway | None |
| Preferred DNS | 127.0.0.1 |

## 4. DHCP Scope

The domain controller provides DHCP services to the internal network.

| Setting | Value |
|---|---|
| Scope network | 172.16.0.0 |
| Start IP | 172.16.0.100 |
| End IP | 172.16.0.200 |
| Subnet mask | 255.255.255.0 |
| Excluded addresses | None |
| Lease duration | 8 days |
| Default gateway | 172.16.0.1 |
| DNS server | 172.16.0.1 |
| DNS domain | mydomain.com |

## 5. Routing and NAT

Routing and Remote Access (RRAS) is configured on the domain controller.

| Interface | Role |
|---|---|
| INTERNET | Public interface |
| INTERNAL | Private interface |

NAT allows internal clients to access external networks through the domain controller.

## 6. Windows Client Configuration

| Setting | Value |
|---|---|
| Computer name | CLIENT1 |
| VirtualBox network | Internal Network |
| Network name | intnet |
| IP configuration | DHCP |
| DNS server | 172.16.0.1 |
| Default gateway | 172.16.0.1 |
| Active Directory domain | mydomain.com |

CLIENT1 obtains its network configuration automatically from the domain controller.

## 7. Network Validation

The following checks were completed during the lab build:

- [x] Domain controller has external and internal network adapters.
- [x] Internal adapter uses the static address 172.16.0.1.
- [x] DHCP scope is configured and active.
- [x] DHCP server is authorized.
- [x] DHCP options and interface binding were checked.
- [x] CLIENT1 obtained a DHCP lease.
- [x] CLIENT1 accessed the internet.
- [x] CLIENT1 successfully resolved the domain name.
- [x] CLIENT1 successfully joined mydomain.com.

## 8. Network Topology

```text
                 Internet
                    |
             VirtualBox NAT
                    |
          +--------------------+
          |        DC          |
          | Windows Server 2019|
          |                    |
          | INTERNET           |
          | 10.0.2.15          |
          |                    |
          | INTERNAL           |
          | 172.16.0.1         |
          |                    |
          | AD DS / DNS        |
          | DHCP / RRAS        |
          +--------------------+
                    |
             Internal Network
                  intnet
                    |
          +--------------------+
          |      CLIENT1       |
          |    Windows 10 Pro  |
          |                    |
          | DHCP Address       |
          | 172.16.0.100-200   |
          +--------------------+
```

## 9. Lab Notes

This network is designed for an isolated home lab.

The addressing scheme and domain are intended for practice and should not be copied into a production network without proper planning and review.