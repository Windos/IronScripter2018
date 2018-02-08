function Get-DiskInformation {
    [CmdletBinding()]

    param (
        [Parameter()]
        [ValidateScript({ Validate-Computername -ComputerName $_ })]
        [string] $ComputerName = $env:COMPUTERNAME
    )

    try {
        $OS = Get-CimInstance -ComputerName $ComputerName -ClassName 'Win32_OperatingSystem' -ErrorAction Stop
        Write-Verbose -Message "Retrieved 'Win32_OperatingSystem' from $ComputerName."
        Write-Debug -Message $OS
    } catch {
        throw "Error retrieving 'Win32_OperatingSystem' from $ComputerName. You may need to configure WinRM on the target computer."
    }

    try {
        $Disks = Get-CimInstance -ComputerName $ComputerName -ClassName 'Win32_LogicalDisk' -ErrorAction Stop
        Write-Verbose -Message "Retrieved 'Win32_LogicalDisk' from $ComputerName."
        foreach ($Disk in $Disks) {
            Write-Debug -Message $Disk
        }  
    } catch {
        throw "Error retrieving 'Win32_LogicalDisk' from $ComputerName. You may need to configure WinRM on the target computer."
    }

    try {
        foreach ($Disk in $Disks) {
            if ($Disk.Size -ne $null) {
                $UsagePercent = New-PercentBar -Percent (($Disk.Size - $Disk.FreeSpace)/$Disk.Size)
            } else {
                $UsagePercent = ''
            }

            $DiskObj = [PSCustomObject] [Ordered] @{
                ComputerName = $ComputerName
                OSName = $OS.Caption
                Version = $OS.Version
                ServicePack = "$($OS.ServicePackMajorVersion).$($OS.ServicePackMinorVersion)"
                Manufacturer = $OS.Manufacturer
                WindowsDirectory = $OS.WindowsDirectory
                Locale = $OS.Locale
                FreePhysicalMemory = $OS.FreePhysicalMemory
                FreePhysicalMemoryGB = [Math]::Round(($OS.FreePhysicalMemory * 1024) / 1GB, 2)
                TotalVirtualMemorySize = $OS.TotalVirtualMemorySize
                TotalVirtualMemorySizeGB = [Math]::Round(($OS.TotalVirtualMemorySize * 1024) / 1GB, 2)
                FreeVirtualMemory = $OS.FreeVirtualMemory
                FreeVirtualMemoryGB = [Math]::Round(($OS.FreeVirtualMemory * 1024) / 1GB, 2)
                DeviceID = $Disk.DeviceID
                DiskDescription = $Disk.Description
                DiskSize = $Disk.Size
                DiskSizeGB = [Math]::Round($Disk.Size / 1GB, 2)
                DiskFreeSpace = $Disk.FreeSpace
                DiskFreeSpaceGB = [Math]::Round($Disk.FreeSpace / 1GB, 2)
                Usage = $UsagePercent
                Compressed = $Disk.Compressed
                PSTypeName = 'DiskInfo'
            }

            Set-DefaultPropertySet -Object $DiskObj -DisplaySet 'ComputerName', 'DeviceID', 'DiskSizeGB', 'Usage'
            $DiskObj

            Write-Debug -Message $DiskObj
        }
    } catch {
        throw "Failed to get disk information for computer $ComputerName"
    }
}
