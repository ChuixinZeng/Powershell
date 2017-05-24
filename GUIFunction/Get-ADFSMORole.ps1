#��ȡAD�����еĲ���������ɫ
function Get-ADFSMORole
{
	
	Trap { "�����⵽���쳣: $($_.Exception.Message)"; Continue }
	
	# Query with the current credentials
	$ForestRoles = Get-ADForest
	$DomainRoles = Get-ADDomain
	
	
	# Define Properties
	$Properties = @{
		SchemaMaster = $ForestRoles.SchemaMaster
		DomainNamingMaster = $ForestRoles.DomainNamingMaster
		InfraStructureMaster = $DomainRoles.InfraStructureMaster
		RIDMaster = $DomainRoles.RIDMaster
		PDCEmulator = $DomainRoles.PDCEmulator
	}
	#New-Object -TypeName PSObject -Property $Properties
	
	$Properties
	
}