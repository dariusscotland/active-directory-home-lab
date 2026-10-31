# Security

This repository documents a disposable Active Directory learning lab.
It is intended for educational use and is not a production-ready
Active Directory design.

## Lab Isolation

- Keep the lab on an isolated VirtualBox Internal Network.
- Do not expose the domain controller or its services directly to
  the public internet.
- Do not connect the lab to a workplace or production network.
- Use NAT only where internet access is required for lab activities.

## Accounts and Credentials

- Do not reuse personal, workplace, or production credentials.
- Use dedicated accounts for administrative activities.
- Avoid using Domain Administrator credentials for routine tasks.
- The sample lab password is intentionally simple for demonstration
  purposes. Never use it outside this isolated lab.
- Do not commit passwords, recovery keys, tokens, or other secrets.

## Scripts and Configuration

- Review PowerShell scripts before executing them.
- Run scripts with elevated privileges only when necessary.
- Understand the changes a script makes to Active Directory before
  running it.
- Use test accounts and disposable virtual machines when experimenting.

## Screenshots and Personal Information

- Review screenshots before publishing them.
- Remove or obscure passwords, personal information, public IP
  addresses, and other sensitive details.
- Do not upload real employee records or confidential organizational
  information.

## Operating System Lifecycle

This lab includes Windows 10 Pro for domain-joining demonstrations.
Windows 10 reached end of support on October 14, 2025.
The virtual machine is retained for historical learning purposes and
should not be treated as a supported production workstation.

## Reporting a Security Concern

If you discover accidentally exposed credentials or sensitive
information in this repository, contact the repository owner privately.
Do not publish the information in a public issue.

Rotate or revoke any exposed credentials immediately.