# Set execution policy
Set-ExecutionPolicy Unrestricted -Force
New-Item -ItemType directory -Path 'C:\temp'

# Initialize, partition and format the data disk
Get-Disk | Where PartitionStyle -eq 'raw' |
    Initialize-Disk -PartitionStyle MBR -PassThru |
    New-Partition -driveletter z -UseMaximumSize |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk" -Confirm:$false

# Create Directory in Z drive
mkdir z:\website-code

# Download website code from Github
Invoke-WebRequest https://raw.githubusercontent.com/ahmadzahoory/azopsv3/master/lab-bkp-code-w.zip -OutFile z:\website-code\lab-bkp-code-w.zip

# Unzip .zip file
Expand-Archive z:\website-code\lab-bkp-code-w.zip -DestinationPath z:\website-code

# Install IIS and Web Management Tools.
Import-Module ServerManager
install-windowsfeature web-server, web-webserver -IncludeAllSubFeature
install-windowsfeature web-mgmt-tools

#Change physical path of a site
Import-Module WebAdministration
Set-ItemProperty -path "IIS:\Sites\Default Web Site\" -name physicalPath -value "z:\website-code"

#Restart IIS
iisreset /restart

#Assigning file access rights to IIS_IUSRS
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\IIS_IUSRS", "FullControl", "Allow")
$acl = Get-ACL "z:\website-code"
$acl.AddAccessRule($accessRule)
Set-ACL -Path "z:\website-code" -ACLObject $acl

# End
