<# 
Set Teams App Permission Policy from CSV
    Version: v1.0
    Date: 23/08/2021
    Author: Rob Watts - Customer Engineer - Microsoft
    

DISCLAIMER
   THIS CODE IS SAMPLE CODE. THESE SAMPLES ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.
   MICROSOFT FURTHER DISCLAIMS ALL IMPLIED WARRANTIES INCLUDING WITHOUT LIMITATION ANY IMPLIED WARRANTIES
   OF MERCHANTABILITY OR OF FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK ARISING OUT OF THE USE OR
   PERFORMANCE OF THE SAMPLES REMAINS WITH YOU. IN NO EVENT SHALL MICROSOFT OR ITS SUPPLIERS BE LIABLE FOR
   ANY DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS
   INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OF OR
   INABILITY TO USE THE SAMPLES, EVEN IF MICROSOFT HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
   BECAUSE SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR
   INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU.
#>

# Pop out disclaimer
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

[Windows.Forms.MessageBox]::Show("
THIS CODE IS SAMPLE CODE. 

THESE SAMPLES ARE PROVIDED 'AS IS' WITHOUT WARRANTY OF ANY KIND.

MICROSOFT FURTHER DISCLAIMS ALL IMPLIED WARRANTIES INCLUDING WITHOUT LIMITATION ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR OF FITNESS FOR A PARTICULAR PURPOSE. 

THE ENTIRE RISK ARISING OUT OF THE USE OR PERFORMANCE OF THE SAMPLES REMAINS WITH YOU.

IN NO EVENT SHALL MICROSOFT OR ITS SUPPLIERS BE LIABLE FOR ANY DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OF OR INABILITY TO USE THE SAMPLES, EVEN IF MICROSOFT HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

BECAUSE SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU.", "***DISCLAIMER***", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Warning)


# Import Teams Module
Import-Module MicrosoftTeams

# Connects to Microsoft Teams
Write-Host "Connecting to Microsoft Teams..."
Connect-MicrosoftTeams

# Enable File Picker
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

# File Picker  (Set File Path - Open File Browser)
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.csv)| *.csv"
    $OpenFileDialog.ShowDialog() | Out-Null
    $FilePath = $OpenFileDialog.filename
   
# Store the data from NewUsersFinal.csv in the $ADUsers variable
    Write-Host "Importing CSV..."
    $Users = Import-Csv $FilePath

# Select Application Permission Policy
    $AppPermissionPolicy = Get-CsTeamsAppPermissionPolicy | Select-Object Identity,Description | Out-GridView -OutputMode Single -Title "Please select an Application Permission Policy"
    Write-Host $AppPermissionPolicy.Identity "is the App Permission Policy Name"

# Loop through each row containing user details in the CSV file
foreach ($User in $Users)   {

    # Read user data from each field in each row and assign the App Permission Policy
    $UPN = $User.UPN
      
    Grant-CsTeamsAppPermissionPolicy -Identity $UPN -PolicyName $AppPermissionPolicy.Identity  

                            }


