######## This script is brought to you by - boianst - a fellow D2R gamer ########
######## Contact me at: boianst#6545 on Discord  ########


######## This allows us to run scripts on the system and perform it as an Administrator ########
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

######## Secure credentials ########

# Use (Get-Credential).Password | ConvertFrom-SecureString | Out-File "EDIT_THIS\D2R_Script\account2.txt
# EDIT THIS:
$secure_file_path = "EDIT_THIS\D2R_Script\account2.txt"

$EncryptedData = Get-Content $secure_file_path
$PasswordSecureString = ConvertTo-SecureString $EncryptedData
$cred = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($PasswordSecureString))


######## Force LD settings before launching ########
# EDIT THIS:
$ld_settings_path = "EDIT_THIS\D2R_Script\LDsettings\Settings.json"
$D2R_SETTINGS_PATH = "C:\Users\EDIT_THIS\Saved Games\Diablo II Resurrected\Settings.json"

Copy-Item -Path $ld_settings_path -Destination $D2R_SETTINGS_PATH -Force
Start-Sleep 1

######## Launch the game ########
# EDIT THIS:
$PSScriptLauncher = "EDIT_THIS\Diablo II Resurrected"
$username = "your_email_here@example.com"

####### Region Selector, credit to DBremen via GitHub ########
#An alternative to the built-in PromptForChoice providing a consistent UI across different hosts
#Credit to  DBremen on GitHub
function Get-Choice {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true,Position=0)]
        $Title,

        [Parameter(Mandatory=$true,Position=1)]
        [String[]]
        $Options,

        [Parameter(Position=2)]
        $DefaultChoice = -1
    )
    if ($DefaultChoice -ne -1 -and ($DefaultChoice -gt $Options.Count -or $DefaultChoice -lt 1)){
        Write-Warning "DefaultChoice needs to be a value between 1 and $($Options.Count) or -1 (for none)"
        exit
    }
    Add-Type –AssemblyName System.Windows.Forms
    Add-Type –AssemblyName System.Drawing
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $script:result = ""
    $form = New-Object System.Windows.Forms.Form
    $form.FormBorderStyle = [Windows.Forms.FormBorderStyle]::FixedDialog
    $form.BackColor = [Drawing.Color]::White
    $form.TopMost = $True
    $form.Text = $Title
    $form.ControlBox = $False
    $form.StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    #calculate width required based on longest option text and form title
    $minFormWidth = 100
    $formHeight = 44
    $minButtonWidth = 70
    $buttonHeight = 23
    $buttonY = 12
    $spacing = 10
    $buttonWidth = [Windows.Forms.TextRenderer]::MeasureText((($Options | sort Length)[-1]),$form.Font).Width + 1
    $buttonWidth = [Math]::Max($minButtonWidth, $buttonWidth)
    $formWidth =  [Windows.Forms.TextRenderer]::MeasureText($Title,$form.Font).Width
    $spaceWidth = ($options.Count+1) * $spacing
    $formWidth = ($formWidth, $minFormWidth, ($buttonWidth * $Options.Count + $spaceWidth) | Measure-Object –Maximum).Maximum
    $form.ClientSize = New-Object System.Drawing.Size($formWidth,$formHeight)
    $index = 0
    #create the buttons dynamically based on the options
    foreach ($option in $Options){
        Set-Variable "button$index" –Value (New-Object System.Windows.Forms.Button)
        $temp = Get-Variable "button$index" –ValueOnly
        $temp.Size = New-Object System.Drawing.Size($buttonWidth,$buttonHeight)
        $temp.UseVisualStyleBackColor = $True
        $temp.Text = $option
        $buttonX = ($index + 1) * $spacing + $index * $buttonWidth
        $temp.Add_Click({ 
            $script:result = $this.Text; $form.Close() 
        })
        $temp.Location = New-Object System.Drawing.Point($buttonX,$buttonY)
        $form.Controls.Add($temp)
        $index++
    }
    $shownString = '$this.Activate();'
    if ($DefaultChoice -ne -1){
        $shownString += '(Get-Variable "button$($DefaultChoice-1)" -ValueOnly).Focus()'
    }
    $shownSB = [ScriptBlock]::Create($shownString)
    $form.Add_Shown($shownSB)
    [void]$form.ShowDialog()
    $result
}
#######


$options = ‘Europe’, ‘Americas’, ‘Asia’
$region = Get-Choice -Title "Select a region to play on" -Options $options -DefaultChoice 1

if ($region -eq ‘Europe’) { 
    $region = "eu.actual.battle.net" }
elseif ($region -eq ‘Americas’) { 
    $region = "us.actual.battle.net" }
elseif ($region -eq ‘Asia’) { 
    $region = "kr.actual.battle.net" }


# Options for -address if $region isn't used: eu/us/kr.actual.battle.net
& "$PSScriptLauncher\D2R.exe" -username $username -password $cred -address $region -ns

Start-Sleep 1

# Set Above normal priority for the process in Windows
Get-WmiObject Win32_process -filter 'name = "D2R.exe"' | foreach-object { $_.SetPriority(32768) }

######## Credits to Chobot from d2jsp for kill handler part ########
Start-Sleep 10

& "$PSScriptRoot\handle64.exe" -accepteula -a -p D2R.exe > $PSScriptRoot\d2r_handles.txt

$proc_id_populated = ""
$handle_id_populated = ""

foreach($line in Get-Content $PSScriptRoot\d2r_handles.txt) {


    $proc_id = $line | Select-String -Pattern '^D2R.exe pid\: (?<g1>.+) ' | %{$_.Matches.Groups[1].value}
    if ($proc_id)
    {
    $proc_id_populated = $proc_id
    }
    $handle_id = $line | Select-String -Pattern '^(?<g2>.+): Event.*DiabloII Check For Other Instances' | %{$_.Matches.Groups[1].value}
    if ($handle_id)
    {
    $handle_id_populated = $handle_id
    }

    if($handle_id){

            Write-Host "Closing" $proc_id_populated $handle_id_populated
            & "$PSScriptRoot\handle64.exe" -p $proc_id_populated -c $handle_id_populated -y

            }
    
}

#read-host "Press ENTER to continue..."
