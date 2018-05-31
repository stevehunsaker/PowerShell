
$Computer = "localhost"
$disk = get-wmiobject Win32_LogicalDisk -computer $computer
$disksize = "Disk Size (MB)"
$freespace = "Free Space (MB)" 
" {0,18:n} {1,17:n} " -f $disksize, $freespace
ForEach ($disk in $disk)
{
" {0} {1,15:n} {2,15:n}" -f $disk.DeviceID, ($disk.Size/1000), $($disk.freespace/1000)
}