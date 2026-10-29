# Design Decisions

Add an entry when you make a meaningful choice. Keep it short and explain the reason.

## Initial decisions

### Separate private lab network

**Decision:** Use a VirtualBox Internal Network for the lab client and the server's private-facing NIC.

**Reason:** Keeps the lab segment separate from the host's physical LAN. The tutorial adds a separate outbound adapter and configures routing/NAT on the server.

### Use test-only identities

**Decision:** Create synthetic users in a dedicated OU.

**Reason:** Avoids importing personal, employer, or customer data into the lab.

### Start with a small batch of users

**Decision:** Test the user creation script with a small number before scaling it up.

**Reason:** Makes mistakes easier to identify and avoids filling the directory with unwanted test accounts.

### Keep passwords out of source control

**Decision:** Prompt for a lab-only password at run time.

**Reason:** Prevents credentials from being stored in the repository or Git history.
