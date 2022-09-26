# Beginning PowerShell Workshop

## Abstract & notes

TODO:  Demo Machine notes:

- Replace demos with current 2022
- Install
  - WSL (For terminal demo) (install pwsh into wsl)
  - CloudShell account (terminal demo)
  - Domain controller (AD) with users for demos
  - Remoting (SSH/WinRM)

Make sure these are covered:  (From meeting with everyone)

1. How to get Powershell on your system
1. How to discover commands and modules with commands.
1. How to setup remoting with SSH
1. How to get ready to script
1. How to get Help
1. How to output results
1. How to pipeline commands
1. How to manage at scale
   - Getting remote information (CIM)
   - Running remote scripts
   - Bastion (cut)
1. How to stay up-to-date with current PowerShell events.
1. How to contribute to the community - that is contributing to you.

Plus include this:

Optimizing Shell Experience.... (Sydney/Jason)

- Predictors
  - SecretManagement
  - Crescendo - No, Just concept if asked.
- PSGet V2/v3 ??

- DSC - No, just concept if asked.
- SSH - already in remoting section
- AD - already in demo (user accounts)
- InTune - nothing planned
- Office 365 - 5-10 demo's for content.

## Introduction

- Introduce the team
- Why PowerShell Matters (Sydney)
  - Management and Automation at scale
  - Sacred promise
  - Optimizing the user, not the product. (empowering you)
  - Historical usage stat numbers --
    - could we do this for 15 years? or an estimate...... recent growth good enough.
- Don't fear the Shell...... (JASON/Sydney)
- TODO: Jason;s old routine
  - Native commands
  - Cmdlet - Verb-Noun
  - Aliases - shortcuts
  - Scripts

## Getting Started (Jason/Jeff/Sean - Docs)

- Where does PowerShell run? (Linux, macOS, Windows, Azure Cloud Shell)
- How do I get PowerShell
  - Why its not already in Windows
  - GitHub/Store/WinGet (link)
  - Docs: Install docs (link)
- Launching PowerShell
  - Launch Console - just Show
  - Launch on Mac - preferred
  - Launch in Terminal - preferred
    - Brief: Multi versions - CloudShell - WSL

## The Help System (Jason/Sydney)

- Updatable Help
- Get-Help, Help, Man
- Dynamic Help F1, alt-a, alt-h (less important than F1)
- Discoverability with the Help system
  - The Process - Discover then Dig
  - Examples:
    - Get-Help <noun>
    - Get-Help <verb>
    - Get-Help cmdlet -detailed
    - Get-Help cmdlet -Examples
    - Get-Help cmdlet -Full
    - Get-Help cmdlet -Online
    - Get-Help cmdlet -ShowWindow
  - The other help system About_
- Understanding Syntax
  - Parameter Sets
  - What does all this syntax mean?
- Real-world
  - Examples of discovering and solving
    - Get-Service -Name bits
    - Stop-Service
    - Start-service
    - Get-AdComputer

## The Pipeline: Connecting commands (Jeff)

- What's the pipe and what does it do?
  - How things are passed
  - Examples
    - Get-service -name bits
    - Get-Service -Name bits | Stop-Service
    - Get-Service | Stop-Service
- Exporting/Importing CSV's
- Exporting/Importing XML
  - Example: Compare-Object on Processes
- Printers and files
- Displaying information in a GUI
  - Out-Gridview
- Making a webpage of Information
- Cmdlets that kill
  - -Whatif
  - -Confirm

## Extending the shell (Jeff/Sean)

TODO: - Add psget v3 Find-PSReasource, Install-PSResource

- Finding and Adding Modules
  - Version 2 - Import-Module
  - Version 3 - Dynamic importing
- PowerShell Gallery
- Discovering new commands
  - Get-Command -Module <Module>
  - Get-Command -Module <module> | Measure-Object
  - Get-Help <noun>

