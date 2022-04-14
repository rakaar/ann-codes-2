function pulsewv=episodic_estim_wvgen(AudStimType,EstimPARAMS)

%%% due to mismatch in TDT stim and NIDAQ stim by 0.6 ms estim is delayed by 1 ms for episodic pairing 

fs=EstimPARAMS.EPISODIC.Fso;
ipi=EstimPARAMS.ipi/1000;pd=EstimPARAMS.pulse_dur/1000;dels=fix(0.001*fs);
switch AudStimType
    case 'ABA'
        load ABAPARAMS
        stimPARAMS=EstimPARAMS.EPISODIC.ABA;
        ne=stimPARAMS.totalsets;
        tottime=ne*(2*ABAPARAMS.tone_Adur+ABAPARAMS.tone_Bdur+ABAPARAMS.gapdur);
        A1samp=fix(ABAPARAMS.tone_Adur*fs);Bsamp=fix(ABAPARAMS.tone_Bdur*fs);
        A2samp=A1samp;Ssamp=fix(ABAPARAMS.gapdur*fs);
        pulsewv=zeros(1,fix(tottime*fs));
        stimulate=zeros(4,ne);
        if stimPARAMS.A1_stim_check==1
            if stimPARAMS.A1_range_check==1
                stimulate(1,stimPARAMS.A1_from:stimPARAMS.A1_to)=1;
            elseif stimPARAMS.A1_epi_check==1
                stimulate(1,str2num(stimPARAMS.A1_episodes))=1;
            end
        end
        if stimPARAMS.A2_stim_check==1
            if stimPARAMS.A2_range_check==1
                stimulate(3,stimPARAMS.A2_from:stimPARAMS.A2_to)=1;
            elseif stimPARAMS.A2_epi_check==1
                stimulate(3,str2num(stimPARAMS.A2_episodes))=1;
            end
        end
        if stimPARAMS.B_stim_check==1
            if stimPARAMS.B_range_check==1
                stimulate(2,stimPARAMS.B_from:stimPARAMS.B_to)=1;
            elseif stimPARAMS.B_epi_check==1
                stimulate(2,str2num(stimPARAMS.B_episodes))=1;
            end
        end
        if stimPARAMS.S_stim_check==1
            if stimPARAMS.S_range_check==1
                stimulate(4,stimPARAMS.S_from:stimPARAMS.S_to)=1;
            elseif stimPARAMS.S_epi_check==1
                stimulate(4,str2num(stimPARAMS.S_episodes))=1;
            end
        end
        A1s=zeros(1,A1samp);A2s=A1s;Bs=zeros(1,Bsamp);Ss=zeros(1,Ssamp);
        %eachp=zeros(1,fix(ipi*fs));eachp(1:fix(pd*fs))=1;
        for kk=(1+dels):(fix(pd*fs)+dels)
            A1s(kk:fix(ipi*fs):length(A1s))=1;
            Bs(kk:fix(ipi*fs):length(Bs))=1;
            Ss(kk:fix(ipi*fs):length(Ss))=1;
        end
        A2s=A1s;
        tokwv(1).wv=A1s;tokwv(2).wv=Bs;tokwv(3).wv=A2s;tokwv(4).wv=Ss;
        pulsewv=[];
        for kk=1:ne
            for jj=1:4
                if stimulate(jj,kk)==1
                    pulsewv=[pulsewv tokwv(jj).wv];
                else
                    pulsewv=[pulsewv zeros(size(tokwv(jj).wv))];
                end
            end
        end
end