# Initializing DataCore PowerShell Environment 
Import-Module 'c:\Program Files\DataCore\SANsymphony\DataCore.Executive.Cmdlets.dll'-Warningaction:SilentlyContinue

# 
# Define functions
#
#
function writeprofile([string]$DiskName,[string]$FindProfile)
	{
	$Disk = get-dcsvirtualdisk -virtualdisk $DiskName
	$DiskProfile = get-dcsstorageprofile -storageProfile $Disk.StorageProfileID
	if ($FindProfile -eq $DiskProfile.Alias -or $FindProfile -eq "any" -or $FindProfile -eq "")
		{
		Write-Host $DiskProfile.Alias -ForegroundColor Yellow -NoNewline
		Write-Host ": " -NoNewline
		Write-Host $Disk.Alias
		}
	}
	
	
# Read out commandline arguments
if ($args.count -eq 0)
	{
	Write-Host "Command works like this:"
	Write-Host "get-dcsvirtualdiskprofile.ps1 -virtualdisk <Name of VDisk | All>"
	Write-Host "get-dcsvirtualdiskprofile.ps1 -profile <Name of profile | Any>"
	}
	else
	{
	$DcsVirtualDisk = -1
	$DcsProfile = -1 
	$counter = -1
	$args | foreach {
		$counter = $counter + 1
		switch ($_)
			{
			-virtualdisk
				{
				$DcsVirtualDisk = $counter
				}	
			-profile
				{
				$DcsProfile = $counter
				}		
			}
		}
	if ($DcsVirtualDisk -gt -1)
		{
		$Disks = $args[$DcsVirtualDisk + 1]
		if ($Disks -contains "*")
			{
			write-host "Wildcard Operation not yet done."
			}
		elseif ($Disks -eq "All")
			{
			$Disks = get-dcsvirtualdisk
			$Disks | foreach { writeprofile $_.Alias} 
			
			}
		else
			{
			writeprofile $Disks
			}
		}
	if ($DcsProfile -gt -1)
		{
		$Disks = get-dcsvirtualdisk
		$DcsProfilename = $args[$DcsProfile + 1]
		$Disks | foreach { writeprofile $_.Alias $DcsProfilename} 
		}
	}
	

	
	