- Optimizing Shell Experience (Sydney/Jason)
- Plan this asa the NA demo --
- Include Demo text form NA
  - Predictors
  - PSGE v3 -- use this to start Crescendo
  - Crescendo
  - SecretManagement
  - PSGet V2/v3 ??

## Objects for the Admin (Jeff/Jason)

TODO: Update WMI examples to use CimCmdlets

- Object across the pipeline
  - How they flow
  - Get-Member
- Getting the information you need
  - Type Name
  - Methods
  - Properties
- Sorting Objects
  - Examples
    - Get-ChildItem | Get-Member #Property list
    - Get-ChildItem -Path c: | Sort-Object -property Length -Descending
    - Get-Process | Sort-Object -Property cpu -Descending
- Selecting Objects
  - Examples
    - Get-Service | Select-Object -Property Name, Status
    - Get-Process | Select-Object -Property Name, ID, VM, PM
    - Trick: Get-Command -Module <module> | Sort-Object -property noun | Get-Help | Select-Object -Property Name, Synopsis
- Custom Properties
  - Examples
    - Get-Service | Select-Object -Property Name, status , @{n='MyState';e={$_.Status}}
    - Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='c:'" | Select-Object -Property Freespace
    - Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='c:'" | Select-Object -Property @{n='FreeGB';e={$_.Freespace /1GB as [int]}}
- Filtering data
  - Comparison operators
    - Examples
  - Where-Object
    - Examples
  - -Filter
  - Filter left!
- Methods - when no cmdlet exists
  - Brief introduction into Methods
  - What if Stop-Service and Start-Service didn't exist?
  - Examples
    - Get-Service -Name bits | Get-Member #Use GM
    - Get-Service -Name bits | Foreach{$_.stop()}
    - $var=Get-Service bits #Vars in more detail later
    - $var.Start()

<!--
(REMOVE) - The pipeline: Deeper

- How the pipeline really works
- 4 Step solution
- 1- ByValue
  - Example - Get-Service | Stop-Service
- 2 - ByPropertyName
  - Example - Get-Service | Stop-Process
- 3- What if my property doesn't match
  - Custom property
  - Example:
    - Get-Adcomputer -Filter - | Select -ExpandProperty | Get-Service
- 4- Parenthetical - when all else fails
  - Example - Get-WmiObject -ComputerName ()
-->

## Overview of Docs (Sean)

- Overview of Docs platform features
  - Versions
  - Search & Filter
  - Conceptual vs reference
  - Navigation
- Structure of Docs and other docsets
  - Module browser
  - Utility modules
  - DSC
  - Community section
- Contributing

## Automation in Scale - Remoting (Jeff/Sydney)

- Overview of Remoting
- How to enable Remoting (WinRM/SSH)
- Not-Demo: Enabling PSRemoting (doc Link)
- Not-Demo: group Policy - (doc link)
- Not Demo: SSH setup - (doc link)Group Policy
- One-To-One
  - Enter-PSSession
    - Windows to Windows
    - Mac to Windows
- One-To-Many
  - Invoke-Command
- Not the end yet!
  - We still have the cool part - Sessions - but first let's start to automate.
- Reusable sessions
  - New-PSSession
- Using sessions with Invoke-Command
- Real-World Web server deployment
  - Example:
    - Deploy web-server to multiple computers
    - Deploy a website
- Creating automation scripts
- Getting command from anywhere - Implicit Remoting

## Introducing scripting and toolmaking (Jeff/Sean)

- Execution Policy
- Variables: A place to store stuff
- Making commands repeatable
  - Example - Get-WmiObject -class Win32_LogicalDisk
  - Example - GWMI -class win32_Bios
- Adding Parameters to your script
- Documenting your script
- Turning your script into a Advanced function
  - Example
    - Pram block with variables
    - Adding the properties to a hashtable
    - Creating your own object
- How about a Module?
  - A place to store your commands