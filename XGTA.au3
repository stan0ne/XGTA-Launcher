#cs
	[CWAutCompFileInfo]
	Company=XGTA
	Copyright=XGTA
	Description=Launcher SAMP
	Version=1.8
	ProductName=XGTA Launcher
	ProductVersion=1.8
#ce
#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=untitled_y3C_icon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#EndRegion
#include <Misc.au3>
#include "GUICtrlOnHover.au3"
#include <File.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <TCP.au3>
#include <ScreenCapture.au3>
#include <String.au3>
#include <NomadMemory.au3>
#include <WinAPI.au3>
$iPing = Ping("vinasamp.top", 1000)
If $iPing Then ; If a value greater than 0 was returned then display the following message.
	If $iPing < 2 Then Exit
Else
	MsgBox(16, "Lỗi xảy ra", "Không thể kết nối tới máy chủ. Code: " & @error)
	Exit
EndIf

Global $MAIN, $HGWC_GUI, $HGWC_STT, $HGWC_STT2, $HGWC_PRG_INFO = 0, $HGWC_PRG, $RED = 16739360, $BLUE = 239871, $REGLINK = "HKEY_CURRENT_USER\Software\SAMP-Launcher"
Global $EXIT, $EXIT_LOGIN, $EXIT_LB, $ENTER, $ENTER_LB, $USER, $EX_PATH = "C:\Windows", $FILES, $VER = "v2.1", $H_STT, $STT_LB
Global $INSTALL_PATH = "C:\Windows\ProgramXGTA\", $GTA_SA, $SAMPDLL, $PID
Global $BACKGROUND = $INSTALL_PATH & "background.jpg", $dongycleo, $danhanok, $FILESPLIT, $g_sampdll
Global $cleodirectory = @ScriptDir & "\cleo\", $gtadirectory = @ScriptDir, $hack, $WAITGUI, $digits = 5, $aSpace[2], $pwd, $LAUNCHER_EXIT, $soluong, $STEPHGWC, $DACHECK, $RANDOM
; Hack allowed
Global $asiallowed = POST("http://vinasamp.top/asi.php") ;"0x30415824fd1be18d0925b05125c98488,0xfdcf6cb0368668968e4394c7b054f1b0,0xba7061e63d97e830d282335eeaeea8fd,0x69c0212bf3e7fab7172aac2906feb4b6,0xb37675f83bee74f86deb808c4e295970,0x7d6fce9e20730993332564a8b33a6f0f,0xfb409578e697573bd0a8eb243a480710,0xadb09e95902101cc9f58560c49a3328d,0x99478c683dcc5abe99bb38d1b1544e55,0xb13c9dd585516902e327488be6973762,0x8e8d56562429ee5a549025c1383be115,0xf1d3c75d0ccefc41185e14043081f148,0x4589ab3829fba0024909b825d248146e,0x479f790d850aa208a73787411c1df97e,0x795df56453ab16ed321a3937efa33d82,0x817f985d55da741dd91fc591291e6eec,0x9d337b486160ab57eb1f3d980b4d98cb" ;StringEncrypt(False, BinaryToString(InetRead("http://downloadservice-vinacf.rhcloud.com/file.xgta"), 4), '5pQ*{nWe}hMv5,zjqNWDyUy{W<C-`j$n%@)!^Q.D2X_a7}NT66#s5e$u&&S2>A~')
Global $allowed = POST("http://vinasamp.top/cleo.php")
;chat
Global $GUITitle = "XGTA Chat"
Global $ServerPort = 88
Global $sock = 0
$ServerIP = "127.0.0.1"
$NickName = ""
Global $constatus = 'Disconnected'
Global $hChild, $hGraphic, $aSmileyFiles, $ahImage, $ahDummy
Global $hSocket, $iError, $hClient
Global $connected = False
Global $LastSendString
DirCreate(@TempDir & "\XGTA")
;Launcher start
If Not FileExists($BACKGROUND) Then
	DirCreate($INSTALL_PATH)
	FileInstall("background.jpg", $BACKGROUND)
EndIf
If WinGetTitle("XTGA Launcher") Then
	MsgBox(16, "ERROR", "Bạn chỉ có thể chạy 1 launcher :)")
	Exit
EndIf
If Not FileExists("gta_sa.exe") Then
	MsgBox(16, "Error", "Bạn cần phải bỏ launcher vào thư mục game !")
	Exit
EndIf
DirRemove(@TempDir & "\XGTA")
FileDelete("vorbisFile.dll")
FileDelete("vorbisHooked.dll")
FileDelete("bass.dll")
FileInstall("vorbisFile.dll", "vorbisFile.dll")
FileInstall("vorbisHooked.dll", "vorbisHooked.dll")
FileInstall("bass.dll", "bass.dll")
CHECK()
LOGIN()
LAUNCHER()

