#����ϣ��ת��Ϊ����

function ConvertHashTableToObject
{
	begin
	{
		$object = New-Object Object
	}
	process
	{
		$_.GetEnumerator() | ForEach-Object {
			Add-Member -inputObject $object -memberType NoteProperty -name $_.Name -value $_.Value
		}
	}
	end
	{
		$object
	}
}

#ʹ�÷�ʽ�������ɵĹ�ϣ��������ݸ�ConvertHashTableToObject�����������ϣ������$hashresult���棬��$hashresult | ConvertHashTableToObject