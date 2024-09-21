# D2R-instances-launcher

### This guide is brought to you by - boianst - a fellow D2R gamer | Contact me at: boianst#6545 on Discord  ###

Use this script at your own risk!

This guide is recommended for technical savy people, but I'll try to explain it in simple terms, so more people are able to implement it. 

This script assumes you want to run 2 D2R clients* - one with HD settings and one with the lowest possible settings and you don't have double factor authentication enabled for your battle.net account. See more about this in the "What this script cannot do for you" section.

*More clients can be added, you'll just need to create more shortcuts


What this script will do for you:
1. Launch more than one instance of D2R - no more manually doing it through ProcessExplorer
2. It will let you do it WITHOUT copying the game multiple times on your drive
3. Allows you to login without having to use battle.net or multiple instances of it
4. Select a region to play on prior to launching the game - for Dclones! The default for this is Europe(ENTER can be used also), you can change the default in the script by editing row 106 of the script file(s)
5. Allow you to set different settings on multiple clients: you can run the client you play on in High settings and the additional one on Low settings, so your PC can have an easier time handling it 
6. Set a priority of High in task manager for your HD game and AboveNormal for your LD(Low Definition) game. The low client will run without sound. This is optional, can you remove "-ns" and it will play with sound on.  
7. All of this with one shortcut
8. This script waits for 10 seconds by default before it kills the handler for Check for additional instances. Be aware of this when launching >2 clients if that's the case. This can be changed in the script by editing "Start-Sleep 10" with whaever else value you want (10 being the seconds). 

What this script cannot do for you:
1. Work if you have double factor authentication enabled on your account(s) - there is a way for this to work, but I couldn't do it. If someone out there reads this and can help me implement it please contact me. 

If you see "EDIT_THIS" somewhere in the guide you're supposed to replace the value with whatever is the folder path that you chose on your PC.

> __Warning__ Be careful about the EDIT_THIS steps. If something doesn't work check that you have the correct path!  

0. Make sure your MFA is disabled, see the 'What this script cannot do for you' section
1. Go to https://github.com/boianstefanov/D2R-instances-launcher, click on Code > Download ZIP
2. Extract the ZIP, copy it and put it into a folder of your choice, for example EDIT_THIS\D2R_Script (Note: the default folder name is D2R-Script-main)
3. Next, we need to save a snapshot of your HD settings. Log in the game as you normally would and tweak all desired options. Exit the game. 
4. Go to C:\Users\EDIT_THIS\Saved Games\Diablo II Resurrected, copy the Settings.json file 
5. Paste(and replace) the Settings.json file in \D2R_Script\HDSettings
6. Log in the game again, tweak all desired options (in this case to Low). Exit the game.
7. Go to C:\Users\EDIT_THIS\Saved Games\Diablo II Resurrected and copy the Settings.json file again
8. Paste(and replace) the Settings.json file in \D2R_Script\LDSettings
9. Open Powershell and run the command** - it will ask you for credentials (for battle.net), input them for account1:

(Get-Credential).Password | ConvertFrom-SecureString | Out-File "EDIT_THIS\D2R_Script\account1.txt"

You could use notepad first, to replace the EDIT_THIS value here, then paste it into PowerShell, that makes it easier. 

**This secures your account credentials 

9. Run the same command again, but this time use  account2.txt file for your second account credentials (for battle.net)- "EDIT_THIS\D2R_Script\account2.txt" 
10. Edit (can be done with Windows PowerShell ISE or notepad) the "D2R_Force_HDsettings.ps1" file 
11. Look for "EDIT_THIS" and replace the file path(s) accordingly. Example below:
The first occurrence of EDIT_THIS:

$secure_file_path = "EDIT_THIS\D2R_Script\account1.txt" 
We're replacing it with 
$secure_file_path = "C:\Users\Username\Desktop\D2R_Script\account1.txt"

12. Change the $username = "your_email_here@example.com" to your actual email for battle.net
13. Save your changes.
14. Do the same for the D2R_Force_LDsettings.ps1 file 
15. You can now create shortcuts to D2R_Force_HDsettings.ps1 and D2R_Force_LDsettings.ps1 by right clicking on each .ps1 file > Create Shortcut. 
16. Then, right click > Properties > General tab > Change... > More apps > scroll down > Look for another app on this PC and select powershell.exe located in C:\WINDOWS\system32\WindowsPowerShell\v1.0\ > Open > Apply > OK 

OPTIONAL - if you don't want to press Yes/No every time and have the powershell window hidden:

16. Open your start menu and search for Task Scheduler, run it.
17. On the left side, right click Task Scheduler Library folder > New folder. Call it "D2R", press OK
18. Go inside the D2R folder you just created and right click > "Create Task..." For name write anything you want, for example - "Run D2R without admin rights HD"
19. Select "Run only when user is logged on" if it's not checked by default
20. Check the box "Run with highest privileges"
21. From the drop down menu "Configure for:" select "Windows 10"
22. Go to "Actions" tab, click "New..."
23. In the "Program/script:" field paste this: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
24. For Add arguments paste this: -WindowStyle hidden EDIT_THIS\D2R_Script\D2R_Force_HDsettings.ps1
25. Press OK
26. Go back to General tab
27. Under Security options click on "Change User or Group..." and write: NAME_OF_YOUR_PC\YOUR_USERNAME_HERE
28. If you're not sure what the NAME_OF_YOUR_PC or YOUR_USERNAME_HERE is: check it by opening command prompt on your PC and type "whoami" then press Enter
29. Click "Check Names" on the right, then OK
30. Press OK to save the scheduled task 
31. Go to your desktop and right click > New > shortcut 
32. In the type the location of the item paste this: C:\Windows\System32\schtasks.exe /RUN /TN "D2R\Run D2R without admin rights HD"
33. You must follow step 17-32 again to do the same for the other (LD) shortcut - this is an example how to setup the HD one

******** Frequently asked questions ********

Do I need to download any additional software?

Analogical to the ProcessExplorer's tutorials we need to use (basically the same thing) called Handler, it's in the Git repository, for your convenience. It's by Microsoft's sysinternals and can be officially downloaded here: https://docs.microsoft.com/en-us/sysinternals/downloads/handle

Can I get banned for using this?

As far as I'm aware the usage of the script should not get you banned. It requires you to buy 2 copies of the game and have 2 separate battle.net accounts. We're not automating anything in the game.

Can I modify parts of your script?

I've added comments in my script showcasing what I'm doing and what the commands are used for. If you're tech savy - yes, feel free to contribute on GitHub!

I have created the task in task scheduler, but it doesn't do anything?

Open task scheduler and check the task. Go to actions, check the paramters, make sure you inputted the path instead of EDIT_THIS. Verify that the task author is YOUR_PC_HERE\YOUR_USERNAME_HERE
> __Warning__ Be careful about the EDIT_THIS steps. If something doesn't work check that you have the correct path! 

My powershell script doesn't work and just disappears?
This is being caused by powershell's encoding. To bypass it, use the RAW format by clicking the file and RAW in the top right(on GitHub). Copy and paste the content of the RAW file on GitHub to the powershell file and save it, and after that edit the paths again (EDIT_PATH). Make sure you do this for both .ps1 files. 
