; 
; Script by alanfox2000
;
; https://raw.githubusercontent.com/alanfox2000/repack_NVIDIAGeforceGraphicsDriver/master/Extract.ahk
;
;

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

7zr = %A_WorkingDir%\lzma-sdk\x64\7zr.exe
CMD7z = "-mmt=2 -m0=BCJ2 -m1=LZMA2:d128m:pb2:lp0:lc4:fb175 -m2=LZMA2:d19:pb2:lp0:lc4:fb175 -m3=LZMA2:d19:pb2:lp0:lc4:fb175 -mb0:1 -mb0s1:2 -mb0s2:3"

FormatTime, date,, dd-MM-yyyy
Loop, Files, Extract\*, D
{
NvCplSetupInt = %A_LoopFileLongPath%\Display.Driver\NvCplSetupInt.exe
NvCplSetupInt_Dir = %A_LoopFileLongPath%\NvCplSetupInt
FileDelete, %NvCplSetupInt_Dir%\Temp.7z
FileDelete, %A_WorkingDir%\Output\Temp.7z

runwait, %7zr% a -t7z "%NvCplSetupInt_Dir%\Temp.7z" "%NvCplSetupInt_Dir%\Extract\*" "%CMD7z%"
runwait, %ComSpec% /c "copy /b "%NvCplSetupInt_Dir%\NvCplSetupInt.sfx" + "%NvCplSetupInt_Dir%\NvCplSetupInt.txt" +"%NvCplSetupInt_Dir%\Temp.7z" "%NvCplSetupInt%""
FileDelete, %NvCplSetupInt_Dir%\Temp.7z
runwait, %7zr% a -t7z "%A_WorkingDir%\Output\temp.7z" "%A_LoopFileLongPath%\*" -xr!NvCplSetupInt "%CMD7z%"
If A_LoopFileName contains win8-win7
{
runwait, %ComSpec% /c "copy /b "%A_WorkingDir%\Output\%A_LoopFileName%.exe.sfx" + "%A_WorkingDir%\Output\%A_LoopFileName%.exe.txt" + "%A_WorkingDir%\Output\Temp.7z" "%A_WorkingDir%\Output\nvidia-geforce-graphics-driver-lite-VER-win8-win7-64bit-%date%.exe""
}
else if A_LoopFileName contains dch
{
runwait, %ComSpec% /c "copy /b "%A_WorkingDir%\Output\%A_LoopFileName%.exe.sfx" + "%A_WorkingDir%\Output\%A_LoopFileName%.exe.txt" + "%A_WorkingDir%\Output\Temp.7z" "%A_WorkingDir%\Output\nvidia-geforce-graphics-driver-lite-VER-win10-64bit-dch-%date%.exe""
}
else
{
runwait, %ComSpec% /c "copy /b "%A_WorkingDir%\Output\%A_LoopFileName%.exe.sfx" + "%A_WorkingDir%\Output\%A_LoopFileName%.exe.txt" + "%A_WorkingDir%\Output\Temp.7z" "%A_WorkingDir%\Output\nvidia-geforce-graphics-driver-lite-VER-win10-64bit-%date%.exe""
}

FileDelete, %A_WorkingDir%\Output\Temp.7z
}
ExitApp