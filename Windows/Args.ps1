function test-conn
{
Test-Connection -Count 3 -ComputerName $args
#args�䵱ռλ�������ã����ռλ��������args������������ʶ�𣬻��׳��쳣
}
Set-Alias tc Test-Conn
tc localhost
���

'''
tc localhost

Source        Destination     IPV4Address      IPV6Address
------        -----------     -----------      -----------
5CD60537FF    localhost       127.0.0.1        ::1
5CD60537FF    localhost       127.0.0.1        ::1
5CD60537FF    localhost       127.0.0.1        ::1
'''