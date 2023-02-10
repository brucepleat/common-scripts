@Echo Off
If Exist "%download%\IP_Ping.txt" Del "%download%\IP_Ping.txt"
@For %%S in (86 87) do @For /L %%A in (1,1,255) do (
  Echo 192.168.%%S.%%A
  (@ping -n 1 192.168.%%S.%%A | find "Reply from " ) >> "%download%\IP_ping.txt"
)

arp -a -v | grep "192.168." | grep -v invalid | find "  " | sed s/-/:/g | tr [:lower:] [:upper:] > "%download%\IP_arp.txt"

notepad "%download%\IP_arp.txt"
