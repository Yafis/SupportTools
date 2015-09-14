; ************ By Denis_Volochay  ************
; Version: 2.0

GetAskInfo(ByRef out) {
	File := FileOpen(A_MyDocuments "\GTA San Andreas User Files\SAMP\chatlog.txt", "r")
	while (!File.AtEOF) {
		RegExMatch(File.Readline(), "O)->Вопрос (.*)\[([0-9]*)\]" RegEx, OutputVar)
		if (OutputVar)
			out := OutputVar
	}
	File.Close()
	return out.Count()
}

Match(text, regexp) {
	RegExMatch(text, "O)" regexp, array)
	return array
}

#IfWinActive GTA:SA:MP
#MaxThreadsPerHotkey 2

Numpad1::
	GetAskInfo(ID)
	IDs:= ID[1]
	SendInput {F6}/pm %IDs%{space}
return

XButton2::
	GetAskInfo(ID)
	Name:= ID[1]
	IDs:= ID[2]
	SendInput {F6}/pm %IDs% %Name%, Приятной игры на 14 сервере
return

:?:/hc::
	SendInput, /hc{space}
	Input, id, V, {enter}{f6}

	File := FileOpen(A_ScriptDir "\Materials\vehicle.txt", "r")
	while (!File.AtEOF) {
		line := File.Readline()
		if (InStr(line, id)) {
			OutputVar := Match(line, "(\d+) \| (.*?) \| (.*?) \| (.*?) \| (.*?) \| (\d+)")
			SendInput, {DELETE}
			Sleep, 200
			line := Format("ID {:d} | Name {:s} | Class {:s} | Price {:s} | {:s} | Heal {:d}", OutputVar[1], OutputVar[2], OutputVar[3], OutputVar[4], OutputVar[5], OutputVar[6])
			SendInput {F6}%line%
		}
	}
	File.Close()
return

:?:/hh::
	SendInput, /hh{space}
	Input, id, V, {enter}{f6}

	File := FileOpen(A_ScriptDir "\Materials\house.txt", "r")
	while (!File.AtEOF) {
		OutputVar := Match(File.Readline(), "ID ([0-9 ]*) \| CLASS ([A-Z]*) \| COST ([0-9 ]*)")
		if (OutputVar[1] == id) {
			SendInput, {DELETE}
			Sleep, 200
			Line := "ID " OutputVar[1] " | Class " OutputVar[2] " | Cost " OutputVar[3]
			SendInput {F6}%Line%
		}
	}
	File.Close()
return