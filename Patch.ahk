#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
FileEncoding, UTF-8-RAW

7zr = %A_WorkingDir%\lzma-sdk\x64\7zr.exe
sfxsplit =  %A_WorkingDir%\SfxSplit\SfxSplit.exe
input_dir = %A_WorkingDir%\Input
output_dir = %A_WorkingDir%\Output
extract_dir = %A_WorkingDir%\Extract
Sign64 = C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\signtool.exe
content =
(
HKR,,D3D_A6489764,`%REG_DWORD`%,1
HKR,,D3D_12298867,`%REG_BINARY`%,37,90,38,39
HKR,,D3D_16579523,`%REG_BINARY`%,01,00,00,00
HKR,,D3D_16997821,`%REG_BINARY`%,74,72,95,99
HKR,,D3D_18078188,`%REG_BINARY`%,16,49,41,03
HKR,,D3D_20466189,`%REG_BINARY`%,54,91,25,31
HKR,,D3D_22355415,`%REG_BINARY`%,25,12,13,50
HKR,,D3D_23132857,`%REG_BINARY`%,f4,45,88,7c
HKR,,D3D_24464826,`%REG_BINARY`%,65,28,81,23
HKR,,D3D_30913648,`%REG_BINARY`%,01,00,00,00
HKR,,D3D_36759435,`%REG_BINARY`%,01,91,82,24
HKR,,D3D_40792312,`%REG_BINARY`%,01,00,00,00
HKR,,D3D_46205529,`%REG_BINARY`%,55,49,20,88
HKR,,D3D_52971801,`%REG_BINARY`%,00,18,0c,3c
HKR,,D3D_60461791,`%REG_BINARY`%,92,52,92,60
HKR,,D3D_88481200,`%REG_BINARY`%,00,00,00,00
HKR,,D3D_92521178,`%REG_BINARY`%,00,00,00,20
HKR,,D3D_94118636,`%REG_BINARY`%,00,00,00,00
HKR,,D3D_95739038,`%REG_BINARY`%,1f,00,00,00
HKR,,D3D_98764205,`%REG_BINARY`%,03,00,00,00
HKR,,D3D_QualityEnhancements,`%REG_BINARY`%,00,00,00,00
HKR,,D3DOGL_70835937,`%REG_BINARY`%,00,00,02,00
HKR,,D3DOGL_74095213,`%REG_BINARY`%,01,00,00,00
HKR,,D3DOGL_03385531,`%REG_BINARY`%,00,00,00,00
HKR,,D3DOGL_67207556,`%REG_BINARY`%,04,00,00,00
HKR,,D3DOGL_64877940,`%REG_BINARY`%,00,00,00,00
HKR,,D3DOGL_53893160,`%REG_BINARY`%,01,00,00,00
HKR,,D3DOGL_49119164,`%REG_BINARY`%,04,00,00,00
HKR,,D3DOGL_12677978,`%REG_BINARY`%,60,16,62,51
HKR,,OGL_CmdBufMinWords,`%REG_BINARY`%,80,09,00,00
HKR,,OGL_CmdBufSizeWords,`%REG_BINARY`%,00,00,04,00
HKR,,OGL_DefaultSwapInterval,`%REG_BINARY`%,ff,ff,ff,ff
HKR,,OGL_FlippingControl,`%REG_BINARY`%,02,00,00,00
HKR,,OGL_PalettedTexInVidMem,`%REG_BINARY`%,01,00,00,00
HKR,,OGL_QualityEnhancements,`%REG_BINARY`%,14,00,00,00
HKR,,OGL_RenderQualityFlags,`%REG_BINARY`%,08,00,00,00
HKR,,OGL_TargetFlushCount,`%REG_BINARY`%,10,00,00,00
HKR,,OGL_TexClampBehavior,`%REG_BINARY`%,00,00,00,00
HKR,,OGL_TexLODBias,`%REG_BINARY`%,00,00,00,00
HKR,,OGL_TripleBuffer,`%REG_BINARY`%,01,00,00,00
HKR,,OGL_UseCachedPCIMappings,`%REG_BINARY`%,01,00,00,00
HKR,,OGL_01887890,`%REG_BINARY`%,01,00,00,00
HKR,,OGL_1190801a,`%REG_BINARY`%,01,00,00,00
HKR,,OGL_563a95f1,`%REG_BINARY`%,43,bd,3a,41
HKR,,OGL_95282304,`%REG_BINARY`%,1f,00,00,00
HKR,,Ogl_MaxPCITexHeapSize,`%REG_BINARY`%,00,00,00,20
HKR,,Ogl_TexMemorySpaceEnables,`%REG_BINARY`%,03,00,00,00
HKR,,Ogl_DLMemorySpaceEnables,`%REG_BINARY`%,03,00,00,00
HKR,,TexturePrecache,`%REG_BINARY`%,01,00,00,00
HKR,,UMAFastFrameBuffer,`%REG_BINARY`%,01,00,00,00
;
)

