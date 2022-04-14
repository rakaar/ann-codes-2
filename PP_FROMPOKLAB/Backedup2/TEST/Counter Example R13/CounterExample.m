%Event Counter Demo
%  This example shows how to use generic dll calling to
%  implement a counter on National Instruments hardware
%  using the DAQ-STC based counter.  This includes E-series
%  boards with counter functionality.  This does not
%  include the family of boards that are just counter/timers.
%
%  Software Required:
%   MATLAB, with generic dll calling patch
% http://www.mathworks.com/support/solutions/data/33513.shtml
%   LoadLibraryGUI, available on MATLAB Central
% http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=2800&objectType=file
%
%   NIDAQ: 
%     Device Drivers (I used version 6.9.2)
%     Visual C/C++ Support (compiler choice shouldn't matter)
%   
%
%  Hardware Required:
%   Any NI hardware with a counter supported by DAQ-STC
%   I used a DAQ Signal Accessory, with Quadrature Encoder
%   A connected to Counter 0 Source.  I spin the encoder
%   while this application runs to generate some counts.
%
%  This example is a MATLAB version of the example
%     STCEventCount.c
%  provided with the installation of NIDAQ development tools
%  for C.
%
%  Pin Connection Information: 
% *    Connect your digital pulse train to the SOURCE pin of your
% *     counter. Connect the ground reference to the DIG GND pin.

% Scott Hirsch
% (c) The MathWorks 2002
% This is provided as an example only.

%Load NI Library
%Here's the "from scratch" way.
% nilib = 'C:\winnt\system32\nidaq32';        %Library name.  This must be on your Windows path.
% nihdr = ['D:\Applications\National Instruments\NI-DAQ\Include\nidaq.h'];
%                           %Header file.  Installed with C/C++ Support
% loadlibrary(nilib,nihdr); %Load the library.  That's it!
% This gives you access to all of the functions listed in nihdr.  They can
% be called with calllib, ...
%   calllib(nilib,'SomeNIDAQFunction',arg1,arg2,arg3, ...)
% I find it much more convenient to use m-functions with identical
% prototypes to the original c functions in the nidaq library.
% Fortunately, Tom Gaudette made this a very easy process with his
% LoadLibraryGUI utility.  This utility automatically generates an
% equivalent m-file for every function in the library.  It also creates
% simplified load/unload functions
% 


%Need to put ni project directory on the path!
%This gives utility functions to ease loading/unloading, 
% plus m equivalents to every function in the library!
param = loadni;       %Auto generated by Tom's GUI
%Output is structure containing NI constants, from nidaqcns.h

iLoopCount = 10;        %Number of times to check the counter's value

%Hardware configuration
boardID = 1;                        %Hardware Device ID. Get this with daqhwinfo('nidaq') or with Max
counterNum = param.ND_COUNTER_0;    %The ID for your counter (mine is #0.  I get the real ID from nidaqcns.h)

%Define pointers to get data back from the counter
pulCount = libpointer('uint32Ref',0);   %The number of events counted by the counter
pulTCReached = libpointer('uint32Ref',param.ND_NO); %Indicates whether the counter has reached terminal count

%Note: The only time we need to worry about matching data formats 
% is with pointers.  Direct passing will be handled by MATLAB automagically.
% To get the value of a pointer:
%   pointername.Value


%See NIDAQ help for explanation of these functions.  
iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);

iStatus = GPCTR_Set_Application(boardID, counterNum, ...
    param.ND_SIMPLE_EVENT_CNT);

iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_SOURCE, ...
    param.ND_DEFAULT_PFI_LINE);

%     /* Load initial count. */
iStatus = GPCTR_Change_Parameter(boardID, counterNum, ...
    param.ND_INITIAL_COUNT, pulCount);

disp(' ');
disp('Apply your digital pulse train to the SOURCE of your counter.');
disp('Press any key when ready'); 

pause       %Wait for the user

iStatus = GPCTR_Control(boardID, counterNum, param.ND_PROGRAM);


%     /* Loop iLoopCount times. */

for count=1:iLoopCount        
    
    %Get the counter value
    iStatus = GPCTR_Watch(boardID, counterNum, param.ND_COUNT, ...
        pulCount);
    
    disp(['The current count is ' num2str(double(pulCount.Value))]);
    
    %See if we've hit the terminal condition
    iStatus = GPCTR_Watch(boardID, counterNum, param.ND_TC_REACHED, ...
        pulTCReached);
    
    %Oops, we hit the terminal condition
    if (pulTCReached.Value == param.ND_YES) 
        disp('Counter reached terminal count! - The count may be incorrect.');
    end;
    
    pause(1);
    
end;

%     /* CLEANUP - Don't check for errors on purpose. */
% 
%     /* Reset GPCTR. */

iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);

disp('Done with event counting!');
