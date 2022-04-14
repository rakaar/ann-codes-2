function trigPlay_2CH_PPIIT ( play, play_2, fs )
%
%
% Set up the TDT RZ6 to output two time series (audio stimuli)
% each time a trigger input is received.
%
% Note that the TDT RZ6 introduces a 43 sample delay between
% the trigger signal and the onset of audio output due to the
% TDT D to A converter delta-sigma processing.
%
global RZ6_gPL maxSampleSize_gPL


% TDT is fairly restrictive about sample rate
if fs ~= 195312.5
    errordlg ( 'The TDT circuit requires fs to be 195312.5 Hertz' );
    return;
end;

connectValue = 999;

% rcx_file_name = 'G:\MATLAB701\work\2p\TDT_files\trigPlay_2CH.rcx';
rcx_file_name = 'C:\EXPERIMENTS\PRAIRIEPARTNER\CODES\TDT_FILES\trigPlay_2CH_RZ6_IIT.rcx';

if isempty ( RZ6_gPL ) % First invocation?
    1
    disp ( sprintf('First invocation, rcx is %s',rcx_file_name) );
    
    % Create an invisible matlab figure object
    fh = figure ( 'Visible', 'off', 'Position', [5 5 26 26]);
    
    % Create an Active X control that can talk to a TDT RZ6
    RZ6_gPL = actxcontrol ( 'RPco.x', [5 5 26 26], fh );
    
    % Tell the Active X control to establish comm. link with the RZ6
    invCode = invoke ( RZ6_gPL, 'ConnectRZ6', 'GB', 1 ); % 'USB'
    
    % See if the Active X control thinks it is connected to the RZ6
    if invCode
        er = 'RZ6 connected to PC';
        disp ( er );
    else
        er = 'Unable to connect RZ6 to PC';
        errordlg ( er );
        return;
    end;
    
    % Clears the Buffers and COF files on the RZ6
    invoke ( RZ6_gPL, 'ClearCOF' ); 
    
    % Put the circuit into the RZ6
    invoke ( RZ6_gPL, 'LoadCOF', rcx_file_name );
    
    % Start the circuit running
    %invoke ( RZ6_gPL, 'run' );
    RZ6_gPL.Run;
    
    % Learn the circuit buffer's maximum capacity
    invoke ( RZ6_gPL, 'GetTagVal', 'maxSamples' );
    %maxSampleSize_gPL
%end;
else
    % the enable line should have been set to zero before last halt, so
    % running will not output anything out DAC.
    invoke ( RZ6_gPL, 'run' );

    % reset the number of samples so that if the circuit was interrupted
    % before, nothing old will play out now.
    RZ6_gPL.SetTagVal('nSamps',1);
end

% Can we read the '999' test value from the RZ6?
try
    isConnected = invoke ( RZ6_gPL, 'GetTagVal', 'isConnected' )
catch
    disp ( 'Attempting to re-establish connection to RZ6' );
    RZ6_gPL = [];
    trigPlay_2CH_RZ6_IIT ( [0 0], fs );
    isConnected = invoke ( RZ6_gPL, 'GetTagVal', 'isConnected' )
end;

% Did we read out the test value ok?
if isConnected ~= connectValue 
    
    errordlg('Unable to run RZ6 circuit');
    return;
end;

% Check for input size or shape errors
playRows = size ( play, 1 );
if playRows ~= 1
    errordlg ( 'First input must be a row vector.' );
    return;
end;

nSamps = size ( play, 2 );
if nSamps > maxSampleSize_gPL
    er = ['Maximum signal length is ' num2str(maxSampleSize_gPL) ' samples'];
    errordlg ( er );
    return;
end;

% Tell RZ6 the number of samples in this vector
invoke ( RZ6_gPL, 'SetTagVal', 'nSamps', nSamps ); 

% Send the matlab audio vectors to the RZ6
invoke ( RZ6_gPL, 'WriteTagV', 'play',   0, play );
invoke ( RZ6_gPL, 'WriteTagV', 'play_2', 0, play_2 );
% Enable the circuit.
RZ6_gPL.SetTagVal('Enable',1);
% RZ6 connection still ok?
isConnected = invoke ( RZ6_gPL, 'GetTagVal', 'isConnected' );
if isConnected ~= connectValue 
    errordlg ( 'Error running RZ6 circuit -- communication lost' );
    return;
end;

% See if the RZ6 DSP is keeping up or if it is overloaded
percentBusy = invoke ( RZ6_gPL, 'GetTagVal', 'percentBusy' );
if percentBusy >= 99 
    errordlg ( 'Error running RZ6 circuit -- DSP cannot keep up' );
    return;
end;

return;