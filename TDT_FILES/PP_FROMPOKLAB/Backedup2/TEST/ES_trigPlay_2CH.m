function ES_trigPlay_2CH ( play, play_2, fs )
%
% Ed Smith, March 2009
%
% Set up the TDT RX6 to output two time series (audio stimuli)
% each time a trigger input is received.
%
% Note that the TDT RX6 introduces a 43 sample delay between
% the trigger signal and the onset of audio output due to the
% TDT D to A converter delta-sigma processing.
%
global RX6_gPL maxSampleSize_gPL

% TDT is fairly restrictive about sample rate
if fs ~= 156250
    errordlg ( 'The TDT circuit requires fs to be 156250 Hertz' );
    return;
end;

connectValue = 999;

if isempty ( RX6_gPL ) % First invocation?
    disp ( 'First invocation' );
    
    % Create an invisible matlab figure object
    fh = figure ( 'Visible', 'off', 'Position', [9 9 30 30]);
    
    % Create an Active X control that can talk to a TDT RX6
    RX6_gPL = actxcontrol ( 'RPco.x', [9 9 30 30], fh );
    
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
    
    % Get the circuit file from disk
    rcx_file_name = 'G:\MATLAB701\work\2p\TDT_files\ES_trigPlay_2CH.rcx';
    
    % Put the circuit into the RX6
    invoke ( RX6_gPL, 'LoadCOF', rcx_file_name );
    
    % Start the circuit running
    invoke ( RX6_gPL, 'run' );
    
    % Learn the circuit buffer's maximum capacity
    maxSampleSize_gPL = invoke ( RX6_gPL, 'GetTagVal', 'maxSamples' );
end;

% Can we read the '999' test value from the RX6?
try
    isConnected = invoke ( RX6_gPL, 'GetTagVal', 'isConnected' );
catch
    disp ( 'Attempting to re-establish connection to RX6' );
    RX6_gPL = [];
    ES_trigPlay ( [0 0], fs );
    isConnected = invoke ( RX6_gPL, 'GetTagVal', 'isConnected' );
end;

% Did we read out the test value ok?
if isConnected ~= connectValue 
    errordlg('Unable to run RX6 circuit');
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

% Tell RX6 the number of samples in this vector
invoke ( RX6_gPL, 'SetTagVal', 'nSamps', nSamps ); 

% Send the matlab audio vectors to the RX6
invoke ( RX6_gPL, 'WriteTagV', 'play',   1, play );
invoke ( RX6_gPL, 'WriteTagV', 'play_2', 1, play_2 );

% RX6 connection still ok?
isConnected = invoke ( RX6_gPL, 'GetTagVal', 'isConnected' );
if isConnected ~= connectValue 
    errordlg ( 'Error running RX6 circuit -- communication lost' );
    return;
end;

% See if the RX6 DSP is keeping up or if it is overloaded
percentBusy = invoke ( RX6_gPL, 'GetTagVal', 'percentBusy' )
if percentBusy >= 99 
    errordlg ( 'Error running RX6 circuit -- DSP cannot keep up' );
    return;
end;

return;