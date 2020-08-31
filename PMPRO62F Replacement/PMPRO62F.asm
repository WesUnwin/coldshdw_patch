
; DLL creation example

format PE GUI 4.0 DLL
entry DllEntryPoint

include 'win32a.inc'

section '.text' code readable executable

proc DllEntryPoint hinstDLL,fdwReason,lpvReserved
        mov     eax,TRUE
        ret
endp


proc ExportedFunction1 hWnd,dwError
    ;invoke  MessageBox,HWND_DESKTOP,"ExportedFunction1 Called", "Title", MB_ICONERROR+MB_OK
    ret
endp

proc ExportedFunction2 hWnd,dwError
    ret
endp

proc ExportedFunction3 hWnd,dwError
    ret
endp

proc ExportedFunction4 hWnd,dwError
    ret
endp

proc ExportedFunction5 hWnd,dwError
    ret
endp

proc ExportedFunction6 hWnd,dwError
    ret
endp

proc ExportedFunction7 hWnd,dwError
    ret
endp

proc ExportedFunction8 hWnd,dwError
    ret
endp

proc ExportedFunction9 hWnd,dwError
    ret
endp

proc ExportedFunction10 hWnd,dwError
    ret
endp

proc ExportedFunction11 hWnd,dwError
    ret
endp

proc ExportedFunction12 hWnd,dwError
    ret
endp

proc ExportedFunction13 hWnd,dwError
    ret
endp

proc ExportedFunction14 hWnd,dwError
    ret
endp

proc ExportedFunction15 hWnd,dwError
    ret
endp

proc ExportedFunction16 hWnd,dwError
    ret
endp

proc ExportedFunction17 hWnd,dwError
    ret
endp

proc ExportedFunction18 hWnd,dwError
    ret
endp

proc ExportedFunction19 hWnd,dwError
    ret
endp

proc ExportedFunction20 hWnd,dwError
    ret
endp

proc ExportedFunction21 hWnd,dwError
    ret
endp

proc ExportedFunction22 hWnd,dwError
    ret
endp

proc ExportedFunction23 hWnd,dwError
    ret
endp

proc ExportedFunction24 hWnd,dwError
    ret
endp

proc ExportedFunction25 hWnd,dwError
    ret
endp

proc ExportedFunction26 hWnd,dwError
    ret
endp

proc ExportedFunction27 hWnd,dwError
    ret
endp

proc ExportedFunction28 hWnd,dwError
    ret
endp

section '.idata' import data readable writeable

  library user,'USER32.DLL'

  import user,\
         MessageBox,'MessageBoxA'

section '.edata' export data readable

  export 'PMPRO62F.DLL',\
         ExportedFunction1,'ExportedFunction1',\
         ExportedFunction2,'ExportedFunction2',\
         ExportedFunction3,'ExportedFunction3',\
         ExportedFunction4,'ExportedFunction4',\
         ExportedFunction5,'ExportedFunction5',\
         ExportedFunction6,'ExportedFunction6',\
         ExportedFunction7,'ExportedFunction7',\
         ExportedFunction8,'ExportedFunction8',\
         ExportedFunction9,'ExportedFunction9',\
         ExportedFunction10,'ExportedFunction10',\
         ExportedFunction11,'ExportedFunction11',\
         ExportedFunction12,'ExportedFunction12',\
         ExportedFunction13,'ExportedFunction13',\
         ExportedFunction14,'ExportedFunction14',\
         ExportedFunction15,'ExportedFunction15',\
         ExportedFunction16,'ExportedFunction16',\
         ExportedFunction17,'ExportedFunction17',\
         ExportedFunction18,'ExportedFunction18',\
         ExportedFunction19,'ExportedFunction19',\
         ExportedFunction20,'ExportedFunction20',\
         ExportedFunction21,'ExportedFunction21',\
         ExportedFunction22,'ExportedFunction22',\
         ExportedFunction23,'ExportedFunction23',\
         ExportedFunction24,'ExportedFunction24',\
         ExportedFunction25,'ExportedFunction25',\
         ExportedFunction26,'ExportedFunction26',\
         ExportedFunction27,'ExportedFunction27',\
         ExportedFunction28,'ExportedFunction28'

section '.reloc' fixups data readable discardable

  if $=$$
    dd 0,8              ; if there are no fixups, generate dummy entry
  end if
