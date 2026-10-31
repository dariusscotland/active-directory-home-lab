# PowerShell Scripts

This directory contains supplementary PowerShell scripts for managing and testing the Active Directory home lab.

The scripts are intended for an isolated, disposable learning environment. Review each script before running it.

## Repository Scripts

### 1. New-LabUsers.ps1

**Purpose:** Creates synthetic Active Directory user accounts.

This is an optional helper script included in this repository. It supports creating a specified number of lab users in a selected organizational unit and prompts for a password.

**Features:**
- Creates synthetic user accounts.
- Allows the target organizational unit to be selected.
- Prompts for a password rather than storing one in the script.
- Supports PowerShell's `-WhatIf` and `-Confirm` options through `ShouldProcess`.

**Current status:** Included as an optional example. It was not used to create the 1,000 accounts in the completed lab.

### 2. Test-LabDomain.ps1

**Purpose:** Provides basic checks for the Active Directory lab environment.

This is an optional helper script intended to assist with checking domain and DNS configuration.

**Current status:** Included as a supplementary example. It has not been run as part of the lab validation documented in this repository.

## Bulk User Creation Used in This Lab

The bulk user creation process followed the PowerShell script provided with the Active Directory home lab tutorial.

**Script used:** `1_CREATE_USERS.ps1`

**Input file:** `names.txt`

The tutorial files were downloaded separately and used locally. They are not included in this repository's `scripts` directory.

**Process followed:**
1. Download the tutorial's PowerShell files.
2. Edit `names.txt` to provide the source names.
3. Open PowerShell ISE as Administrator.
4. Set the execution policy for the current PowerShell process.
5. Run `1_CREATE_USERS.ps1`.
6. Verify the generated accounts in Active Directory Users and Computers.

**Observed result:**
- The source file contained 1,002 lines.
- The script created 1,000 user accounts.
- Investigation identified duplicate generated usernames, including `smolder` and `trollins`.

The duplicate-name investigation and account-count verification are documented in `../docs/TROUBLESHOOTING.md` and `../docs/TESTING.md`.

## Execution and Security Considerations

Before running any PowerShell script:

- Read and understand what the script does.
- Use an isolated lab environment.
- Run with only the privileges required.
- Do not run these scripts against an employer's or another real production domain.
- Do not store real passwords or personal information in scripts.
- Do not reuse lab credentials outside the virtual environment.
- Verify the results after executing a script.

The bulk user-creation tutorial used a common lab password. That password is for isolated practice only and should never be used for real accounts.

## Lab Scope

These scripts support learning and experimentation with:

- Active Directory user management.
- PowerShell automation.
- Domain and DNS checks.
- Basic administrative tasks.

They are supplementary tools and are not required for the core lab configuration.