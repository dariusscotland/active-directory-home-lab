# Troubleshooting Notes

Record the symptom, likely cause, checks performed, fix, and final result. These are investigation paths, not guaranteed fixes.

## Client has no IP address

- Check that the client adapter is connected to the same VirtualBox Internal Network as the server's private NIC.
- Confirm the DHCP Server role/scope is active and the scope has available addresses.
- Check that the server's private NIC has the expected static address.
- Run `ipconfig /release` and `ipconfig /renew` on the client, if using DHCP.
- Check DHCP options for gateway and DNS values.

## Client gets an address but cannot resolve the domain

- Check that the client's DNS server points to the domain controller, not a public DNS resolver.
- Run `ipconfig /all` and `nslookup <your-domain>`.
- Confirm the domain DNS zone exists and the DNS service is running.
- Check that the client's clock is reasonably synchronized; Kerberos authentication is time-sensitive.

## Domain join fails

- Confirm the client edition supports domain joining.
- Verify DNS resolution for the domain and domain controller.
- Check that the client and server can communicate over the lab network.
- Confirm the domain name is typed correctly and the account has permission to join computers.
- Review the exact error message before changing settings.

## Client cannot reach the internet

- First determine whether internet access is required for the lab stage you are on.
- Verify the server's outbound adapter has connectivity.
- Verify the private interface, routing/NAT, and DHCP options align with your topology.
- Do not switch the lab to bridged networking as a blind fix; that can expose lab services to your physical LAN.

## PowerShell cannot find AD cmdlets

- Run the script on the domain controller or a machine with the appropriate Active Directory management tools.
- Check `Get-Module -ListAvailable ActiveDirectory`.
- Use an elevated PowerShell session with the permissions required for the task.

## Lab recovery

Before major role/network changes, take a VirtualBox snapshot. Use snapshots only as a lab recovery aid; do not treat them as a backup strategy for production systems.
