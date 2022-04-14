function trigPlay_2CH ( play, play_2, fs )
%
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

rcx_file_name = 'C:\Documents and Settings\kanoldlab\My Documents\MATLAB\PrairiePartner\TDT\trigPlay_2CH.rcx';

if isempty ( RX6_gPL ) % First invocation?
    disp ( 'First invocation' );
    
    % Create an invisible matlab figure object
    fh = figure ( 'Visible', 'off', 'Position', [5 5 26 26]);
    
    % Create an Active X control that can talk to a TDT RX6
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
    
    % Start the circuit running
    %invoke ( RX6_gPL, 'run' );
    RX6_gPL.Run;
    
    % Learn the circuit buffer's maximum capacity
    % xxx - hard coded in circuit.
    maxSampleSize_gPL = invoke ( RX6_gPL, 'GetTagVal', 'maxSamples' );
%end;
else
    % the enable line should have been set to zero before last halt, so
    % running will not output anything out DAC.
    invoke ( RX6_gPL, 'run' );

    % reset the number of samples so that if the circuit was interrupted
    % before, nothing old will play out now.
    RX6_gPL.SetTagVal('nSamps',1);
end

% Can we read the '999' test value from the RX6?
try
    isConnected = invoke ( RX6_gPL, 'GetTagVal', 'isConnected' );
catch
    % xxx - what exactly is being caught here?
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
if nSamps > 0
    invoke ( RX6_gPL, 'SetTagVal', 'nSamps', nSamps );
else
    % to avoid triggering Schmitt2 do not set samples to zero
    RX6_gPL.SetTagVal('nSamps',1);
end

% Send the matlab audio vectors to the RX6
invoke ( RX6_gPL, 'WriteTagV', 'play',   0, play );
invoke ( RX6_gPL, 'WriteTagV', 'play_2', 0, play_2 );

% Enable the circuit.
RX6_gPL.SetTagVal('Enable',1);

% RX6 connection still ok?
isConnected = invoke ( RX6_gPL, 'GetTagVal', 'isConnected' );
if isConnected ~= connectValue 
    errordlg ( 'Error running RX6 circuit -- communication lost' );
    return;
end;

% See if the RX6 DSP is keeping up or if it is overloaded
percentBusy = invoke ( RX6_gPL, 'GetTagVal', 'percentBusy' );
if percentBusy >= 99 
    errordlg ( 'Error running RX6 circuit -- DSP cannot keep up' );
    return;
end;

return;