Func LAUNCHER()
	$NickName = $USER
	$WAITGUI = GUICreate("XTGA Launcher", 400, 180, -1, -1, -2138570752)
	GUISetBkColor(0x00FFFFFF) ;3158604
	GUICtrlCreateLabel("XGTA Launcher", 75, 10, 250, 52, 1, 1048576)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x0014, 0x0258)
	GUICtrlSetBkColor(-1, 0x00FFFFFF)
	GUICtrlCreateLabel("", 0x0014, 0x0034, 0x0168, 1)
	GUICtrlSetBkColor(-1, 0)
	$USER_TYPE_LB = GUICtrlCreateLabel("Tài khoản: " & $USER & "", 50, 62, 300, 20, 1 + 512)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x000D)
	GUICtrlSetBkColor(-1, -2)
	_GUICTRL_ONHOVERREGISTER(-1, "Hover2", "Leave2")
	$USER_TYPE_LB = GUICtrlCreateLabel("Báo lỗi launcher", 50, 84, 300, 20, 1 + 512)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x000D)
	GUICtrlSetBkColor(-1, -2)
	_GUICTRL_ONHOVERREGISTER(-1, "Hover2", "Leave2")
	$LAUNCHER_EXIT = GUICtrlCreateLabel("X", 370, 7, 15, 24, 1 + 512)
	_GUICTRL_ONHOVERREGISTER(-1, "_Hover", "_Leave")
	GUICtrlSetFont(-1, 13.5, 800, -1, "Segoe UI", 5)
	GUICtrlSetBkColor(-1, 0x00FFFFFF)
	GUICtrlSetColor(-1, 0)
	$LAUNCHER_MSG = GUICtrlCreateLabel("Nhấn để vào game !", 50, 120, 300, 30, 1 + 512)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x0010, 0x01F4)
	GUICtrlSetBkColor(-1, 0x00FFFFFF)
	_GUICTRL_ONHOVERREGISTER(-1, "Hover2", "Leave2")
	Local $default = GUICtrlCreateRadio("Mặc định", 10, 153, 0x0050, 0x0011)
	Local $Local0001 = GUICtrlCreateRadio("Thêm MOD", 90, 153, 0x0064, 0x0011)
	If RegRead($REGLINK, "modveh") = 1 Then
		RegWrite($REGLINK, "modveh", "REG_SZ", 1)
		GUICtrlSetState($default, 0)
		GUICtrlSetState($Local0001, 1)
	Else
		RegWrite($REGLINK, "modveh", "REG_SZ", 0)
		GUICtrlSetState($default, 1)
		GUICtrlSetState($Local0001, 0)
	EndIf
	_D3D_CTRLCREATEBOX(50, 120, 300, 30, 1, 0)
	_D3D_CTRLCREATEBOX(2, 2, 396, 176, 2, 0)
	_D3D_CTRLCREATEBOX(6, 6, 388, 168, 1, 0)
	#cs
		$bat = GUICtrlCreateCheckbox("", 20, 0x0099, 15, 15)
		$regbat = RegRead($REGLINK, "dophangiai")
		If $regbat = "" Or $regbat = 0 Then
		GUICtrlSetState($bat, $GUI_UNCHECKED)
		$dophangiai = 0
		Else
		GUICtrlSetState($bat, $GUI_CHECKED)
		$dophangiai = 1
		EndIf
		GUICtrlCreateLabel("Màu nền trắng", 35, 154, 160, 17)
		GUICtrlSetBkColor(-1, 3158064)
		GUICtrlSetColor(-1, 16777215)
	#ce
	GUISetState()
	$hGUI = GUICreate($GUITitle, 595, 392)
	$btnSenden = GUICtrlCreateButton('Senden', 455, 270, 120, 20)
	GUICtrlSetState($btnSenden, $GUI_DISABLE)
	Dim $AccelKeys[2][2] = [["{ENTER}", $btnSenden], ["{ESC}", $GUI_EVENT_CLOSE]]
	GUISetAccelerators($AccelKeys)
	$TIME = TimerInit()
	_Try2Connect()
	renamecleomoved($cleodirectory)
	renameasimoved($gtadirectory)
	While 1
		If $H_STT = 1 And Not ProcessExists("gta_sa.exe") Then
			TAKE_ME_BACK()
			ProcessClose($RANDOM & "-XGTAGG.exe")
			DirRemove(@ScriptDir & "\LauncherSA")
			FileDelete("xgta.asi")
			FileDelete("DSOUND.dll")
		EndIf
		If ProcessExists("gta_sa.exe") And $H_STT = 1 Then
			If _IsPressed(78) Then
				ProcessClose("gta_sa.exe")
			EndIf
		EndIf
		If WinGetTitle("[CLASS:ConsoleWindowClass]") And ProcessExists("cmd.exe") Or WinGetTitle("[CLASS:Window]") Or WinGetTitle("Ollllly") Or WinGetTitle("Auto scan password") Then
			ProcessClose("gta_sa.exe")
			ProcessClose($RANDOM & "-XGTAGG.exe")
			DirRemove(@ScriptDir & "\LauncherSA")
			FileDelete("xgta.asi")
			FileDelete("DSOUND.dll")
			MsgBox(16, "Hack", "Phát hiện phầm mềm không hợp lệ, tự động thoát game !", Default)
			_Disconnected($hClient, $iError)
			Exit
		EndIf
		If $H_STT = 1 And Not ProcessExists($RANDOM & "-XGTAGG.exe") Then
			ProcessClose("gta_sa.exe")
			ProcessClose($RANDOM & "-XGTAGG.exe")
			DirRemove(@ScriptDir & "\LauncherSA")
			FileDelete("xgta.asi")
			FileDelete("DSOUND.dll")
			_Disconnected($hClient, $iError)
			Exit
		EndIf
		If _IsPressed(75) And _IsPressed(78) Then
			ProcessClose("gta_sa.exe")
			ProcessClose($RANDOM & "-XGTAGG.exe")
		EndIf
		If $H_STT = 1 And $DACHECK = 0 And WinGetTitle("XGTA:RP") And $dongycleo = 0 Then
			liststt($cleodirectory)
			gtaliststt($gtadirectory)
			$DACHECK = 1
		EndIf
		Switch GUIGetMsg()
			Case -3
				_Disconnected($hClient, $iError)
				Exit
			Case $LAUNCHER_EXIT
				_Disconnected($hClient, $iError)
				Exit
			Case $GUI_EVENT_CLOSE
				_Disconnected($hClient, $iError)
				_exit()
				#cs
					Case $bat
					If GUICtrlRead($bat) = $GUI_CHECKED Then
					$dophangiai = 1
					RegWrite($REGLINK, "dophangiai", "REG_SZ", 1)
					Else
					$dophangiai = 0
					RegWrite($REGLINK, "dophangiai", "REG_SZ", 0)
					EndIf
				#ce
			Case $USER_TYPE_LB
				ShellExecute("http://forum.xgta.top")
			Case $default
				RegWrite($REGLINK, "modveh", "REG_SZ", 0)
			Case $Local0001
				RegWrite($REGLINK, "modveh", "REG_SZ", 1)
			Case $LAUNCHER_MSG
				If FileExists("gta_sa.exe") Then
					If Not FileExists(@ScriptDir & "\SAMP\SAMP.img") Then
						$sampfile = MsgBox(4 + 64, "Notice", "Không tìm thấy samp, bạn có muốn cài đặt SAMP vào không ?")
						If $sampfile = 6 Then
							GUIDelete($WAITGUI)
							SAMPDOWNLOAD()
						Else
							_Disconnected($hClient, $iError)
							Exit
						EndIf
					EndIf
					If RegRead($REGLINK, "modveh") = 1 Then
						GUIDelete($WAITGUI)
						RegWrite($REGLINK, "modveh", "REG_SZ", 1)
						MODDOWNLOAD()
					Else
						RegWrite($REGLINK, "modveh", "REG_SZ", 0)
					EndIf
					GUIDelete($WAITGUI)
					Sleep(250)
					GUICREATERVHGWC()
					WinSetOnTop($HGWC_GUI, "", 1)
					SETLB("Chuẩn bị vài thứ...", 0, 2)
					checkbeforebegin($cleodirectory)
					Sleep(1000)
					SETLB("Step 1...", 0, 2)
					If $dongycleo = 0 Then
						list($cleodirectory)
					EndIf
					Sleep(250)
					SETLB("Step 2...", 50, 2)
					If $dongycleo = 0 Then
						gtalist($gtadirectory)
					EndIf
					Sleep(250)
					SETLB("Step 4...", 70, 2)
					INSTALLFILE()
					SETLB("Patching SAMP.dll...", 99, 2)
					Sleep(500)
					#cs
						$g_sampdll = BinaryToString("XGTA.asi")
						_ReplaceStringInFile($g_sampdll, "7B4646464646467D53412D4D50207B4239433942467D302E332E37207B4646464646467D5374617274656400436F6E6E656374696E6720746F2025733A25642E2E2E", "7B4646464646467D58475441207B4239433942467D76312E32207B4646464646467D6B686F6920646F6E67004B6574206E6F6920746F6920584754412E2E2E202020")
						SETLB("Patching SAMP.dll...", 75, 2)
						If @error Then
						MsgBox(16, "Error", "Phát hiện samp.dll bị thay đổi, hệ thống sẽ tự động sửa, vui lòng backup !")
						GUIDelete($WAITGUI)
						SAMPDOWNLOAD()
						FileCopy("samp.dll", "XGTA.asi")
						_ReplaceStringInFile($g_sampdll, "7B4646464646467D53412D4D50207B4239433942467D302E332E37207B4646464646467D5374617274656400436F6E6E656374696E6720746F2025733A25642E2E2E", "7B4646464646467D58475441207B4239433942467D76312E32207B4646464646467D6B686F6920646F6E67004B6574206E6F6920746F6920584754412E2E2E202020")
						EndIf
						SETLB("Patching SAMP.dll...", 80, 2)
						_ReplaceStringInFile($g_sampdll, "53637265656E73686F742054616B656E202D2073612D6D702D253033692E706E67", "4461206368757020616E68202D2078677461762D253033692E706E672020202020")
						SETLB("Patching SAMP.dll...", 85, 2)
						_ReplaceStringInFile($g_sampdll, "5B69643A2025642C20747970653A20256420737562747970653A202564204865616C74683A20252E3166207072656C6F616465643A2025755D0A44697374616E63653A20252E32666D0A50617373656E67657253656174733A2025750A63506F733A20252E33662C252E33662C252E33660A73506F733A20252E33662C252E33662C252E3366", "5B69642078653A2025642C206C6F61693A20256420737562747970653A202564204D61752078653A20252E3166207072656C6F616465643A2025755D2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020")
						SETLB("Patching SAMP.dll...", 90, 2)
						_ReplaceStringInFile($g_sampdll, "4754413A53413A4D500000005C73637265656E735C73612D6D702D253033692E706E67", "584754413A525020200000005C73637265656E735C78677461762D253033692E706E67")
						SETLB("Patching SAMP.dll...", 95, 2)
						_ReplaceStringInFile($g_sampdll, "436F6E6E65637465642E204A6F696E696E67207468652067616D652E2E2E", "5468616E6820636F6E6720212044616E672076616F2067616D652E2E2E20")
						SETLB("Patching SAMP.dll...", 100, 2)
						_ReplaceStringInFile($g_sampdll, "53657276657220636C6F7365642074686520636F6E6E656374696F6E2E", "4D61792063687520646120646F6E67206B6574206E6F69202120202020")
						$g_sampdll = ""
					#ce
					FileInstall("XGTA.dll", "XGTA.asi") ;PATCH(BinaryToString("F:\GTAasd\GTA\XGTA.asi"))
					FileInstall("DSOUND.dll", "DSOUND.dll")
					Run("gta_sa.exe -c -n " & $USER & " -h 192.169.167.247 -p 59612 -z 4q3dhLVZXh4HX66ya2ZWnH3AEFAfHNDzCbFxexxkhQkWvmWm")
					ProcessClose("gta_sa.exe")
					Run("gta_sa.exe -c -n " & $USER & " -h 192.169.167.247 -p 59612 -z 4q3dhLVZXh4HX66ya2ZWnH3AEFAfHNDzCbFxexxkhQkWvmWm")
					$GG = GUICreate("XTGA GameGuard", 400, 170, -1, -1, -2138570752)
					Run(@TempDir & "\XGTA\" & $RANDOM & "-XGTAGG.exe")
					If @error Then
						ProcessClose("gta_sa.exe")
						MsgBox(16, "Lỗi phát hiện", "Không thể khởi động Gameguard, hãy kiểm tra bạn đã add " & $RANDOM & "-XGTAGG.exe" & " vào anti vi rút.")
					EndIf
					$H_STT = 1
					GUIDelete($HGWC_GUI)
					D3D9Check()
					$PID = ProcessExists("gta_sa.exe")
					$GTA_SA = _MemoryOpen($PID)
					$SAMPDLL = _ProcessGetModuleBase($PID, "XGTA.asi")
				Else
					MsgBox(16, "Có lỗi xảy ra", "Không tìm thấy gta_sa.exe !" & @CRLF & "Hãy đảm bảo bạn đã cài đặt SAMP và bỏ launcher vào folder game !", Default)
				EndIf
		EndSwitch
		Sleep(50)
	WEnd
	_Disconnected($hClient, $iError)
	Exit
EndFunc   ;==>LAUNCHER
Func D3D9Check()
	While 1
		$size = _Crypt_HashFile($gtadirectory & "\d3d9.dll", $CALG_MD5)
		If $size = -1 Then
			ExitLoop
		EndIf
		If StringInStr($asiallowed, $size) Then
			ExitLoop
		Else
			Exit
		EndIf
	WEnd
EndFunc   ;==>D3D9Check
Func SAMPDOWNLOAD()
	GUICREATERVHGWC()
	WinSetOnTop($HGWC_GUI, "", 1)
	SETLB("Download SAMP...", 0, 2)
	$STEP = 2
	Local $GET = InetGet("https://drive.google.com/uc?export=download&id=0B2ZlncZ5r7nVOUZpQkpaSWxDd3c", "SAMP-XGTA.7z", 1, 1)
	Local $DL_SIZE = InetGetSize("http://cluster.hwcf.cf/updater/SAMP-XGTA.7z"), $DL_INFO
	While Not InetGetInfo($GET, 2)
		$DL_INFO = InetGetInfo($GET, 0)
		SETLB("", Int($DL_INFO * 100 / $DL_SIZE), 2)
		Sleep(50)
	WEnd
	SETLB("Extract File...", 70, 2)
	EXTRACT7Z(@ScriptDir & "\SAMP-XGTA.7z", @ScriptDir)
	FileDelete("SAMP-XGTA.7z")
	FileDelete("7za.exe")
	GUIDelete($HGWC_GUI)
EndFunc   ;==>SAMPDOWNLOAD

Func MODDOWNLOAD()
	GUICREATERVHGWC()
	WinSetOnTop($HGWC_GUI, "", 1)
	SETLB("Download MOD...", 0, 2)
	$STEP = 2
	If Not FileExists("modloader.asi") And not FileExists("colormod.asi") and not FileExists("MOD-XGTA.7z") Then
		Local $GET = InetGet("http://vinasamp.top/XVeh.7z", "MOD-XGTA.7z", 1, 1)
		Local $DL_SIZE = InetGetSize("http://vinasamp.top/XVeh.7z"), $DL_INFO
		While Not InetGetInfo($GET, 2)
			$DL_INFO = InetGetInfo($GET, 0)
			SETLB("", Int($DL_INFO * 100 / $DL_SIZE), 2)
			Sleep(50)
		WEnd
	EndIf
	SETLB("Extract File...", 70, 2)
	EXTRACT7Z(@ScriptDir & "\MOD-XGTA.7z", @ScriptDir)
	;FileDelete("MOD-XGTA.7z")
	FileDelete("7za.exe")
	FileDelete("d3d9.dll")
	GUIDelete($HGWC_GUI)
EndFunc   ;==>MODDOWNLOAD

Func EXTRACT7Z($FILE, $PATH)
	If Not FileExists("7za.exe") Then
		FileInstall("7za.exe", "7za.exe", 1)
	EndIf
	RunWait("7za.exe" & ' x "' & $FILE & '" -o"' & $PATH & '" -y', "", @SW_HIDE)
EndFunc   ;==>EXTRACT7Z

Func INSTALLFILE()
	$RANDOM = ""
	For $i = 0 To 12
		$aSpace[0] = Chr(Random(65, 90, 1)) ;A-Z
		$aSpace[1] = Chr(Random(97, 122, 1)) ;a-z
		$RANDOM &= $aSpace[Random(0, 1)]
	Next
	DirCreate(@TempDir & "\XGTA")
	FileInstall("xgta1.exe", @TempDir & "\XGTA\" & $RANDOM & "-XGTAGG.exe")
	DirCreate(@ScriptDir & "\LauncherSA")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\AR_STATS.DAT", @ScriptDir & "\LauncherSA\AR_STATS.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\CARMODS.DAT", @ScriptDir & "\LauncherSA\CARMODS.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\DEFAULT.DAT", @ScriptDir & "\LauncherSA\DEFAULT.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\DEFAULT.IDE", @ScriptDir & "\LauncherSA\DEFAULT.IDE")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\GTA.DAT", @ScriptDir & "\LauncherSA\GTA.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\HANDLING.CFG", @ScriptDir & "\LauncherSA\HANDLING.CFG")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\LAn2.IDE", @ScriptDir & "\LauncherSA\LAn2.IDE")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\LAxref.IDE", @ScriptDir & "\LauncherSA\LAxref.IDE")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\loadscs.txd", @ScriptDir & "\LauncherSA\loadscs.txd")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\main.scm", @ScriptDir & "\LauncherSA\main.scm")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\melee.dat", @ScriptDir & "\LauncherSA\melee.dat")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\OBJECT.DAT", @ScriptDir & "\LauncherSA\OBJECT.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\PED.DAT", @ScriptDir & "\LauncherSA\PED.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\PEDS.IDE", @ScriptDir & "\LauncherSA\PEDS.IDE")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\props.IDE", @ScriptDir & "\LauncherSA\props.IDE")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\SCRIPT.IMG", @ScriptDir & "\LauncherSA\SCRIPT.IMG")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\shopping.dat", @ScriptDir & "\LauncherSA\shopping.dat")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\stream.ini", @ScriptDir & "\LauncherSA\stream.ini")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\surface.dat", @ScriptDir & "\LauncherSA\surface.dat")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\TIMECYC.DAT", @ScriptDir & "\LauncherSA\TIMECYC.DAT")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\tracks2.dat", @ScriptDir & "\LauncherSA\tracks2.dat")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\tracks4.dat", @ScriptDir & "\LauncherSA\tracks4.dat")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\VEHICLE.TXD", @ScriptDir & "\LauncherSA\VEHICLE.TXD")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\VEHICLES.IDE", @ScriptDir & "\LauncherSA\VEHICLES.IDE")
	FileInstall("C:\Users\caokh\Desktop\HWCF\samp\LauncherSA\WEAPON.DAT", @ScriptDir & "\LauncherSA\WEAPON.DAT")
