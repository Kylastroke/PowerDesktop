$Response=(
 " No Data Was Supplied For The Username Field " ,
" No Data Was Supplied For The Password Field "  ,
" Username Already Exists In Our Database , Kindly Re-input Username " ,
" A Value For The Password Field Is Missing . Re - Input Password " , 
" User Not Recognized ! Create Your New Account " 
)
  
function Flash_App_Environment(){ 
write-host "Restartitng" 
} 

function MainAppControl(){ 

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Foward's Main Action Control Center" 
$form.Size = New-Object System.Drawing.Size(390,450)
$form.MaximumSize = New-Object System.Drawing.Size(390,450)
$form.MaximumSize = New-Object System.Drawing.Size(390,450) 
$form.StartPosition = 'CenterScreen'
$form.AutoSize=$false 
$form.MaximizeBox  = $false

$form.KeyPreview = $True
$form.Add_KeyDown({if ($_.KeyCode -eq "Enter")
    {$x=$textBox.Text;$form.Close()}})
$form.Add_KeyDown({if ($_.KeyCode -eq "Escape")
    {$form.Close()}})

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(100,350)
$okButton.Size = New-Object System.Drawing.Size(90,25)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(200,350)
$cancelButton.Size = New-Object System.Drawing.Size(90,25)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)


$img = [System.Drawing.Image]::Fromfile('c:\ss.png')
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.location = New-object system.drawing.point(10,20)
$pictureBox.Width = 350 
$pictureBox.Height = 160
$pictureBox.Image = $img
$form.controls.add($pictureBox)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(13,220)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Username'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(20,240)
$textBox.Size = New-Object System.Drawing.Size(320,20)
$textBox.BackColor = "cyan" 
$form.Controls.Add($textBox)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(13,270)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Password'
$form.Controls.Add($label)



$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = New-Object System.Drawing.Point(20,290)
$textBox2.Size = New-Object System.Drawing.Size(320,20)
$textBox2.BackColor="orangered"
$form.Controls.Add($textBox2)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $Username = $textBox.Text
    $Password = $textBox2.Text

#Checks For The User Supplied Values 
#Responses Have Been Posted Above  

if (($Username.length) -lt (1) ) 
{ 
write-host "The Program Returned An Empty Response " 
write-host "Program Was Restarted At $(get-date)"
$Reset_App_Config = MainAppControl 
$Reser_App_Config
}

write-host " Value Supplied Was $Username  " 
write-host " Value Supplied Was $Password  " 
}
}










MainAppControl
