# Testing and Verification

Run only the checks that match the configuration you actually built. Record expected and observed results in your project notes.

## Domain controller checks

| Check | Example command / action | Expected result |
|---|---|---|
| Host name | `hostname` | Matches your documented DC name |
| IP configuration | `ipconfig /all` | Private NIC has the documented static address |
| AD DS role | Server Manager → Roles | AD DS installed |
| DNS zone | DNS Manager | Lab domain zone exists |
| Domain controller discovery | `nltest /dsgetdc:<your-domain>` | Finds your lab domain controller |
| AD module | `Get-Module -ListAvailable ActiveDirectory` | Module is available on a system with RSAT/AD tools |
| Domain information | `Get-ADDomain` | Returns the lab domain details |

Replace `<your-domain>` with the domain you actually configured. Do not publish output containing sensitive host or network information without reviewing it.

## Client checks

| Check | Example command / action | Expected result |
|---|---|---|
| Address | `ipconfig /all` | Client gets an address from the intended lab scope, if DHCP is enabled |
| Gateway | `ipconfig` | Matches your lab design, if a gateway is configured |
| DNS | `nslookup <your-domain>` | Resolves using the expected DNS server |
| Reach domain controller | `ping <dc-private-ip>` | Replies if ICMP is allowed and routing is correct |
| Domain membership | System → About or `systeminfo` | Client belongs to the lab domain |
| Logged-on identity | `whoami` | Shows domain and user after domain sign-in |
| User lookup | `whoami /upn` | Shows the user principal name where available |

Ping alone does not prove that Active Directory is healthy. Use DNS and domain-specific checks as well.

## Evidence to capture

- [ ] VirtualBox VM list showing the lab VMs (hide unrelated VM names if needed).
- [ ] VirtualBox network adapter settings for each VM.
- [ ] Server IP configuration with sensitive details redacted.
- [ ] AD DS role installed and domain visible.
- [ ] DNS zone and DHCP scope (if configured).
- [ ] Test users visible in the dedicated OU.
- [ ] Successful domain join on the client.
- [ ] `whoami` output after domain sign-in.
- [ ] A short test-results table with pass/fail and notes.

Do not write “passed” until you have run the test yourself.

## Active Directory Domain Controller Verification

Date: October 29, 2026

| Test | Command | Expected Result | Status |
|---|---|---|---|
| User identity | whoami | MYDOMAIN\Administrator | PASS |
| Computer name | hostname | DC | PASS |
| Domain verification | Get-ADDomain | mydomain.com | PASS |
| Forest verification | Get-ADForest | mydomain.com | PASS |

### Result

All four verification tests completed successfully.

The server successfully operates as a Domain Controller for the
mydomain.com Active Directory forest.

## Dedicated Domain Administrator Login Test

| Test | Expected Result | Status |
|---|---|---|
| Domain login | Successful | PASS |
| whoami | MYDOMAIN\a-dscotland | PASS |
| Domain Admins membership | Present | PASS |

Result: Dedicated domain administrator successfully authenticated.

## DHCP Server Verification

The following PowerShell commands were used to verify the DHCP configuration.

### 1. Verify DHCP Server Authorization

```powershell
Get-DhcpServerInDC
