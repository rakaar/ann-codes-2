function y=aud_gate_off(y,dur,Fs)
%ramp down for dur ms
tramp=floor(Fs/1000*dur);

ramp_atten=linspace(1,0,tramp);
y(length(y)-tramp+1:length(y))=y(length(y)-tramp+1:length(y)).*ramp_atten;
