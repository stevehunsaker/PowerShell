# Initializing DataCore PowerShell Environment 
Import-Module 'c:\Program Files\DataCore\SANsymphony\DataCore.Executive.Cmdlets.dll'-Warningaction:SilentlyContinue

# 
# Define functions
#
#
function writeperf($Disks, $Timer)
	{
	$Disk = get-dcsvirtualdisk -virtualdisk $Disks
	$PerfCtr = Get-DcsPerformanceCounter $Disk.ID
	$PerfCtr_Lastrun = $PerfCtr
	Clear-Host	
	while ($true)
		{
		[Console]::SetCursorPosition(0,0)
		Write-Host $Disk.alias -ForegroundColor Red -NoNewline
		Write-Host " / Sample Time" $Timer "seconds"  
	
		$PerfCtr = Get-DcsPerformanceCounter $Disk.ID
		
		write-host "Transferred Bytes/s:       " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.TotalBytesTransferred - $PerfCtr_Lastrun.TotalBytesTransferred) / $Timer )
		
		write-host "Read Bytes/s:              " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.TotalBytesRead - $PerfCtr_Lastrun.TotalBytesRead) / $Timer )
				
		write-host "Write Bytes/s:             " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.TotalBytesWritten - $PerfCtr_Lastrun.TotalBytesWritten) / $Timer )
		
		write-host "Cache Read Hit Bytes/s:    " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheReadHitBytes - $PerfCtr_Lastrun.CacheReadHitBytes) / $Timer )
		
		write-host "Cache Read Miss Bytes/s:   " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheReadMissBytes - $PerfCtr_Lastrun.CacheReadMissBytes) / $Timer )
		
		write-host "Cache Write Hit Bytes/s:   " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheWriteHitBytes - $PerfCtr_Lastrun.CacheWriteHitBytes) / $Timer )
		
		write-host "Cache Write Miss Bytes/s:  " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheWriteMissBytes - $PerfCtr_Lastrun.CacheWriteMissBytes) / $Timer )
		write-host
		write-host
		write-host "IO/s:                      " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.TotalOperations - $PerfCtr_Lastrun.TotalOperations) / $Timer )
		
		write-host "Read IO/s:                 " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.TotalReads - $PerfCtr_Lastrun.TotalReads) / $Timer )
		
		write-host "Cache Read Hits/s:         " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheReadHits - $PerfCtr_Lastrun.CacheReadHits) / $Timer )
		
		write-host "Cache Read Misses/s:       " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheReadMisses - $PerfCtr_Lastrun.CacheReadMisses) / $Timer  )
		
		write-host "Write IO/s:                " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.TotalWrites - $PerfCtr_Lastrun.TotalWrites) / $Timer	 )
	
		write-host "Cache Write Hits/s:        " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheWriteHits - $PerfCtr_Lastrun.CacheWriteHits) / $Timer )
		
		write-host "Cache Write Misses/s:      " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.CacheWriteMisses - $PerfCtr_Lastrun.CacheWriteMisses) / $Timer )
		write-host
		write-host
		write-host "Init Percentage:           " -NoNewline
		"{0,15:N2}" -f ($PerfCtr.InitializationPercentage )
		
		write-host "Replication Bytes Sent/s:  " -NoNewline
		"{0,15:N2}" -f (($PerfCtr.ReplicationBytesSent - $PerfCtr_Lastrun.ReplicationBytesSent) / $Timer )
		
		write-host "Replication Bytes to send: " -NoNewline
		"{0,15:N2}" -f ($PerfCtr.ReplicationBytesToSend )
		
		write-host "Replication Time Lag:      " -NoNewline 
		"{0,15:N2}" -f ($PerfCtr.ReplicationTimeLag )
		write-host
		write-host
		write-host "Bytes Migrated/s:          " -NoNewline 
		"{0,15:N2}" -f (($PerfCtr.TotalBytesMigrated - $PerfCtr_Lastrun.TotalBytesMigrated) / $Timer )
		
		
	
		$PerfCtr_Lastrun = $PerfCtr
		sleep -Seconds $Timer
		}
	}


if ($args.count -eq 0)
	{
	Write-Host "Please specify a Virtual Disk to monitor!"
	}
	elseif ($args.count -eq 1)
	{
	$Disks = $args[0]
	writeperf $Disks 5
	}
	elseif ($args.count -eq 2)
	{
	$Disks = $args[0]
	$SampleTime =$args[1]
	writeperf $Disks $SampleTime
	}
