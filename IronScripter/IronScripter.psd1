@{
    RootModule = 'IronScripter.psm1'
    ModuleVersion = '0.0.2'
    GUID = 'e239b1f6-2922-4b69-a2bb-b008005eb544'
    Author = 'Joshua (Windos) King'
    CompanyName = 'king.geek.nz'
    Copyright = '(c) 2018 Joshua (Windos) King. All rights reserved.'
    Description = "Windos' Iron Scripter 2018 'solutions'"
    PowerShellVersion = '5.1'
    RequiredModules = @('PoshPctBar', 'DefaultPropertySetter')
    FunctionsToExport = 'Get-MonitorInformation'
    CmdletsToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = @('IronScripter', 'PSHSummit')
            LicenseUri = 'https://github.com/Windos/IronScripter2018/blob/master/LICENSE'
            ProjectUri = 'https://github.com/Windos/IronScripter2018'
            IconUri = ''
            ReleaseNotes = '
* v0.0.2
  * Puzzle 2
  * Get-DiskInformation.ps1 (Public)
* v0.0.1
  * Puzzle 1
  * Get-MonitorInformation.ps1 (Public)
  * Validate-ComputerName.ps1 (Private)
'
        }
    }
}
