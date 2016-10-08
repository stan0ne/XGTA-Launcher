#cs
	##########################################
	Autoit Chat By Protex (Server)
	##########################################

#ce



#include <Array.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include <TCP.au3>

Global $userArray[1], $DataString
$hConsole = GUICreate("Server Console", 200, 200, 1, 1, $WS_POPUP)
$hConsoleList = GUICtrlCreateEdit("", 10, 10, 180, 180, $ES_READONLY)

_consoleWrite('Server Started')
_consoleWrite('Server IP : ' & @IPAddress1)
GUISetState()
$hServer = _TCP_Server_Create(88) ; A server. Tadaa!
_TCP_RegisterEvent($hServer, $TCP_NEWCLIENT, "NewClient") ; Whooooo! Now, this function (NewClient) get's called when a new client connects to the server.
_TCP_RegisterEvent($hServer, $TCP_DISCONNECT, "Disconnect") ; And this,... this will get called when a client disconnects.
_TCP_RegisterEvent($hServer, $TCP_RECEIVE, "_Received")

While 1
	Sleep(50)
WEnd


Func _consoleWrite($String)
	$DataString = $DataString & @CRLF & $String
	GUICtrlSetData($hConsoleList, $DataString)
	_GUICtrlEdit_LineScroll($hConsoleList, 0, _GUICtrlEdit_GetLineCount($hConsoleList))
EndFunc   ;==>_consoleWrite
Func _FormatRecieved($String)
	$aArray = StringSplit($String, '~', 2)
	Return $aArray
EndFunc   ;==>_FormatRecieved
Func _Received($hSocket, $sReceived, $iError)
	$sReceived = _FormatRecieved($sReceived)
	If $sReceived[0] = 'clientAdd' Then
		_UserArraydel($sReceived[1], $hSocket, $iError)
		_UserArrayAdd($sReceived[1], $hSocket, $iError)
	ElseIf $sReceived[0] = 'clientdel' Then
		_UserArraydel($sReceived[1], $hSocket, $iError)
	ElseIf $sReceived[0] = 'chat' Then
		_consoleWrite('Client Broadcast' & @CRLF & '(Message: ' & $sReceived[1] & ' Socket: ' & $hSocket & ')')
		_TCP_Server_Broadcast('chat~' & $sReceived[1])
	ElseIf $sReceived[0] = 'chatadm' Then
		_consoleWrite('Client Broadcast' & @CRLF & '(Message: ' & $sReceived[1] & ' Socket: ' & $hSocket & ')')
		_TCP_Server_Broadcast('chatadm~' & $sReceived[1])
	ElseIf $sReceived[0] = 'hinhanh' Then
		_consoleWrite('Client Broadcast' & @CRLF & '(Message: hinhanh' & ' Socket: ' & $hSocket & ')')
		_TCP_Server_Broadcast('hinhanh~' & $sReceived[1])
		MsgBox(0,"server", $sReceived[1])
	EndIf
EndFunc   ;==>_Received
Func NewClient($hSocket, $iError) ; Yo, check this out! It's a $iError parameter! (In case you didn't noticed: It's in every function)
	_TCP_Send($hSocket, 'Connected')
EndFunc   ;==>NewClient

Func Disconnect($hSocket, $iError) ; Damn, we lost a client. Time of death: @Hour & @Min & @Sec :P
	_consoleWrite("Client Disconnected" & @CRLF & "(Socket: " & $hSocket & ')')
EndFunc   ;==>Disconnect

Func _UserArrayAdd($Nick, $hSocket, $iError)
	_consoleWrite("Client Connected" & @CRLF & "(NickName: " & $Nick & " Socket: " & $hSocket & ')')
	_ArrayAdd($userArray, $Nick)
	_sendUserArray($hSocket, $iError)
EndFunc   ;==>_UserArrayAdd

Func _UserArraydel($Nick, $hSocket, $iError)
	$index = _ArraySearch($userArray, $Nick, 1, UBound($userArray) - 1)
	If $index > 0 Then
		_ArrayDelete($userArray, $index)
		_sendUserArray($hSocket, $iError)
	EndIf
EndFunc   ;==>_UserArraydel

Func _sendUserArray($hSocket, $iError)
	$userString = _ArrayToString($userArray)
	_TCP_Server_Broadcast('userArray~' & $userString)
EndFunc   ;==>_sendUserArray
