
# PowerShell Script Used

This directory documents the PowerShell script used during the Active Directory home lab implementation.

The script was obtained from Josh Madakor's Active Directory PowerShell repository and was used to create synthetic employee accounts in the lab domain.

## Script Reference

**Script:** `1_CREATE_USERS.ps1`

**Original author:** Josh Madakor

**Source repository:** [AD_PS](https://github.com/joshmadakor1/AD_PS)

**Tutorial:** [How to Setup a Basic Home Lab Running Active Directory](https://www.youtube.com/watch?v=MHsI8hJmggI)

The original script is maintained in the author's repository and is not included in this project.

## Input File

The script uses a text file named `names.txt` containing first and last names.

The file was downloaded with the tutorial resources and modified locally to include an additional name. It is not included in this repository.

## Implementation Process

The following process was completed during the lab:

1. Downloaded the tutorial's PowerShell files.
2. Extracted the downloaded archive.
3. Modified `names.txt` to include an additional name.
4. Opened PowerShell ISE as Administrator.
5. Set the execution policy for the current PowerShell process:

   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process
   ```

6. Set the working directory to the extracted tutorial folder.
7. Executed `1_CREATE_USERS.ps1`.
8. Verified the created accounts in Active Directory Users and Computers.

## Observed Results

- Source file contained 1,002 entries.
- 1,000 Active Directory user accounts were created.
- Two duplicate generated usernames were identified:
  - `smolder`
  - `trollins`

The resulting accounts were created in the `_USERS` organizational unit.

Further account-count verification and the duplicate username investigation are documented in:

- [Testing Guide](../docs/TESTING.md)
- [Troubleshooting Guide](../docs/TROUBLESHOOTING.md)

## Security Considerations

The tutorial script uses a shared initial lab password for the generated accounts.

This was used only within the isolated, disposable virtual lab. Never reuse lab credentials outside that environment or run the tutorial script against a production domain.

Review external scripts before executing them and understand the changes they make to Active Directory.
