function y=aud_gate_on(y,dur,Fs)
%ramp up for dur ms
tramp=floor(Fs/1000*dur);

ramp_atten=linspace(0,1,tramp);
y(1:tramp)=y(1:tramp).*ramp_atten;
