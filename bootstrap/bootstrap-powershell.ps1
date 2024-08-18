#!/usr/bin/env pwsh

Import-Module /usr/local/share/powershell/Modules/PackageManagement
Import-Module /usr/local/share/powershell/Modules/PowerShellGet


$modules = @(
	"PSReadLine",
	"verkadaModule"
)

$modules | ForEach-Object { Install-Module -Force -Name $_ }

$psversiontable > /home/connor/pstest.txt
