
I've written a drop in replacement to the PMPRO62F.DLL that is installed to C:\DISNEY\COLDSHDW when installing the game.

This is simply a dummy version of the DLL, that just exports at least 26 functions. These functions just return immediately (doing nothing).

This is to avoid problems that normally happen with the entrypoint of this DLL is executed.

I've included the source code as a .asm file that can be very easily assembled with fasm. Simply open fasmw.exe, open the .asm file, the choose to compile the file through fasmw's menu.
