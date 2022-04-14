
rcx_file_name = 'G:\matlab701\work\2p\TEST\puffer_const_out\pulse_train.rcx';

% Create an invisible matlab figure object
fh = figure ( 'Visible', 'off', 'Position', [5 5 26 26]);

% Create an Active X control that can talk to a TDT RX6
global RX6_gPL;
RX6_gPL = actxcontrol ( 'RPco.x', [5 5 26 26], fh );

% Tell the Active X control to establish comm. link with the RX6
invCode = invoke ( RX6_gPL, 'ConnectRX6', 'USB', 1 ); % 'USB'

% See if the Active X control thinks it is connected to the RX6
if invCode
    er = 'RX6 connected to PC';
    disp ( er );
else
    er = 'Unable to connect RX6 to PC';
    errordlg ( er );
    return;
end;

% Clears the Buffers and COF files on the RX6
invoke ( RX6_gPL, 'ClearCOF' );

% Put the circuit into the RX6
invoke ( RX6_gPL, 'LoadCOF', rcx_file_name );

% connect PA5 and init
global PA_L PA_R;
PA_L = actxcontrol('PA5.x',[5 5 26 26]);
PA_R = actxcontrol('PA5.x',[5 5 26 26]);
PA_L.ConnectPA5('USB',1);
PA_R.ConnectPA5('USB',2);
PA_L.SetAtten(80);
PA_R.SetAtten(80);pause(1e-3);

% Start the circuit running
RX6_gPL.Run;

%RX6_gPL.Halt;

% Set the frequency of the pulse train
RX6_gPL.SetTagVal('nHi',500);
RX6_gPL.SetTagVal('nLo',500);

