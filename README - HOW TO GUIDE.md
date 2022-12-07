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
4. Select a region to play on prior to launching the game - for Dclones! 
5. Allow you to set different settings on multiple clients: you can run the client you play on in High settings and the additional one on Low settings, so your PC can have an easier time handling it 
6. Set a priority of High in task manager for your HD game and AboveNormal for your LD(Low Definition) game. The low client will run without sound. 
7. All of this with one shortcut


What this script cannot do for you:
1. Work if you have double factor authentication enabled on your account(s) - there is a way for this to work, but I couldn't do it. If someone out there reads this and can help me implement it please contact me. 

If you see "EDIT_THIS" somewhere in the guide you're supposed to replace the value with whatever is the folder path that you chose on your PC.

1. Go to https://github.com/boianstefanov/D2R-instances-launcher, click on Code > Download ZIP
2. Next, we need to save a snapshot of your HD settings. Log in the game as you normally would and tweak all desired options. Exit the game. 
3. Go to C:\Users\EDIT_THIS\Saved Games\Diablo II Resurrected, copy the Settings.json file 
4. Paste(and replace) the Settings.json file in \D2R_Script\HDSettings
5. Log in the game again, tweak all desired options (in this case to Low). Exit the game.
6. Go to C:\Users\EDIT_THIS\Saved Games\Diablo II Resurrected and copy the Settings.json file again
7. Paste(and replace) the Settings.json file in \D2R_Script\LDSettings
8. Open Powershell and run the command** - it will ask you for credentials, input them for account1:

(Get-Credential).Password | ConvertFrom-SecureString | Out-File "EDIT_THIS\D2R_Script\account1.txt"

**This secures your account credentials 

9. Run the same command again, but this time use  account2.txt file for your second account - EDIT_THIS\D2R_Script\account2.txt"
10. Edit (can be done with Windows PowerShell ISE or notepad) the "D2R_Force_LDsettings.ps1" file 
11. Look for "EDIT_THIS" and replace the file path(s) accordingly. Example below:
The first occurrence of EDIT_THIS:
$secure_file_path = "EDIT_THIS\D2R_Script\account2.txt" 
We're replacing it with 
$secure_file_path = "C:\Users\Username\Desktop\D2R_Script\account2.txt"
12. Change the $username = "your_email_here@example.com" to your actual email for battle.net
13. Save your changes.
14. Do the same for the D2R_Force_HDsettings.ps1 file 
15. You can now create shortcuts to D2R_Force_HDsettings.ps1 and D2R_Force_LDsettings.ps1, rename them to whatever you want and play the game! 

OPTIONAL - if you don't want to press Yes/No every time and have the powershell window hidden:

16. Open your start menu and search for Task Scheduler, run it.
17. On the left side, right click Task Scheduler Library folder > New folder. Call it "D2R", press OK
18. Go inside the D2R folder you just created and right click > "Create Task..." For name write anything you want, for example - "Run D2R without admin rights LD"
19. Select "Run only when user is logged on" if it's not checked by default
20. Check the box "Run with highest privileges"
21. From the drop down menu "Configure for:" select "Windows 10"
22. Go to "Actions" tab, click "New..."
23. In the "Program/script:" field paste this: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
24. For Add arguments paste this: -WindowStyle hidden EDIT_THIS\D2R_Script\D2R_Force_LDsettings.ps1
25. Press OK
26. Go back to General tab
27. Under Security options click on "Change User or Group..." and write: NAME_OF_YOUR_PC\YOUR_USERNAME_HERE
28. If you're not sure what the NAME_OF_YOUR_PC or YOUR_USERNAME_HERE is: check it by opening command prompt on your PC and type "whoami" then press Enter
29. Click "Check Names" on the right, then OK
30. Press OK to save the scheduled task 
31. Go to your desktop and right click > New > shortcut 
32. In the type the location of the item paste this: C:\Windows\System32\schtasks.exe /RUN /TN "D2R\Run D2R without admin rights LD"
33. You must follow step 17-32 again to do the same for the other (HD) shortcut - this is an example how to setup the LD one

******** Frequently asked questions ********

Do I need to download any additional software for this?

Analogical to the ProcessExplorer's tutorials we need to use (basically the same thing) called Handler, it's in the Git repository, for your convenience. It's by Microsoft's sysinternals and can be officially downloaded here: https://docs.microsoft.com/en-us/sysinternals/downloads/handle

Can I get banned for using this?

As far as I'm aware the usage of the script should not get you banned. It requires you to buy 2 copies of the game and have 2 separate battle.net accounts. We're not automating anything in the game.

Can I modify parts of your script?

I've added comments in my script showcasing what I'm doing and what the commands are used for. If you're tech savy - yes, feel free to contribute on GitHub!
