function [Noise_wf]=BandPassNoise(N,Fs,fl,fh)

    if rem(N,2)==1 %%% N odd
        Noise_sp_p=zeros(1,fix((N+1)/2));
        Noise_sp_p(ceil((N-1)/Fs*fl):ceil((N-1)/Fs*fh))=1;
        Noise_sp_p(1)=0;
        Noise_sp_n=fliplr(Noise_sp_p(2:end));
        Noise_sp=[Noise_sp_p Noise_sp_n];
        Noise_ang_p=2*pi*rand(size(Noise_sp_p))-pi;
        Noise_ft_p=Noise_sp_p.*exp(j*Noise_ang_p);
        Noise_ft_n=fliplr(conj(Noise_ft_p(2:end)));
        Noise_ft=[Noise_ft_p Noise_ft_n];
    else  %%%%%% N even
        Noise_sp_p=zeros(1,(fix(N/2)+1));
        Noise_sp_p(ceil((N+2)/Fs*fl):ceil((N+2)/Fs*fh))=1;
        Noise_sp_p(1)=0;
        Noise_sp_n=fliplr(Noise_sp_p(2:end-1));
        Noise_sp=[Noise_sp_p Noise_sp_n];
        Noise_ang_p=2*pi*rand(size(Noise_sp_p))-pi;
        Noise_ft_p=Noise_sp_p.*exp(j*Noise_ang_p);
        Noise_ft_n=fliplr(conj(Noise_ft_p(2:end-1)));
        Noise_ft=[Noise_ft_p Noise_ft_n];
    end
    Noise_wf=real(ifft(Noise_ft));