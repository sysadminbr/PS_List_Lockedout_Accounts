<#
# CITRA IT - EXCELÊNCIA EM TI
# SCRIPT PARA LISTAR CONTAS DE USUÁRIO ATIVAS MAS BLOQUEADAS NO AD
# AUTOR: luciano@citrait.com.br
# DATA: 15/11/2021
# EXAMPLO DE USO: Powershell -ExecutionPolicy ByPass -File C:\scripts\PS_List_Lockedout_Accounts.ps1
#>

# Detect if admin
whoami /groups | findstr /i 12288 | out-null
if ($? -eq $False)
{
	write-host "not running as admin. trying to elevate."
	start-process powershell -verb runas -argumentlist "-ep","bypass","-file",$MyInvocation.MyCommand.Path
        Exit
}else{
	write-host "Running as admin. proceeding"
	Import-Module ActiveDirectory
	Get-ADUser -Filter {Enabled -eq $True } -Properties * | ?{$_.LockedOut -eq $True}  | Select Name,SamAccountName | Out-GridView -wait   
}