;; Driver File Patch
Loop, Files, Extract\*, D
{
PackageDir = %A_LoopFileName%
Loop, Files, Extract\%PackageDir%\Display.Driver\*.inf, F
{
IniDelete, %A_LoopFileFullPath%, SourceDisksFiles, DisplayDriverRAS.dll
FileRead, InfContents, %A_LoopFileFullPath%
InfContents2 := StrReplace(InfContents, "`r`nDisplayDriverRAS.dll,,,0x00000010")
InfContents3 := StrReplace(InfContents2, "`r`nDisplayDriverRAS.dll,,,")
InfContents4 := StrReplace(InfContents3, ",nvst3*.chm")
InfContents5 := StrReplace(InfContents4, ",nvWmi.chm")
InfContents6 := StrReplace(InfContents5, "NvSupportTelemetry = 1", "NvSupportTelemetry = 0")
InfContents7 := RegExReplace(InfContents6, "`r`n(.*)\.chm")
InfContents8 := StrReplace(InfContents7, ",NVNetworkService.exe,NVNetworkServiceAPI.dll,NvInstallerUtil.dll")
FileDelete,  %A_LoopFileFullPath%
FileAppend , %InfContents8%, %A_LoopFileFullPath%, UTF-8-RAW
IniRead, SectionNames, %A_LoopFileFullPath%
    Loop, Parse, SectionNames,`n
    {
        addregsection := A_LoopField
        if addregsection contains nv_commonBase_addreg
        {
            iniread, addregsection_content, %A_LoopFileFullPath%, %addregsection%
            if addregsection_content not contains D3D_98764205
            {
                iniwrite, %content%, %A_LoopFileFullPath%, %addregsection%
            }
        }
    }
}


NVI_DisplayDriver:
Loop, Files, Extract\%PackageDir%\Display.Driver\DisplayDriver.nvi, F
{
FileRead, NVI_DisplayDriver, %A_LoopFileFullPath%
NVI_DisplayDriver2 := RegExReplace(NVI_DisplayDriver, "\r\n(.*)<file name(.*)DisplayDriverRAS.dll(.*)>")
NVI_DisplayDriver3 := RegExReplace(NVI_DisplayDriver2, "\r\n(.*)<(.*)deleteOlderRASPluginData(.*)\r\n(.*)\r\n(.*)\r\n(.*)</standard>")
NVI_DisplayDriver4 := RegExReplace(NVI_DisplayDriver3, "\r\n(.*)<(.*)decideDisplayDriverRASInstall(.*)")
NVI_DisplayDriver5 := RegExReplace(NVI_DisplayDriver4, "\r\n(.*)<(.*)copyDisplayDriverRASPlugin(.*)\r\n(.*)\r\n(.*)\r\n(.*)</standard>")
NVI_DisplayDriver6 := RegExReplace(NVI_DisplayDriver5, "\r\n(.*)<(.*)createJunctionPointforDisplayDriverRASPlugin(.*)\r\n(.*)\r\n(.*)</standard>")
NVI_DisplayDriver7 := RegExReplace(NVI_DisplayDriver6, "<bool name=""UsesNvTelemetry"" value=""true""/>","<bool name=""UsesNvTelemetry"" value=""false""/>")
NVI_DisplayDriver8 := RegExReplace(NVI_DisplayDriver7, "<bool name=""UsesDisplayDriverRASSymLink"" value=""true""/>","<bool name=""UsesDisplayDriverRASSymLink"" value=""false""/>")
FileDelete, %A_LoopFileFullPath%
FileAppend, %NVI_DisplayDriver8%, %A_LoopFileFullPath%, UTF-8-RAW
}

NVI_UpdateCore:
Loop, Files, Extract\%PackageDir%\Update.Core\UpdateCore.nvi, F
{
FileRead, NVI_UpdateCore, %A_LoopFileFullPath%
NVI_UpdateCore2 := RegExReplace(NVI_UpdateCore, "\r\n(.*)<file name(.*)NvTmMon.exe(.*)>")
NVI_UpdateCore3 := RegExReplace(NVI_UpdateCore2, "\r\n(.*)<file name(.*)NvTmRep.exe(.*)>")
NVI_UpdateCore4 := RegExReplace(NVI_UpdateCore3, "\r\n(.*)<(.*)scheduleNvTmMon(.*)\r\n(.*)\r\n(.*)</standard>")
NVI_UpdateCore5 := RegExReplace(NVI_UpdateCore4, "\r\n(.*)<(.*)scheduleNvTmRep(.*)\r\n(.*)\r\n(.*)</standard>")
NVI_UpdateCore6 := RegExReplace(NVI_UpdateCore5, "\r\n(.*)<(.*)deleteNvTmRepOnLogon(.*)\r\n(.*)\r\n(.*)</standard>")
NVI_UpdateCore7 := RegExReplace(NVI_UpdateCore6, "\r\n(.*)<copyFile target(.*)NvTmMon.exe(.*)>")
NVI_UpdateCore8 := RegExReplace(NVI_UpdateCore7, "\r\n(.*)<copyFile target(.*)NvTmRep.exe(.*)>")
NVI_UpdateCore9 := RegExReplace(NVI_UpdateCore8, "\r\n(.*)<deleteDirectoryTree(.*)NvTmMon(.*)>")
NVI_UpdateCore10 := RegExReplace(NVI_UpdateCore9, "\r\n(.*)<deleteDirectoryTree(.*)NvTmRep(.*)>")
NVI_UpdateCore11 := RegExReplace(NVI_UpdateCore10, "\r\n(.*)<package(.*)NvTelemetry(.*)>")
NVI_UpdateCore12 := RegExReplace(NVI_UpdateCore11, "<bool name=""UsesNvTelemetry"" value=""true""/>","<bool name=""UsesNvTelemetry"" value=""false""/>")
NVI_UpdateCore13 := RegExReplace(NVI_UpdateCore12, "hidden=""true""","hidden=""false""")
NVI_UpdateCore14 := RegExReplace(NVI_UpdateCore13, "disposition=""demand""","disposition=""default""")
FileDelete, %A_LoopFileFullPath%
FileAppend, %NVI_UpdateCore14%, %A_LoopFileFullPath%, UTF-8-RAW
}

NVI_ControlPanel:
Loop, Files, Extract\%PackageDir%\NvCplSetupInt\Extract\DisplayControlPanel.nvi, F
{
FileRead, NVI_ControlPanel, %A_LoopFileFullPath%
NVI_ControlPanel2 := RegExReplace(NVI_ControlPanel, "></manifest>", ">`r`n`t</manifest>")
NVI_ControlPanel3 := RegExReplace(NVI_ControlPanel2, "/><file name", "/>`r`n`t`t<file name")
NVI_ControlPanel4 := RegExReplace(NVI_ControlPanel3, "\r\n\t\t<file name(.*).chm(.*)")
NVI_ControlPanel5 := RegExReplace(NVI_ControlPanel4, "\r\n\t\t\t\t(.*)copyFile(.*).chm(.*)")
NVI_ControlPanel6 := RegExReplace(NVI_ControlPanel5, "\r\n\t\t\t\t(.*)copyFile(.*).hlp(.*)")
FileDelete, %A_LoopFileFullPath%
FileAppend, %NVI_ControlPanel6%, %A_LoopFileFullPath%, UTF-8-RAW
}

HDAUDIO:
if PackageDir contains dch
{
IniRead, version, Extract\%PackageDir%\HDAUDIO\nvhda.inf, Version, DriverVer
IniRead, patch_version, HDAudio\DCH\nvhda.inf, Version, DriverVer
    if version not contains %patch_version%
    {
        msgbox, HDAudio version not match. Patch: %patch_version%`r`nDriver: %version%
    }
    else
    {
        FileCopy, HDAudio\DCH\nvhda.inf, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEA32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEA64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EED32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EED64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEG32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEG64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEL32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEL64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEP32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\R4EEP64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\DCH\HDAudio.nvi, Extract\%PackageDir%\HDAudio, 1
    }
}
else
{
IniRead, version, Extract\%PackageDir%\HDAUDIO\nvhda.inf, Version, DriverVer
IniRead, patch_version, HDAudio\Legacy\nvhda.inf, Version, DriverVer
    if version not contains %patch_version%
    {
        msgbox, HDAudio version not match. Patch: %patch_version%`r`nDriver: %version%
    }
    else
    {
        FileCopy, HDAudio\Legacy\nvhda.inf, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEA32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEA64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EED32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EED64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEG32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEG64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEL32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEL64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEP32H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\R4EEP64H.dll, Extract\%PackageDir%\HDAudio, 1
        FileCopy, HDAudio\Legacy\HDAudio.nvi, Extract\%PackageDir%\HDAudio, 1
    }
}

if PackageDir contains dch
{
FileCopy, NVIDIACorp.NVIDIAControlPanel_56jybvy8sckqj.Appx, Extract\%PackageDir%\Display.Driver, 1
}
FileCopy, Utility\AutoClick.ahk, Extract\%PackageDir%, 1
FileCopy, Utility\Utility.ahk, Extract\%PackageDir%, 1
FileCopy, Utility\AutoHotkey.exe, Extract\%PackageDir%, 1

} ;Full Loop End


