# Beginning PowerShell Workshop

## Introduction

- Introduce the team
- Why PowerShell Matters 
  - Management and Automation at scale
  - Sacred promise
  - Optimizing the user, not the product. (empowering you)
- Don't fear the Shell
  - Win:ps7 - native commands
    - Dir/ Cls, HELP, notepad, calc
    - Ls, MAN  -- need help have to call a man
    - How?  Aliases -- 
    - Why?
  - Mac:ps7 - native commands
    - ls -- but still has Dir
  - Cmdlet - Verb-Noun
    - Get-PRocess Get-Service
    - mac: Get-Process -- no Get-Service - cause they aint got those -- windows
  - Aliases - Get-Alias -- GAL -- I love powershell - Man and GAL!
  - Scripts - notepad .\runme.ps1  (Get-service -name bits)

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
    - Brief: Multi versions - CloudShell

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
    - Get-hellp Get-Service 
    - Get-Help Get-Process then Stop-Process
- Real-world
  - Examples of discovering and solving
    - Get-Service -Name bits
    - Stop-Service
    - Start-service

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
    - Get-CimInstance -ClassName win32_logicalDisk -filter "DeviceID='C:'" | Select-Object
      -Property @{n='FreeGB';e={$_.Freespace /1GB -as [int]}}
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
