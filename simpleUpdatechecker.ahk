/*
A simple multithreaded  github update checker 

Author : ananthuthilakan 
dischord : discretecourage#0179
Website : ananthuthilakan.com
github : https://github.com/ananthuthilakan/Github_Update_Checker/edit/main/simpleUpdatechecker.ahk
Blog_Url : 
Credits : Hotkeyit , ahktojson by teadrinker 
*/


#SingleInstance, Force
#NoEnv
#Persistent  ; this is added because other wise script will exit due to no other things to execute
            ; when you add more parts in the script you can remove this
SetBatchLines -1




;=============== CURRENT VERSION ==================================

Current_version:="v1.0.0.0"  ; In github always create new release tag in this pattern

;==================================================================

Updatechecker=
(

#NoTrayIcon
AhkExe := AhkExported()  ; ahkExe.AhkGetVar.variable

repoOwner := "ananthuthilakan"                  ; Change to your repository Owner Name
repoName := "Github_Update_Checker"             ; Your Repository Name

try
{
url := "https://api.github.com/repos/" repoOwner "/" repoName "/releases/latest"
WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttpReq.Open("GET", url)
WinHttpReq.Send()
data:=JsonToAHK(WinHttpReq.ResponseText)

Current_version:=ahkExe.AhkGetVar.Current_version

latest_version := StrSplit(data["html_url"],"/")[8]

}



if (Current_version!=latest_version) && (latest_version)
    {
MsgBox 0x40044, New Update Available, Your current version   : `%Current_version`% ``nNew version available   : `%latest_version`%``n``nDo you want to update ?

IfMsgBox Yes, {
    Try 
    Run,`% "https://github.com/" repoOwner "/" repoName "/releases/latest"  ; "https://github.com/" repoOwner "/" repoName "/releases/latest/download/your_file_to_download"

} Else IfMsgBox No, {

}
    }
ExitApp

AhkExported(){
  static init,functions
  If !init{
    init:=Object(),functions:="ahkFunction:s==sssssssssss|ahkPostFunction:s==sssssssssss|ahkassign:ui==ss|ahkExecuteLine:t==tuiui|ahkFindFunc:t==s|ahkFindLabel:t==s|ahkgetvar:s==sui|ahkLabel:ui==sui|ahkPause:i==s"
    If (DllCall((exe:=!A_AhkPath?A_ScriptFullPath:A_AhkPath) "\ahkgetvar","Str","A_AhkPath","UInt",0,"CDecl Str"))
      functions.="|addFile:t==si|addScript:t==si|ahkExec:ui==s"
    Loop,Parse,functions,|
		{v:=StrSplit(A_LoopField,":"),init[v.1]:=DynaCall(exe "\" v.1,v.2)
		If (v.1="ahkFunction")
			init["_" v.1]:=DynaCall(exe "\" v.1,"s==stttttttttt")
		else if (v.1="ahkPostFunction")
			init["_" v.1]:=DynaCall(exe "\" v.1,"i==stttttttttt")
		}
  }
  return init
}


JsonToAHK(json, rec := false) {
    static doc := ComObjCreate("htmlfile")
          , __ := doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
          , JS := doc.parentWindow
    if !rec
       obj := `%A_ThisFunc`%(JS.eval("(" . json . ")"), true)
    else if !IsObject(json)
       obj := json
    else if JS.Object.prototype.toString.call(json) == "[object Array]" {
       obj := []
       Loop `% json.length
          obj.Push( `%A_ThisFunc`%(json[A_Index - 1], true) )
    }
    else {
       obj := {}
       keys := JS.Object.keys(json)
       Loop `% keys.length {
          k := keys[A_Index - 1]
          obj[k] := `%A_ThisFunc`%(json[k], true)
       }
    }
    Return obj
 }
;  return

)

dll:=AhkThread(Updatechecker)

;============================================================================================================================================


; Your orginal script goes here 



;============================================================================================================================================
return
