I produced this patched verion of WDIR62F.DLL by using a tool: ollydbg 1.10, to replace certain chunks of machine code (3 areas) with NOP instructions.


The real problem is that this DLL is dependent on a function called "QT_Thunk", removed from newer versions of Kernel32.DLL that allowed
32 bit applications to call 16 bit code.

WDIR62F.DLL attempts to access this as shown below:

00360F86                      |. 68 71023700    PUSH WDIR62F.00370271                             ; /ProcNameOrOrdinal = "QT_Thunk"
00360F8B                      |. FF36           PUSH DWORD PTR DS:[ESI]                           ; |hModule
00360F8D                      |. E8 C1440000    CALL <JMP.&KERNEL32.GetProcAddress>               ; \GetProcAddress
00360F92                      |. A3 441F3700    MOV DWORD PTR DS:[371F44],EAX

This results in later code that checks if this function's address was successfully obtained, and stored at 0X371F44:

            0FB7  cmp DWORD PTR DS:[371F44], 0                <--  proc address of Kernel32's QT_Thunk function was stored here
            0FBE  jnz WDIR62F.__0FC5                          (JUMP NOT TAKEN ON WINXP - Unlike on Win98SE)
            0FC0  xor eax, eax                                (Puts 0 in eax, which is a return value indicating failure)
            0FC2  pop esi
            0FC3  pop ebx
            0FC4  return

Here this code returns 0 (indicating failure), causing later code to display the MessageBox about not being able to link to Kernel32.DLL.


My fix just ignores this functionality which I believe would only be needed for the full screen mode anyway.


I ignored this failure, by replacing the below 3 chunks of machine code with NOP instructions, using Ollydbg 1.10:


ADDRESSES                        BYTES          BYTES DISASSEMBLED                                ANALYSIS

00360DE8                      |. 6A 30          PUSH 30                                           ; /Style = MB_OK|MB_ICONEXCLAMATION|MB_APPLMODAL
00360DEA                      |. 68 CC013700    PUSH WDIR62F.003701CC                             ; |Title = "WinDirect Error"
00360DEF                      |. 68 AC013700    PUSH WDIR62F.003701AC                             ; |Text = "Unable to link to KERNEL32.DLL!"
00360DF4                      |. 6A 00          PUSH 0                                            ; |hOwner = NULL
00360DF6                      |. E8 60470000    CALL <JMP.&USER32.MessageBoxA>                    ; \MessageBoxA
00360DFB                      |. 33C0           XOR EAX,EAX
00360DFD                      |. E9 DD000000    JMP WDIR62F.00360EDF



00360E16                      |. 6A 30          PUSH 30                                           ; /Style = MB_OK|MB_ICONEXCLAMATION|MB_APPLMODAL
00360E18                      |. 68 02023700    PUSH WDIR62F.00370202                             ; |Title = "WinDirect Error"
00360E1D                      |. 68 E7013700    PUSH WDIR62F.003701E7                             ; |Text = "Unable to load WDIR62.DLL!"
00360E22                      |. 6A 00          PUSH 0                                            ; |hOwner = NULL
00360E24                      |. E8 32470000    CALL <JMP.&USER32.MessageBoxA>                    ; \MessageBoxA
00360E29                      |. 33C0           XOR EAX,EAX
00360E2B                      |. E9 AF000000    JMP WDIR62F.00360EDF



00360E6E                      |> 6A 30          PUSH 30                                           ; |/Style = MB_OK|MB_ICONEXCLAMATION|MB_APPLMODAL
00360E70                      |. 68 45023700    PUSH WDIR62F.00370245                             ; ||Title = "WinDirect Error"
00360E75                      |. 68 27023700    PUSH WDIR62F.00370227                             ; ||Text = "Unable to link to WDIR62.DLL!"
00360E7A                      |. 6A 00          PUSH 0                                            ; ||hOwner = NULL
00360E7C                      |. E8 DA460000    CALL <JMP.&USER32.MessageBoxA>                    ; |\MessageBoxA
00360E81                      |. FF35 281F3700  PUSH DWORD PTR DS:[371F28]                        ; |String = NULL
00360E87                      |. FF15 3C1F3700  CALL DWORD PTR DS:[371F3C]                        ; \BuildCommDCBW
00360E8D                      |. 33C0           XOR EAX,EAX
00360E8F                      |. EB 4E          JMP SHORT WDIR62F.00360EDF