; Config Patch
FileEncoding, UTF-8
Loop, Files, Output\*.txt, F
{
FileRead, ConfigTXT, %A_LoopFileFullPath%
ConfigTXT2 := RegExReplace(ConfigTXT, "Delete(.*)systemdrive(.*)\r\n")
ConfigTXT3 := RegExReplace(ConfigTXT2, "%systemdrive%\\\\NVIDIA\\\\DisplayDriver", "%systemdrive%\\NVIDIA-Display-Driver-Lite")
if A_LoopFileName contains dch
{
ConfigTXT4 := RegExReplace(ConfigTXT3, "\\\\International", "\\DCH")
ConfigTXT5 := RegExReplace(ConfigTXT4, "- International Package", "DCH Win10 x64 [Modder: alanfox2000]")
ConfigTXT6 := RegExReplace(ConfigTXT5, "- International", "DCH Win10 x64")
}
else if A_LoopFileName contains win10
{
ConfigTXT4 := RegExReplace(ConfigTXT3, "\\\\International", "\\Legacy")
ConfigTXT5 := RegExReplace(ConfigTXT4, "- International Package", "Legacy Win10 x64 [Modder: alanfox2000]")
ConfigTXT6 := RegExReplace(ConfigTXT5, "- International", "Legacy Win10 x64")
}
else if A_LoopFileName contains win8-win7
{
ConfigTXT4 := RegExReplace(ConfigTXT3, "\\\\International", "\\Legacy")
ConfigTXT5 := RegExReplace(ConfigTXT4, "- International Package", "Legacy Win8/7 x64 [Modder: alanfox2000]")
ConfigTXT6 := RegExReplace(ConfigTXT5, "- International", "DCH Win8/7 x64")
}
ConfigTXT7 := RegExReplace(ConfigTXT6, "NVIDIA Display Driver v", "NVIDIA Display Driver Lite v")
ConfigTXT8 := RegExReplace(ConfigTXT7, "RunProgram="".\\\\\\\\setup.exe""", "RunProgram=""\""%%T\\AutoHotkey.exe\"" \""%%T\\Utility.ahk\""""")
FileDelete, %A_LoopFileFullPath%
FileAppend, %ConfigTXT8%, %A_LoopFileFullPath%, UTF-8
}

ExitApp