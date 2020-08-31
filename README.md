# coldshdw_patch
UPDATE:  some of these games below may be available for Steam, and it might be easier to just install/run it from there.

Fix to the "Unable to link to KERNEL32.DLL" error preventing games like Disney Interactive's Cold Shadow (For PC), from starting up.
This is a partial fix that allows the game to start up and generally be useable but does not fix the full screen functionality.

Microsoft's (closed to reply's) Article On This WinDirect Error:
https://answers.microsoft.com/en-us/windows/forum/all/windirect-error-unable-to-link-to-kernel32dll/71e37065-54a4-4799-a4b1-af423ffeb616

May also be useful for fixing other games like:
* Quake 3 / Quake 3 Arena ?
* Grand Theft Auto (GTA) 1 ?
* Toy Story Video Game


## How To Install / Use This Patch

This patch works by replacing two files (WDIR62F.DLL and PMPRO62F.DLL) in the installation folder on
your computer with replacement versions of these two files.

Easiest way to do this is download this repository as a zip folder, then copy the files in "COLDSHDW (PATCHED FILES)" in this repository overtop of the files with the same names in C:/DISNEY/COLDSHDW or wherever you installed the game.

After that simply start COLDSHDW.EXE to run the game.

IMPORTANT NOTE:  you may get a warning about Wing32.dll being located in C:\WINDOWS\SYSTEM rather than C:\WINDOWS\SYSTEM32,
if so just move (not copy) that file into the SYSTEM32 as the message is telling you to, and it should be fine.

ALSO:  this does not fix all the functionality, the following functionality is still broken (but possibly fixable with more effort):

* Control customization (such as using a joystick)  (Menu -> Options -> Controls)
* Full Screen Functionality  (Menu -> Screen -> Full Screen)


## What was the problem?

The entry point of the Win Direct DLL (WDIR62F.DLL) calls Kernel32.GetProcAddress() to access a function called "QT_Thunk" from
Kernel32.DLL (part of the windows API), this function allowing one to execute 16 bit code from 32bit windows applications was
removed from newer versions of this DLL.

16-Bit windows code generally could (unlike 32-bit windows softare running in protected mode) do things like directly write to VGA video memory etc.
It's possible that this DLL served as a compatibility layer to still allow this functionality to be executed on 32-bit versions of Windows.


## This Solution

I've patched WDIR62F.DLL, to ignore the result of GetProcAddress(), which will be zero as this "QT_Thunk" function does not exist.
Furthermore I've simply replaced PMPRO62F.DLL with a dummy DLL containing empty functions that just return (without erroring out at least).
I suspect the 16-bit functionality is only needed in full screen mode, where I imagine DISPDIB.DLL is directly used to draw the 320x200
pixel bitmap to VGA video memory, after shutting down GDI.

## Future Work
Write a good quality replacement to this functionality, that leverages modern APIs / techniques to make full screen functionality, etc. work

If your having trouble using this let me know, and if this helped you out please let me know and/or star this repo.

Thanks!
