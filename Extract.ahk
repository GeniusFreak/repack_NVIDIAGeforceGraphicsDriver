; 

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
7zr = %A_WorkingDir%\lzma-sdk\x64\7zr.exe
sfxsplit =  %A_WorkingDir%\SfxSplit\SfxSplit.exe
input_dir = %A_WorkingDir%\Input
output_dir = %A_WorkingDir%\Output
extract_dir = %A_WorkingDir%\Extract
Sign64 = C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\signtool.exe

Loop, Files, %input_dir%\*.exe, F
{
runwait, "%Sign64%" remove /s "%A_LoopFileFullPath%"
runwait, %ComSpec% /c ""%sfxsplit%" "%A_LoopFileFullPath%" -m "%output_dir%\%A_LoopFileName%.sfx" -c "%output_dir%\%A_LoopFileName%.txt" -a "%output_dir%\%A_LoopFileName%.7z" -b"
FileNameNoExt := StrReplace(A_LoopFileName, "." . A_LoopFileExt)
runwait, %7zr% x "%output_dir%\%A_LoopFileName%.7z" -y -o"%extract_dir%\%FileNameNoExt%" setup.exe setup.cfg ListDevices.txt license.txt EULA.txt -r Display.Driver\* HDAudio\* NVI2\* PhysX\* Update.Core\* PPC\* -x!GFExperience\EULA.txt -x!GFExperience\license.txt -x!NVI2\NVNetworkService.exe -x!NVI2\NVNetworkServiceAPI.dll -x!NVI2\NvInstallerUtil.dll -x!Update.Core\NvTmMon.exe -x!Update.Core\NvTmRep.exe -x!Display.Driver\DisplayDriverRAS.dll

NvCplSetupInt = %extract_dir%\%FileNameNoExt%\Display.Driver\NvCplSetupInt.exe
NvCplSetupIntDir = %extract_dir%\%FileNameNoExt%\NvCplSetupInt
FileCreateDir, %NvCplSetupIntDir%
runwait, "%Sign64%" remove /s "%NvCplSetupInt%"
runwait, %ComSpec% /c ""%sfxsplit%" "%NvCplSetupInt%" -m "%NvCplSetupIntDir%\NvCplSetupInt.sfx" -c "%NvCplSetupIntDir%\NvCplSetupInt.txt" -a "%NvCplSetupIntDir%\NvCplSetupInt.7z" -b"
runwait, %7zr% x "%NvCplSetupInt%" -y -o"%NvCplSetupIntDir%\Extract" -xr!*.chm

}

ExitApp