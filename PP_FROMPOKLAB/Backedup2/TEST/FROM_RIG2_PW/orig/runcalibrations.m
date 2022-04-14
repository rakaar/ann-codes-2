function runcalibrations

%Amp set to 30 dB gain MA3
for attens=0:10:100
    fprintf('For %i dB attenuation')
    calib_data=Calibration_withPA5([attens,1]);
    eval(sprintf('save calibresult_%idB_attenuation calib_data',attens))
end

% N=29;Fs=160000;
% fl=6000;fh=6000*2^(3.5);T=.8;pause_T=0.2;
% ts=[0:1/Fs:(T-1/Fs)];P_samp=pause_T*Fs;
% sig_samps=(2*P_samp+1):(length(ts));
% base_samp=(length(ts)+2*P_samp+1):(2*length(ts));
% %yy=[zeros(1,P_samp) yy zeros(size(yy)) zeros(1,P_samp)];
% freqs=logspace(log10(fl),log10(fh),N);
% seg=0.0256;seg_samp=fix(seg*Fs);
% 
% 
% for attens=0:10:80
%     eval(sprintf('load calibresult_%idB_attenuation',attens))
%     for ff=1:N
%         eval(sprintf('asignal=calib_data.freq%i(sig_samps);',ff))
%         eval(sprintf('base=calib_data.freq%i(base_samp);',ff))
%         [pa,f]=psd(asignal,seg_samp,fix(0.25*seg_samp));
%         [pb,f]=psd(base,seg_samp,fix(0.25*seg_samp));
%         AMP_a=20*log10(pa);
%         AMP_b=20*log10(pb);
%         res_sig=AMP_a-AMP_b;
%         trans_f=f
%         
%         