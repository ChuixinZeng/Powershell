﻿Get-DnsServerResourceRecord -ZoneName “_msdcs.contoso.com” |
Where-Object {$_.RecordData.IPv4Address -eq "192.168.50.15"
-or $_.RecordData.NameServer -eq “DC02.contoso.com.” -or `
$_.RecordData.DomainName -eq “DC02.contoso.com.”} | Remove-DnsServerResourceRecord -ZoneName “_msdcs.contoso.com” -force

# https://devblogs.microsoft.com/scripting/86099-2/