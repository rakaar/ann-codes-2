function calset_fnames=calibrations_at_different_SLs

  ATTs=10
% %   [60:-10:0];%%% CHANGED to only 0 FOR ADARSH CALIBRATION 01072016
for kk=1:length(ATTs)
    calset_fnames{kk}=prairie_aud_CALIB_RX6([6000 48000 1/8],ATTs(kk),[0.6 0.5 1.2]);
end
% load CalibFreqs
% for kk=1:length(ATTs)
%     load (calset_fnames{kk})
%     startsamp=fix(CALPARAMS.stim_start*CALPARAMS.Fsi);
%     dursamp=fix(CALPARAMS.stim_dur*CALPARAMS.Fsi);
%     for jj=1:(length(fieldnames(trig_inputs))-1)
%         eval(sprintf('signal=trig_inputs.iter%i((startsamp+51):(startsamp+dursamp-50));',jj))
%         F=20*log10(abs(fft(signal)));
%         peakval(jj,kk)=max(F(freq(jj)-10:freq(jj)+10));
%     end
% end