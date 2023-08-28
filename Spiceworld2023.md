# Be immediately effective in PowerShell

## Based on timing plan - you have 15 minutes of padding

## Don't fear the shell - Jason (Intros + Don't Fear - 20 min)

- Native command
- Verb-Noun
- Aliases
- Help & Get-Command
- Using PSDrives

## Installing PowerShell 7 - Sean - 15 min

- Why is it not in Windows? - Jason
- See install docs
- Github Assets - click download button and show assets
- Side-by-side with PS5.1
  - [Migrating from Windows PowerShell 5.1 to PowerShell 7](/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7)
  - [Differences between Windows PowerShell 5.1 and PowerShell 7.x](/powershell/scripting/whats-new/differences-from-windows-powershell)
  - [Release history of modules and cmdlets](/powershell/scripting/whats-new/cmdlet-versions)
  - [about Windows PowerShell Compatibility](/powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility)

## Command discovery - Jeff/Jason/Sean - 20 min

- Module Overview -Jason
  - Built-in
  - Ship with MS Products (Windows, SQL, etc.)
  - Intro PSGallery
- Finding commands on your system - Jeff
  - Get-Command
  - Module commands - get-module, import-module
- Finding modules to install - Sean
  - Module Browser
    - https://learn.microsoft.com/en-us/powershell/module/
  - PS Gallery search
    - https://www.powershellgallery.com/
    - PSResourceGet - https://learn.microsoft.com/powershell/module/microsoft.powershell.psresourceget/?view=powershellget-3.x

## Help & Docs - Sean - 20 min

- PowerShell Help System
  - Get-Help and Update-Help
  - Understanding Syntax
- Online documentation
  - How to find help
- Other help options - https://learn.microsoft.com/powershell/#community-resources
  - StackOverflow, Discord/Slack, Spiceworks, PowerShell.org
    - https://community.spiceworks.com/programming/powershell
    - https://aka.ms/psslack
    - https://aka.ms/psdiscord
- PowerShell blogs

## Interactive vs. Automation - 30 min - 

- Other hosts - Jason
  - Windows Terminal vs. Conhost
  - VS Code
  - Cloud Shell

- Creating simple batch-oriented scripts - Jeff
  - Using VS Code & PS Extension
  - Using variables
  - Execution policy & unblock (mark of the web for Windows and macOS)

- PowerShell remoting for scale-out - Jeff
  - What is it?

## Intelligent shell - Jason/Sean - 30 min

- PSReadLine - Jason
- Tab completion - Jason
- Predictors - Jason
- Putting all together in your Profile - Sean
  - https://learn.microsoft.com/powershell/scripting/learn/shell/optimize-shell
  - What is the Profile?
  - Configuring PSReadLine
  - Come to Sean's session for profiles

## Advanced features - Jeff - land us - 30 min

- Using alternate credentials
- Jeff's AD examples and using PSDrives