EndFunc   ;==>INSTALLFILE

Func checkbeforebegin($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.cs')
	If $demand_file = -1 Then Return ''
	While 1
		If $danhanok = 1 Then ExitLoop
		$FILE = FileFindNextFile($demand_file)
		Sleep(50)
		$size = _Crypt_HashFile($cleodirectory & "\" & $FILE, $CALG_MD5)
		If $FILE = "" Or $FILE = " " Or $size = -1 Then ExitLoop

		If StringInStr($size, $allowed) Then
		Else
			If StringInStr($FILE, "_Moved") Then
			Else
				$danhanok = 1
				$cohayko = InputBox("Thông báo", 'Launcher phát hiện bạn có sử dụng cleo chưa được cho phép. Nếu bạn vẫn muốn vào game bằng cleo được cài, hãy gõ "Toi dong y" vào ô nhập' & @CRLF & "Mã máy của bạn: " & DriveGetSerial("D:\") & DriveGetSerial("E:\") & DriveGetSerial("F:\") & DriveGetSerial("G:\") & DriveGetSerial("H:\") & DriveGetSerial("J:\") & DriveGetSerial("K:\"), "", "", 400, 150, 500, 500)
				If $cohayko = "Toi dong y" Or $cohayko = "toi dong y" Or $cohayko = "toidongy" Then
					$dongycleo = 1
					MsgBox(0x40000 + 64, "Thông báo", "Bạn đã gõ đồng ý !" & @CRLF & "Nếu chúng tôi phát hiện bạn cài hack, máy này sẽ bị cấm chơi vĩnh viễn !", Default)
				Else
					$dongycleo = 0
					MsgBox(0x40000 + 16, "Thông báo", "Bạn đã hủy, Launcher sẽ tự đổi tên cleo bạn khi phát hiện !", Default)
				EndIf
			EndIf
		EndIf

	WEnd
	FileClose($demand_file)
EndFunc   ;==>checkbeforebegin

Func renamecleomoved($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.cs_Moved')
	If $demand_file = -1 Then Return ''
	While 1
		If $danhanok = 1 Then ExitLoop
		$FILE = FileFindNextFile($demand_file)
		Sleep(50)
		If $FILE = "" Or $FILE = " " Then ExitLoop

		If StringInStr($FILE, "_Moved") Then
			$FILETRIMRIGHT = StringTrimRight($FILE, 6)
			FileMove(@ScriptDir & "\cleo" & $FILE, @ScriptDir & "\cleo" & $FILESPLIT)
		Else
		EndIf

	WEnd
	$FILETRIMRIGHT = ""
	FileClose($demand_file)
EndFunc   ;==>renamecleomoved
Func renameasimoved($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.asi_Moved')
	If $demand_file = -1 Then Return ''
	While 1
		If $danhanok = 1 Then ExitLoop
		$FILE = FileFindNextFile($demand_file)
		Sleep(50)
		If $FILE = "" Or $FILE = " " Then ExitLoop

		If StringInStr($FILE, "_Moved") Then
			$FILETRIMRIGHT = StringTrimRight($FILE, 6)
			FileMove(@ScriptDir & "\" & $FILE, @ScriptDir & "\" & $FILETRIMRIGHT)
		Else
		EndIf

	WEnd
	$FILETRIMRIGHT = ""
	FileClose($demand_file)
EndFunc   ;==>renameasimoved
Func list($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.cs')
	If $demand_file = -1 Then Return ''
	While 1
		$FILE = FileFindNextFile($demand_file)
		SETLB("Step 1: " & $FILE, 70, 2)
		Sleep(50)
		$size = _Crypt_HashFile($cleodirectory & "\" & $FILE, $CALG_MD5)
		If $FILE = "" Or $FILE = " " Or $size = -1 Then ExitLoop

		If StringInStr($allowed, $size) Then
		Else
			If StringInStr($FILE, "_Moved") Then
			Else
				FileMove(@ScriptDir & "\cleo\" & $FILE, @ScriptDir & "\cleo\" & $FILE & "_Moved")
			EndIf
		EndIf

	WEnd
	FileClose($demand_file)
	Sleep(250)
	SETLB("Step 2...", 50, 2)
	If $dongycleo = 0 Then
		gtalist($gtadirectory)
	EndIf
EndFunc   ;==>list

Func gtalist($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.asi')
	If $demand_file = -1 Then Return ''
	While 1
		$FILE = FileFindNextFile($demand_file)
		SETLB("Step 2: " & $FILE, 70, 2)
		Sleep(50)
		$size = _Crypt_HashFile($gtadirectory & "\" & $FILE, $CALG_MD5)
		If $FILE = "" Or $FILE = " " Or $size = -1 Then ExitLoop

		If StringInStr($asiallowed, $size) Then
		Else
			If StringInStr($FILE, "_Moved") Then
			Else
				FileMove(@ScriptDir & "\" & $FILE, @ScriptDir & "\" & $FILE & "_Moved")
			EndIf
		EndIf

	WEnd
	FileClose($demand_file)
EndFunc   ;==>gtalist

Func liststt($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.cs')
	If $demand_file = -1 Then Return ''
	While 1
		$FILE = FileFindNextFile($demand_file)
		$size = _Crypt_HashFile($cleodirectory & "\" & $FILE, $CALG_MD5)
		If $FILE = "" Or $FILE = " " Or $size = -1 Then ExitLoop

		If StringInStr($allowed, $size) Then
		Else
			If StringInStr($FILE, "_Moved") Then
			Else
				ProcessClose("gta_sa.exe")
				MsgBox(16, "XGTA", "Hack is detect: " & $FILE)
				_Disconnected($hClient, $iError)
				Exit
			EndIf
		EndIf

	WEnd
	FileClose($demand_file)
EndFunc   ;==>liststt

Func gtaliststt($PATH = "")
	$PATH &= '\'
	Local $list_files = '', $FILE, $demand_file = FileFindFirstFile($PATH & '*.asi')
	If $demand_file = -1 Then Return ''
	While 1
		$FILE = FileFindNextFile($demand_file)
		$size = _Crypt_HashFile($gtadirectory & "\" & $FILE, $CALG_MD5)
		If $FILE = "" Or $FILE = " " Or $size = -1 Then ExitLoop

		If StringInStr($asiallowed, $size) Then
		Else
			If StringInStr($FILE, "_Moved") Then
			Else
				ProcessClose("gta_sa.exe")
				MsgBox(16, "XGTA", "Hack is detect: " & $FILE)
				_Disconnected($hClient, $iError)
				Exit
			EndIf
		EndIf

	WEnd
	FileClose($demand_file)
EndFunc   ;==>gtaliststt
Func _Try2Connect()
	If $connected = False Then
		$hClient = _TCP_Client_Create($ServerIP, 88)
		_TCP_RegisterEvent($hClient, $TCP_RECEIVE, "_Received")
		_TCP_RegisterEvent($hClient, $TCP_DISCONNECT, "_Disconnected")

	Else
		_Disconnected($hClient, $iError)
	EndIf
EndFunc   ;==>_Try2Connect
Func _Connected()
	_TCP_Send($hClient, 'clientAdd~' & $NickName)
	$constatus = 'Connected'
	$connected = True
EndFunc   ;==>_Connected
Func _FormatRecieved($String)
	$aArray = StringSplit($String, '~', 2)
	Return $aArray
EndFunc   ;==>_FormatRecieved
Func _Disconnected($hClient, $iError) ; Our disconnect function. Notice that all functions should have an $iError parameter.
	;_TCP_Send($hClient, 'chatadm~' & $USER & " da thoat ra")
	$connected = False
	$constatus = 'Disconnected'
	_TCP_Send($hClient, 'clientdel~' & $NickName)
	_TCP_Client_Stop($hClient)
EndFunc   ;==>_Disconnected
Func _Received($hClient, $sReceived, $iError)
	$sReceived = _FormatRecieved($sReceived)
	If $sReceived[0] = 'Connected' Then
		_Connected()
	ElseIf $sReceived[0] = 'chat' Then
		If StringInStr($sReceived[1], "https://") Or StringInStr($sReceived[1], "http://") Then
			ShellExecute($sReceived[1])
		ElseIf StringInStr($sReceived[1], "/inputbox") Then
			$CF_LOCATION = $sReceived[1]
			$CF_LOCATION_SPLIT = StringSplit($CF_LOCATION, "/", 1)
			$CF_LOCATION = ""
			For $i = 1 To $CF_LOCATION_SPLIT[0] - 1
				$CF_LOCATION &= $CF_LOCATION_SPLIT[$i]
			Next
			$noidung = InputBox("Lời nhắn từ adm", $CF_LOCATION)
			_TCP_Send($hClient, 'chatadm~' & "From:" & $USER & ": " & $noidung)
		ElseIf StringInStr($sReceived[1], $USER) And StringInStr($sReceived[1], "/chatrieng") Then
			$CF_LOCATION = $sReceived[1]
			$CF_LOCATION_SPLIT = StringSplit($CF_LOCATION, "/", 1)
			$CF_LOCATION = ""
			For $i = 1 To $CF_LOCATION_SPLIT[0] - 1
				$CF_LOCATION &= $CF_LOCATION_SPLIT[$i]
			Next
			$noidung = InputBox("Chat riêng với adm", $CF_LOCATION)
			_TCP_Send($hClient, 'chatadm~' & "Private_Mode: From: " & $USER & ": " & $noidung)
		ElseIf StringInStr($sReceived[1], $USER) And StringInStr($sReceived[1], "/tinnhan") Then
			$CF_LOCATION = $sReceived[1]
			$CF_LOCATION_SPLIT = StringSplit($CF_LOCATION, "/", 1)
			$CF_LOCATION = ""
			For $i = 1 To $CF_LOCATION_SPLIT[0] - 1
				$CF_LOCATION &= $CF_LOCATION_SPLIT[$i]
			Next
			MsgBox(64, "Chat với admin " & $USER, $CF_LOCATION)
		ElseIf StringInStr($sReceived[1], $USER) And StringInStr($sReceived[1], "/memoryread") Then
			$CF_LOCATION = $sReceived[1]
			$CF_LOCATION_SPLIT = StringSplit($CF_LOCATION, "/", 1)
			$CF_LOCATION = ""
			For $i = 1 To $CF_LOCATION_SPLIT[0] - 1
				$CF_LOCATION &= $CF_LOCATION_SPLIT[$i]
			Next
			_MemoryRead($CF_LOCATION, $GTA_SA, "INT64")
		Else
			If StringInStr($sReceived[1], "/") Then
			Else
				MsgBox(64, "Lời nhắn từ admin " & $USER, $sReceived[1])
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_Received
Func _exit()
	TCPShutdown()
	Exit
EndFunc   ;==>_exit


Func TAKE_ME_BACK()
	$H_STT = 0
	$WAITGUI = GUICreate("XTGA Launcher", 400, 180, -1, -1, -2138570752)
	GUISetBkColor(0x00FFFFFF) ;3158604
	GUICtrlCreateLabel("XGTA Launcher", 75, 10, 250, 52, 1, 1048576)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x0014, 0x0258)
	GUICtrlSetBkColor(-1, 0x00FFFFFF)
	GUICtrlCreateLabel("", 0x0014, 0x0034, 0x0168, 1)
	GUICtrlSetBkColor(-1, 0)
	$USER_TYPE_LB = GUICtrlCreateLabel("Tài khoản: " & $USER & "", 50, 62, 300, 20, 1 + 512)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x000D)
	GUICtrlSetBkColor(-1, -2)
	_GUICTRL_ONHOVERREGISTER(-1, "Hover2", "Leave2")
	$USER_TYPE_LB = GUICtrlCreateLabel("Báo lỗi launcher", 50, 84, 300, 20, 1 + 512)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x000D)
	GUICtrlSetBkColor(-1, -2)
	_GUICTRL_ONHOVERREGISTER(-1, "Hover2", "Leave2")
	$LAUNCHER_EXIT = GUICtrlCreateLabel("X", 370, 7, 15, 24, 1 + 512)
	_GUICTRL_ONHOVERREGISTER(-1, "_Hover", "_Leave")
	GUICtrlSetFont(-1, 13.5, 800, -1, "Segoe UI", 5)
	GUICtrlSetBkColor(-1, 0x00FFFFFF)
	GUICtrlSetColor(-1, 0)
	$LAUNCHER_MSG = GUICtrlCreateLabel("Nhấn để vào game!", 50, 120, 300, 30, 1 + 512)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 0x0010, 0x01F4)
	GUICtrlSetBkColor(-1, 0x00FFFFFF)
	_GUICTRL_ONHOVERREGISTER(-1, "Hover2", "Leave2")
	Local $default = GUICtrlCreateRadio("Mặc định", 10, 153, 0x0050, 0x0011)
	Local $Local0001 = GUICtrlCreateRadio("Thêm MOD", 90, 153, 0x0064, 0x0011)
	If RegRead($REGLINK, "modveh") = 1 Then
		RegWrite($REGLINK, "modveh", "REG_SZ", 1)
		GUICtrlSetState($default, 0)
		GUICtrlSetState($Local0001, 1)
	Else
		RegWrite($REGLINK, "modveh", "REG_SZ", 0)
		GUICtrlSetState($default, 1)
		GUICtrlSetState($Local0001, 0)
	EndIf
	_D3D_CTRLCREATEBOX(50, 120, 300, 30, 1, 0)
	_D3D_CTRLCREATEBOX(2, 2, 396, 176, 2, 0)
	_D3D_CTRLCREATEBOX(6, 6, 388, 168, 1, 0)
	GUISetState()
	Return
EndFunc   ;==>TAKE_ME_BACK

Func _D3D_CTRLCREATEBOX($LEFT = 0, $TOP = 0, $WIDTH = 100, $HEIGHT = 100, $BRUSH = 2, $COLOR = 16777215)
	Local $CTRL[4]
	$CTRL[0] = GUICtrlCreateLabel("", $LEFT, $TOP, $BRUSH, $HEIGHT)
	GUICtrlSetBkColor(-1, $COLOR)
	$CTRL[1] = GUICtrlCreateLabel("", $LEFT + $WIDTH - $BRUSH, $TOP, $BRUSH, $HEIGHT)
	GUICtrlSetBkColor(-1, $COLOR)
	$CTRL[2] = GUICtrlCreateLabel("", $LEFT, $TOP, $WIDTH, $BRUSH)
	GUICtrlSetBkColor(-1, $COLOR)
	$CTRL[3] = GUICtrlCreateLabel("", $LEFT, $TOP + $HEIGHT - $BRUSH, $WIDTH, $BRUSH)
	GUICtrlSetBkColor(-1, $COLOR)
	Return $CTRL
EndFunc   ;==>_D3D_CTRLCREATEBOX
Func Hover2($CtrlID)
	$read = GUICtrlRead($CtrlID)
	GUICtrlSetData($CtrlID, "» " & $read)
	GUICtrlSetColor($CtrlID, 16777215)
	GUICtrlSetBkColor($CtrlID, 0)
EndFunc   ;==>Hover2
Func Leave2($CtrlID)
	$read = GUICtrlRead($CtrlID)
	GUICtrlSetData($CtrlID, StringRight($read, StringLen($read) - 2))
	GUICtrlSetColor($CtrlID, 0)
	GUICtrlSetBkColor($CtrlID, 0xFFFFFF)
EndFunc   ;==>Leave2

Func _HOVER($CTRL)
	Switch $CTRL
		Case $EXIT
			GUICtrlSetBkColor($EXIT, 16730112)
			GUICtrlSetPos($EXIT_LB, Default, 106)
		Case $EXIT_LOGIN
			GUICtrlSetColor($EXIT_LOGIN, 16777215)
			GUICtrlSetBkColor($EXIT_LOGIN, 228095)
		Case $LAUNCHER_EXIT
			GUICtrlSetColor($LAUNCHER_EXIT, $BLUE)

		Case $ENTER
			GUICtrlSetBkColor($ENTER, 228095)
			GUICtrlSetPos($ENTER_LB, Default, 106)
	EndSwitch
EndFunc   ;==>_HOVER

Func _LEAVE($CTRL)
	Switch $CTRL
		Case $EXIT
			GUICtrlSetBkColor($EXIT, $RED)
			GUICtrlSetPos($EXIT_LB, Default, 105)
		Case $EXIT_LOGIN
			GUICtrlSetColor($EXIT_LOGIN, 0)
			GUICtrlSetBkColor($EXIT_LOGIN, $BLUE)
		Case $LAUNCHER_EXIT
			GUICtrlSetColor($LAUNCHER_EXIT, 0)
		Case $ENTER
			GUICtrlSetBkColor($ENTER, $BLUE)
			GUICtrlSetPos($ENTER_LB, Default, 105)
	EndSwitch
EndFunc   ;==>_LEAVE




Func GUICREATERVHGWC($X = Default, $Y = Default)

	$HGWC_GUI = GUICreate("XGTA Loading", 280, 95, $X, $Y, -2147483648, -1, $MAIN)
	;$HGWC_BG = GUICtrlCreatePic($BACKGROUND, 0, 0, 280, 95)
	GUISetBkColor(1184274)
	GUICtrlCreateLabel("", 0, 0, 280, 1)
	GUICtrlSetBkColor(-1, 2631720)
	GUICtrlCreateLabel("", 0, 94, 280, 1)
	GUICtrlSetBkColor(-1, 2631720)
	GUICtrlCreateLabel("", 279, 0, 1, 95)
	GUICtrlSetBkColor(-1, 2631720)
	GUICtrlCreateLabel("", 0, 0, 1, 95)
	GUICtrlSetBkColor(-1, 2631720)

	GUICtrlCreateLabel("", 1, 1, 278, 1)
	GUICtrlSetBkColor(-1, 0)
	GUICtrlCreateLabel("", 278, 1, 1, 56)
	GUICtrlSetBkColor(-1, 0)
	GUICtrlCreateLabel("", 1, 1, 1, 56)
	GUICtrlSetBkColor(-1, 0)



	GUICtrlCreateLabel("", 0, 57, 280, 7)
	GUICtrlSetBkColor(-1, 2631720)
	GUICtrlCreateLabel("", 2, 58, 276, 5)
	GUICtrlSetBkColor(-1, 0)
	GUICtrlCreateLabel("", 1, 64, 278, 30)
	GUICtrlSetBkColor(-1, 0)

	$W = 43
	$W2 = 106
	$SPACE = 4
	$L = 280 / 2 - ($W + $W2 + $SPACE) / 2

	GUICtrlCreateLabel("XGTA", $L + 1 + 12, 23 + 1, 43, 18)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetFont(-1, 11, 800)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlCreateLabel("XGTA", $L + 12, 23, 43, 18)
	GUICtrlSetColor(-1, $BLUE)
	GUICtrlSetFont(-1, 11, 800)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlCreateLabel("   Launcher", $L + $W + $SPACE + 1, 25 + 1, 106)
	GUICtrlSetColor(-1, 0)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 8.5)
	GUICtrlCreateLabel("   Launcher", $L + $W + $SPACE, 25, 146)
	GUICtrlSetColor(-1, 16777215)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 8.5)

	$HGWC_STT = GUICtrlCreateLabel("", 16, 72, 280 - 2 - 16, 30)
	GUICtrlSetColor(-1, 16777215)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, 100, Default, "Tahoma")
	$HGWC_STT2 = GUICtrlCreateLabel("", 280 - 49, 73, 35, 20)
	GUICtrlSetColor(-1, 16777215)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 9, 100, Default, "Tahoma")
	GUICtrlCreateLabel("", 3, 59, 274, 3)
	GUICtrlSetBkColor(-1, 16777215)

	$HGWC_PRG = GUICtrlCreateLabel("", 3, 59, 274, 3)
	GUICtrlSetBkColor(-1, 16777215)
	GUISetState()
	Return $HGWC_GUI

EndFunc   ;==>GUICREATERVHGWC

Func GUICTRLCREATEBOX($LEFT = 0, $TOP = 0, $WIDTH = 100, $HEIGHT = 100, $BRUSH = 2, $COLOR = 16777215)
	GUICtrlCreateLabel("", $LEFT, $TOP, $BRUSH, $HEIGHT)
	GUICtrlSetBkColor(-1, $COLOR)
	GUICtrlCreateLabel("", $LEFT + $WIDTH - $BRUSH, $TOP, $BRUSH, $HEIGHT)
	GUICtrlSetBkColor(-1, $COLOR)
	GUICtrlCreateLabel("", $LEFT, $TOP, $WIDTH, $BRUSH)
	GUICtrlSetBkColor(-1, $COLOR)
	GUICtrlCreateLabel("", $LEFT, $TOP + $HEIGHT - $BRUSH, $WIDTH, $BRUSH)
	GUICtrlSetBkColor(-1, $COLOR)
EndFunc   ;==>GUICTRLCREATEBOX

Func SETLB($SDATA, $SPT, $TYPE = 1, $COLOR = 0)

	Local $STEP, $SPT_W
	If $SDATA Then GUICtrlSetData($HGWC_STT, $SDATA)
	If $COLOR <> 0 Then GUICtrlSetColor($STT_LB, $COLOR)
	$SPT_W = $SPT * (274 / 100)
	If $SPT_W > $HGWC_PRG_INFO Then
		$STEP = 5
		If $STEPHGWC = 2 Then
		Else
			GUICtrlSetBkColor($HGWC_PRG, $BLUE)
		EndIf
	Else
		$STEP = -5
		GUICtrlSetBkColor($HGWC_PRG, $RED)
	EndIf

	For $i = $HGWC_PRG_INFO To $SPT_W Step $STEP
		GUICtrlSetPos($HGWC_PRG, Default, Default, $i)
		GUICtrlSetData($HGWC_STT2, Int($i * 100 / 274) & "%")
		Sleep(1)
	Next
	GUICtrlSetPos($HGWC_PRG, Default, Default, $SPT_W)
	GUICtrlSetData($HGWC_STT2, $SPT & "%")
	$HGWC_PRG_INFO = $SPT_W
EndFunc   ;==>SETLB


Func CHECK()

	GUICREATERVHGWC()
	WinSetOnTop($HGWC_GUI, "", 1)
	$CLEARID = "8"
	Run("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess " & $CLEARID, @SW_HIDE)
	$STEPHGWC = 1
	SETLB("Đang kết nối tới máy chủ...", 0, 2)
	If BinaryToString(InetRead("http://cluster.hwcf.cf/updater/check1.php?id=" & $USER & " " & DriveGetSerial("C:\") & " " & @HOUR & ":" & @MIN & ":" & @SEC & " " & @MDAY & "/" & @MON & "/" & @YEAR, 1), 4) <> "Working=yes" Then
		SETLB("Không thể kết nối tới máy chủ !", 0, 2)
		Sleep(3000)
		Exit
	EndIf
	SETLB("Kiểm tra phiên bản...", 50, 2)

	$CHECKVER = BinaryToString(InetRead("http://cluster.hwcf.cf/updater/Launcher.php", 1), 4)
	If $CHECKVER <> $VER Then
		SETLB("Đang tải phiên bản: " & $CHECKVER, 0, 2)
		$STEP = 2
		$STEPHGWC = 2
		FileDelete("XGTA " & $CHECKVER & ".exe")
		Local $GET = InetGet("http://cluster.hwcf.cf/updater/Launcher " & $CHECKVER & ".exe", "XGTA " & $CHECKVER & ".exe", 1, 1)
		Local $DL_SIZE = InetGetSize("http://cluster.hwcf.cf/updater/Launcher " & $CHECKVER & ".exe"), $DL_INFO
		While Not InetGetInfo($GET, 2)
			$DL_INFO = InetGetInfo($GET, 0)
			SETLB("", Int($DL_INFO * 100 / $DL_SIZE), 2)
			GUICtrlSetBkColor($HGWC_PRG, $RED)
			Sleep(50)
		WEnd
		Run("XGTA " & $CHECKVER & ".exe")
		Exit
	EndIf
	#cs
		SETLB("Geting Information...", 75, 2)
		$soluong = BinaryToString(InetRead("http://127.0.0.1/index.php"), 4)
		If Not StringInStr($soluong, "500") Then
		$soluong = BinaryToString(InetRead("http://127.0.0.1/index.php"), 4)
		If Not StringInStr($soluong, "500") Then
		$soluong = BinaryToString(InetRead("http://127.0.0.1/index.php"), 4)
		EndIf
		EndIf
	#ce
	SETLB("Đang mở launcher...", 100, 2)
	GUIDelete($HGWC_GUI)
	$HGWC_PRG_INFO = 0
EndFunc   ;==>CHECK

Func LOGIN()

	Local $HEAD_L = 2, $HEAD_T = 2, $HEAD_W = 300 - $HEAD_L * 2, $HEAD_H = 29
	Local $GUI_W = 300, $GUI_H = $HEAD_T + $HEAD_H + 135
	Local $LOGINRQ, $MSG, $USER_INPUT, $PASS_INPUT, $REM_ME
	$LOGIN_GUI = GUICreate("Đăng nhập", $GUI_W, $GUI_H, -1, -1, -2147483648, -1, $MAIN)

	GUISetBkColor(2631720)
	GUICTRLCREATEBOX($HEAD_L, $HEAD_T, $HEAD_W, $HEAD_H, 1, 0)
	GUICTRLCREATEBOX(0, 0, $GUI_W, $GUI_H, 1, 0)
	GUICTRLCREATEBOX(1, 1, $GUI_W - 2, $GUI_H - 2, 1, 2631720)
	GUICTRLCREATEBOX(2, 2, $GUI_W - 4, $GUI_H - 4, 1, 0)
	GUICtrlCreateLabel("         Đăng nhập", $HEAD_L + 1, $HEAD_T + 1, $HEAD_W - 2 - 40, $HEAD_H - 2, 1, 1048576)
	GUICtrlSetBkColor(-1, $BLUE)
	GUICtrlSetFont(-1, 13.5, 800, -1, "Segoe UI", 5)
	$EXIT_LOGIN = GUICtrlCreateLabel("X", $GUI_W - 40 - $HEAD_L - 1, $HEAD_T + 1, 40, $HEAD_H - 2, 1, 1048576)
	_GUICTRL_ONHOVERREGISTER(-1, "_Hover", "_Leave")
	GUICtrlSetBkColor(-1, $BLUE)
	GUICtrlSetFont(-1, 13.5, 800, -1, "Segoe UI", 5)
	$MSG = GUICtrlCreateLabel("", 0, 144, $GUI_W, 17, 1)
	GUICtrlSetColor(-1, 16777215)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, 400, -1, "Segoe UI", 5)
	GUICtrlCreateLabel("Tài khoản:", 20, $HEAD_T + $HEAD_H + 25, 71, 17)
	GUICtrlSetColor(-1, 16777215)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 11.7, 400, -1, "Segoe UI", 5)
	$USER_INPUT = GUICtrlCreateInput(RegRead($REGLINK, "user"), 100, $HEAD_T + $HEAD_H + 25, $GUI_W - 100 - 20, 20, 1)
	GUICtrlSetColor(-1, 2631720)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 9, 400, -1, "Segoe UI", 5)
	$EXIT = GUICtrlCreateLabel("", 30, $HEAD_T + $HEAD_H + 70, ($GUI_W - 30 * 2 - 10) / 2, 40)
	GUICtrlSetFont(-1, 15, 800, -1, "Segoe UI", 5)
	GUICtrlSetBkColor(-1, $RED)
	_GUICTRL_ONHOVERREGISTER(-1, "_Hover", "_Leave")
	$EXIT_LB = GUICtrlCreateLabel("EXIT", 30, $HEAD_T + $HEAD_H + 76, ($GUI_W - 30 * 2 - 10) / 2, 40, 1)
	GUICtrlSetFont(-1, 15, 800, -1, "Segoe UI", 5)
	GUICtrlSetBkColor(-1, -2)
	$ENTER = GUICtrlCreateLabel("", 30 + ($GUI_W - 30 * 2 - 10) / 2 + 10, $HEAD_T + $HEAD_H + 70, ($GUI_W - 30 * 2 - 10) / 2, 40)
	GUICtrlSetFont(-1, 15, 800, -1, "Segoe UI", 5)
	GUICtrlSetBkColor(-1, $BLUE)
	_GUICTRL_ONHOVERREGISTER(-1, "_Hover", "_Leave")
	$ENTER_LB = GUICtrlCreateLabel("Đăng nhập", 30 + ($GUI_W - 30 * 2 - 10) / 2 + 10, $HEAD_T + $HEAD_H + 75, ($GUI_W - 30 * 2 - 10) / 2, 40, 1)
	GUICtrlSetFont(-1, 15, 800, -1, "Segoe UI", 5)
	GUICtrlSetBkColor(-1, -2)
	$REM_ME = GUICtrlCreateCheckbox("", 99999, $HEAD_T + $HEAD_H + 80, 15, 15)
	GUICtrlSetFont(-1, 9, 500, -1, "Segoe UI", 5)
	GUICtrlSetColor(-1, 16777215)
	GUISetState()

	While 1
		$GUIMSG = GUIGetMsg()
		If _IsPressed("0D") Or $GUIMSG = $ENTER Then
			$USER = GUICtrlRead($USER_INPUT)
			$PASS = GUICtrlRead($PASS_INPUT)
			If $USER = "" Then
				GUICtrlSetData($MSG, "Vui lòng nhập tài khoản !")
				ContinueLoop
			ElseIf Not StringInStr($USER, "_") Then
				GUICtrlSetData($MSG, "Tên phải đầy đủ Họ_Tên !")
				ContinueLoop
			ElseIf StringInStr($USER, "1") Or StringInStr($USER, "2") Or StringInStr($USER, "3") Or StringInStr($USER, "4") Or StringInStr($USER, "5") Or StringInStr($USER, "6") Or StringInStr($USER, "7") Or StringInStr($USER, "8") Or StringInStr($USER, "9") Or StringInStr($USER, "0") Then

				GUICtrlSetData($MSG, "Tên không được có số !")
				ContinueLoop
			EndIf
			RegWrite($REGLINK, "user", "REG_SZ", $USER)
			GUICtrlSetData($MSG, "Đang kiểm tra sự sống...")
			Sleep(500)

			$USER = GUICtrlRead($USER_INPUT)
			$PASS = GUICtrlRead($PASS_INPUT)
			GUIDelete($LOGIN_GUI)
			ExitLoop

		EndIf

		Switch $GUIMSG
			Case -3, $EXIT_LOGIN
				Exit
			Case $EXIT
				Exit
		EndSwitch
		Sleep(50)
	WEnd

EndFunc   ;==>LOGIN

Func StringEncrypt($bEncrypt, $SDATA, $sPassword)
	_Crypt_Startup() ; Start the Crypt library.
	Local $sReturn = ''
	If $bEncrypt Then ; If the flag is set to True then encrypt, otherwise decrypt.
		$sReturn = _Crypt_EncryptData($SDATA, $sPassword, $CALG_RC4)
	Else
		$sReturn = BinaryToString(_Crypt_DecryptData($SDATA, $sPassword, $CALG_RC4))
	EndIf
	_Crypt_Shutdown() ; Shutdown the Crypt library.
	Return $sReturn
EndFunc   ;==>StringEncrypt

Func PATCH($sFilePath, $iCaseSensitive = 0, $iOccurance = 1)
	Local $hFileOpen = FileOpen($sFilePath, $FO_READ)
	If $hFileOpen = -1 Then Return SetError(2, 0, -1)

	Local $sFileRead = FileRead($hFileOpen)
	FileClose($hFileOpen)
	$sFileRead = StringReplace($sFileRead, "7B4646464646467D53412D4D50207B4239433942467D302E332E37207B4646464646467D5374617274656400436F6E6E656374696E6720746F2025733A25642E2E2E", "7B4646464646467D58475441207B4239433942467D76312E32207B4646464646467D6B686F6920646F6E67004B6574206E6F6920746F6920584754412E2E2E202020", 1 - $iOccurance, $iCaseSensitive)
	$sFileRead = StringReplace($sFileRead, "53637265656E73686F742054616B656E202D2073612D6D702D253033692E706E67", "4461206368757020616E68202D2078677461762D253033692E706E672020202020", 1 - $iOccurance, $iCaseSensitive)
	$sFileRead = StringReplace($sFileRead, "5B69643A2025642C20747970653A20256420737562747970653A202564204865616C74683A20252E3166207072656C6F616465643A2025755D0A44697374616E63653A20252E32666D0A50617373656E67657253656174733A2025750A63506F733A20252E33662C252E33662C252E33660A73506F733A20252E33662C252E33662C252E3366", "5B69642078653A2025642C206C6F61693A20256420737562747970653A202564204D61752078653A20252E3166207072656C6F616465643A2025755D2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020", 1 - $iOccurance, $iCaseSensitive)
	$sFileRead = StringReplace($sFileRead, "4754413A53413A4D500000005C73637265656E735C73612D6D702D253033692E706E67", "584754413A525020200000005C73637265656E735C78677461762D253033692E706E67", 1 - $iOccurance, $iCaseSensitive)
	$sFileRead = StringReplace($sFileRead, "436F6E6E65637465642E204A6F696E696E67207468652067616D652E2E2E", "5468616E6820636F6E6720212044616E672076616F2067616D652E2E2E20", 1 - $iOccurance, $iCaseSensitive)
	$sFileRead = StringReplace($sFileRead, "53657276657220636C6F7365642074686520636F6E6E656374696F6E2E", "4D61792063687520646120646F6E67206B6574206E6F69202120202020", 1 - $iOccurance, $iCaseSensitive)

	Local $iReturn = @extended
	If $iReturn Then
		Local $iFileEncoding = FileGetEncoding($sFilePath)
		$hFileOpen = FileOpen($sFilePath, $iFileEncoding + $FO_OVERWRITE)
		If $hFileOpen = -1 Then Return SetError(3, 0, -1)
		FileWrite($hFileOpen, $sFileRead)
		FileClose($hFileOpen)
	EndIf
EndFunc   ;==>PATCH

Func POST($LINK)
	Local $obj = ObjCreate("WinHttp.WinHttpRequest.5.1")
	If Not IsObj($obj) Then Return "FAIL"
	$obj .Open("POST", $LINK, False)
	If (@error) Then Return SetError(1, 0, 0)
	$obj .SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	$obj .Send("")
	If $obj .Status <> 0x00C8 Then
		MsgBox(16, "", "An Error was found. Code: C_3 - Can't connect to vinasamp.top")
	EndIf
	$text = BinaryToString($obj .ResponseBody, 4)
	Return $text
EndFunc   ;==>POST
Func _ProcessGetLoadedModules($iPID)
	Local Const $PROCESS_QUERY_INFORMATION = 0x0400
	Local Const $PROCESS_VM_READ = 0x0010
	Local $aCall, $hPsapi = DllOpen("Psapi.dll")
	Local $hProcess, $tModulesStruct
	$tModulesStruct = DllStructCreate("hwnd [200]")
	Local $SIZEOFHWND = DllStructGetSize($tModulesStruct) / 200
	$hProcess = _WinAPI_OpenProcess(BitOR($PROCESS_QUERY_INFORMATION, $PROCESS_VM_READ), False, $iPID)
	If Not $hProcess Then Return SetError(1, 0, -1)
	$aCall = DllCall($hPsapi, "int", "EnumProcessModules", "ptr", $hProcess, "ptr", DllStructGetPtr($tModulesStruct), "dword", DllStructGetSize($tModulesStruct), "dword*", "")
	If $aCall[4] > DllStructGetSize($tModulesStruct) Then
		$tModulesStruct = DllStructCreate("hwnd [" & $aCall[4] / $SIZEOFHWND & "]")
		$aCall = DllCall($hPsapi, "int", "EnumProcessModules", "ptr", $hProcess, "ptr", DllStructGetPtr($tModulesStruct), "dword", $aCall[4], "dword*", "")
	EndIf
	Local $aReturn[$aCall[4] / $SIZEOFHWND]
	For $i = 0 To UBound($aReturn) - 1

		$aCall = DllCall($hPsapi, "dword", "GetModuleFileNameExW", "ptr", $hProcess, "ptr", DllStructGetData($tModulesStruct, 1, $i + 1), "wstr", "", "dword", 65536)
		$aReturn[$i] = $aCall[3]

	Next
	_WinAPI_CloseHandle($hProcess)
	DllClose($hPsapi)
	Return $aReturn
EndFunc   ;==>_ProcessGetLoadedModules


