# Title: A.A.VM or Always A Virtual Machine
# Last modified: 31/07/2024
# Description: A Massive list of Virtual Machine crap to scare away AVM (Anti Virtual Machine) Malware.
#
# License: https://github.com/PrimeMonket/Always-A-Virtual-Machine/
# Author: https://github.com/PrimeMonket/
#
# GitHub issues: https://github.com/Always-A-Virtual-Machine/issues
# GitHub pull requests: https://github.com/PrimeMonket/Always-A-Virtual-Machine/pulls

#Window Variables
#Check for administrator.
$admin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent() `
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

#registries
#Loop to check and add registry key or key data
function check_registry {
    param (
        [string]$company,
        [string]$path,
        [string]$name,
        [string]$value
    )

    $regPath = "$path"

      #Check registry path, create if not
    if (-not (Test-Path -Path $regPath)) {
        New-Item -Path $regPath -Force | Out-null
        Write-Host "[[38;2;94;214;114m$company[0m] - Key created in ==> $path."
    } else {
        Write-Host "[[38;2;239;75;75m$company[0m] - Key already exists in ==> $path."
    }

      #If name + value are provided, check registry key exists
    if ($name -and $value) {
        try {
            $existingValue = (Get-ItemProperty -Path $regPath -Name $name -ErrorAction Stop).$name
            Write-Host "[[38;2;239;75;75m$company[0m] - $name key already exists in ==> $path with value $existingValue."
        } catch {
            New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType String | Out-null
            Write-Host "[[38;2;94;214;114m$company[0m] - $name key created in ==> $path with value $value."
        }
    }
}



function check_Directory {
    param (
        [string]$company,
        [string]$path,
        [string]$name
    )

    $DirectoryPath = "$path"

      #Check directory path exists, create if not
    if (-not (Test-Path -Path $DirectoryPath)) {
        New-Item -Path $DirectoryPath -ItemType Directory -Force | Out-null
        Write-Host "[[38;2;94;214;114m$company[0m] - Directory created in ==> $path."
    } else {
        Write-Host "[[38;2;239;75;75m$company[0m] - Directory already exists in ==> $path."
    }

      #Check if file exists in directory, if a name is set
    if ($name) {
        $FilePath = Join-Path -Path $DirectoryPath -ChildPath $name
        if (-not (Test-Path -Path $FilePath)) {
            #Create an empty file as a placeholder
            New-Item -Path $FilePath -ItemType File -Force | Out-Null
            Write-Host "[[38;2;94;214;114m$company[0m] - $name file created in ==> $path with name $name."
        } else {
            Write-Host "[[38;2;239;75;75m$company[0m] - $name file already exists in ==> $path with name $name."
        }
    }
}



  #List of keys to be checked and created if not (has values)
$registryKeys = @(
      
    #KVM
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\vioscsi" },
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\viostor" },
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\VirtIO-FS Service" },
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\VirtioSerial" },
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\BALLOON" },
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\BalloonService" },
    @{ company = "KVM"; path = "HKLM:\SYSTEM\ControlSet001\Services\netkvm" },

    #PARRALLELS
    @{ company = "PARALLELS"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1AB8" },
      
    #Hypver-V
    @{ company = "Hyper-V"; path = "HKLM:\SOFTWARE\Microsoft\Hyper-V"},
    @{ company = "Hyper-V"; path = "HKLM:\SOFTWARE\Microsoft\VirtualMachine"},
    @{ company = "Hyper-V"; path = "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters"},
    @{ company = "Hyper-V"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmicheartbeat" },
    @{ company = "Hyper-V"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmicvss" },
    @{ company = "Hyper-V"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmicshutdown" },
    @{ company = "Hyper-V"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmicexchange" },
    @{ company = "Hyper-V"; path = "HKLM:\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\Protocol_Catalog9\Catalog_Entries"; Name = "ProtocolName"; Value = "Hyper-V RAW" },
      
    #VirtualBox
    @{ company = "VBOX"; path = "HKLM:\HARDWARE\ACPI\DSDT\VBOX__\" },
    @{ company = "VBOX"; path = "HKLM:\HARDWARE\ACPI\FADT\VBOX__\" },
    @{ company = "VBOX"; path = "HKLM:\HARDWARE\ACPI\RSDT\VBOX__\" },
    @{ company = "VBOX"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_80EE" },
    @{ company = "VBOX"; path = "HKLM:\SOFTWARE\Oracle\VirtualBox Guest Additions"},
    @{ company = "VBOX"; path = "HKLM:\SYSTEM\ControlSet001\Services\VBoxGuest" },
    @{ company = "VBOX"; path = "HKLM:\SYSTEM\ControlSet001\Services\VBoxMouse" },
    @{ company = "VBOX"; path = "HKLM:\SYSTEM\ControlSet001\Services\VBoxService" },
    @{ company = "VBOX"; path = "HKLM:\SYSTEM\ControlSet001\Services\VBoxSF" },
    @{ company = "VBOX"; path = "HKLM:\SYSTEM\ControlSet001\Services\VBoxVideo" },
      
    #VMware
    @{ company = "VMWARE"; path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"; name = "DisplayName"; value = "vmware tools" },
    @{ company = "VMWARE"; path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VMware tools" },
    @{ company = "VMWARE"; path = "HKLM:\SOFTWARE\VMware, Inc.\VMware Tools" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000"; name = "CoInstallers32"; value = "vmx" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000"; name = "DriverDesc"; value = "VMware" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000"; name = "InfSection"; value = "vmx" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000"; name = "ProviderName"; value = "VMware" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Control\Class\{4D36E968-E325-11CE-BFC1-08002BE10318}\0000\Settings"; name = "Device Description"; value = "VMware" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_15AD" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\IDE\CdRomNECVMWar_VMware_IDE_CD" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\CdRomNECVMWar_VMware_SATA_CD" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\DiskVMware_Virtual_SATA_Hard_Drive" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmdebug" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmmouse" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\VMTools" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\VMMEMCTL" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmware" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmci" },
    @{ company = "VMWARE"; path = "HKLM:\SYSTEM\ControlSet001\Services\vmx86" },
    @{ company = "VMWARE"; path = "HKCU:\SOFTWARE\VMware, Inc.\VMware Tools" },
      
    #Sandboxie
    @{ company = "Sandboxie"; path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Sandboxie"},
    @{ company = "Sandboxie"; path = "HKLM:\SYSTEM\CurrentControlSet\Services\SbieDrv" },
      
    #Wine
    @{ company = "Wine"; path = "HKLM:\SOFTWARE\Wine"},
    @{ company = "Wine"; path = "HKCU:\SOFTWARE\Wine"},
      
    #VirtualPC
    @{ company = "VirtualPC"; path = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_5333" },
    @{ company = "VirtualPC"; path = "HKLM:\SYSTEM\ControlSet001\Services\vpcbus" },
    @{ company = "VirtualPC"; path = "HKLM:\SYSTEM\ControlSet001\Services\vpc-s3" },
    @{ company = "VirtualPC"; path = "HKLM:\SYSTEM\ControlSet001\Services\vpcuhub" },
    @{ company = "VirtualPC"; path = "HKLM:\SYSTEM\ControlSet001\Services\msvmmouf" },
      
    #general
    @{ company = "General"; path = "HKLM:\SOFTWARE\Classes\Folder\shell\sandbox"},
      
    #XEN
    @{ company = "XEN"; path = "HKLM:\HARDWARE\ACPI\DSDT\xen"},
    @{ company = "XEN"; path = "HKLM:\HARDWARE\ACPI\FADT\xen"},
    @{ company = "XEN"; path = "HKLM:\HARDWARE\ACPI\RSDT\xen"}
    @{ company = "XEN"; path = "HKLM:\SYSTEM\ControlSet001\Services\xenevtchn" },
    @{ company = "XEN"; path = "HKLM:\SYSTEM\ControlSet001\Services\xennet" },
    @{ company = "XEN"; path = "HKLM:\SYSTEM\ControlSet001\Services\xennet6" },
    @{ company = "XEN"; path = "HKLM:\SYSTEM\ControlSet001\Services\xensvc" },
    @{ company = "XEN"; path = "HKLM:\SYSTEM\ControlSet001\Services\xenvdb" }
)




#Directories
#qemu kvm {(general) virtual machine files} cuckoo
$DirectoryLocations = @(
      
    #General
    @{ Company = "General"; path = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"; name = "agent.pyw" },
      
    #QEMU
    @{ Company = "QEMU"; path = "C:\Program Files\qemu-ga\" },
    @{ Company = "QEMU"; path = "C:\Program Files\SPICE Guest Tools\" },
      
    #KVM
    @{ Company = "KVM"; path = "C:\Program Files\Virtio-Win\" },
      
    #Cuckoo
    @{ Company = "Cuckoo"; path = "C:\Cuckoo\" }
      
    #CWSandbox
    @{ company = "CWSandbox"; path = "C:\analysis\"}

    #VirtualBox
    @{ company = "VBOX"; path = "C:\program files\oracle\virtualbox guest additions\"}
)

foreach ($Directory in $DirectoryLocations) {
    $Directorys = (check_Directory -company $Directory.company -path $Directory.path -name $Directory.name)
}

foreach ($key in $registryKeys) {
    $Registries = (check_registry -company $key.company -path $key.path -name $key.name -value $key.value) 
}

$results = $Directorys + $Registries
Write-Host $results
#Write-Host $CoreOS

#$logFilePath = "AAVM.log"
#New-Item -Path $logFilePath -ItemType File -Force | Out-Null

# Append the directories to the log file
#Add-Content -Path "./AAVM.log" -Value $Directorys

Write-Host("[38;2;94;214;114m[-] A.A.VM has manipulating the system, check the log file or CLI for system chnages.");
Write-Host("[38;2;94;214;114mTO help support the project:");
Write-Host("[38;2;94;214;114m    https://github.com/PrimeMonket/Always-A-Virtual-Machine/ ");
Write-Host("[38;2;94;214;114m    https://github.com/kernelwernel/VMAware/ ")
Write-Host("[38;2;94;214;114m    https://github.com/a0rtega/pafish/ ")
