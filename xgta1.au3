#EndRegion
#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Global $ON
While 1
	If ProcessExists("gta_sa.exe") Then ;and WinGetTitle("XTGA Launcher") Then
		If $ON = 0 Then
		$ON = 1
		Endif
	Endif
	If $ON = 1 and not WinGetTitle("XTGA GameGuard") Then
		$ON = 0
		ProcessClose("gta_sa.exe")
		exit
	Endif
	sleep(100)
Wend