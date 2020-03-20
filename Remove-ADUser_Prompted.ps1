###########################################
#    Prompted Remove User Script          #
#                                         #
#    Script Created by James Honeycutt    #
#             On 20 January 2017          #
#                                         #
#    Last modified on 21 Feburary 2017    #
###########################################


        $DODID = read-host "What is the users DODID # "
        $User = Get-ADUser -Filter {employeeID -like $DODID} -searchbase "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com" -Verbose      #-OtherAttributes @{'employeeID'=$user}  
        $samAccount = $($user.SamAccountName)
        $Path = "\\ngpea7-fl0-1\Profiles\$samAccount"

        #unassign the user from their virtual machine (This portion does not work when run as a script.  It can be copied and pasted into a PowerShell Console and it will work.)
       <# 
        
        try {
            Enter-PSSession –Computername ngpea0viewbroke.ng.ds.army.mil #–credential (get-credential)
            Get-PSSnapin -name VMware* -Registered | Add-PSSnapin
            Add-PSSnapin -Name 
            Connect-VIServer 55.195.251.50 

            $vmDesktop = Get-DesktopVM | Where-Object {$_.user_sid -eq $(get-user -Name $User.sid)}
            Remove-UserOwnership -Machine_id $vmDesktop.machine_id -Verbose

            Exit-PSSession -Verbose
            }

        catch 
            {
            
            }

       Write-host "The user has been unassigned from their VM.  Please press return to continue:"     

           #>



# Tests to see if user has files and removes them and deletes the user account

    if ($null -ne $samAccount){
        
        try {
            Remove-Item $Path -Recurse -Force -Verbose 
            Remove-ADUser -Identity $($user.DistinguishedName) -Verbose -Confirm:$false
                    
            }

        Catch {

               }

        }

    else 
        { Write-Host "Files do not exist"}

        