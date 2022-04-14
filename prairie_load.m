function prairie_SIU(duration,nr_pulses,pulse_dt,repetition,rep_dt)
%in seconds
stimtime=(duration+pulse_dt)*nr_pulses;
daq=daqhwinfo('nidaq');
ao = analogoutput('nidaq',1);
addchannel(ao,0);
ao.SampleRate=10000;
aotime=stimtime+0.1;%in ms
aosamples=aotime*ao.SampleRate;
stimdat=zeros(1,aosamples);

for i=1:nr_pulses
    stimdat(1+(i-1)*pulse_dt*ao.SampleRate:(duration+(i-1)*pulse_dt)*ao.SampleRate)=5;
end
plot((1:length(stimdat))/ao.SampleRate,stimdat)

for i=1:repetition
    putdata(ao,stimdat');
    start(ao);
    disp(sprintf('rep %i/%i %i pulses every %i s, then pausing for %i s',i,repetition, nr_pulses,pulse_dt,rep_dt));
    pause(rep_dt);
end
return
