@Echo Off

Echo.
Echo Trying to add P:
If Not Exist P: Subst P: %dropbox%
If Exist P: Echo P: Added
If Not Exist P: Echo P: Could not be added

Echo.
Echo Trying to add S:
If Not Exist S: Net Use S: \\NAS\Storage /Persistent:Yes
If Exist S: Echo S: Added
If Not Exist S: Echo S: Could not be added

Echo.
Echo Trying to add W:
If Not Exist W: Net Use W: \\192.168.86.23\Storage 077586079 /user:root /Persistent:Yes
If Exist W: Echo W: Added
If Not Exist W: Echo W: Could not be added

Echo.
Echo Drives:
For %%D in (P S W) do if exist "%%D:" (echo. & dir %%D:\ | head -1 & dir %%D:\ | tail -1)

Echo.
Call Drives.bat
