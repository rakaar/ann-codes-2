Possible Problems I have found.

1) If your header file needs to use windows.h files and you don't include them.

2) If you do not get any of the functions.  Some header files define the functions to use __declspec(dllexport) for each function.  This is wrong but some compilers don't complain.  This normally happens because they gave you the header file they used to create the dll not the header file the is needed for inporting the DLL.

So remove this #define __declspec(dllexport) form the beginning of each function declaration.  Normally this is in a #define in the top to turn it off.



