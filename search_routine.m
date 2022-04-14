function search_routine
dur=0.05; totdur=0.25;pre_delay=0.03;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fss=200000;
ampl=10; % set to 2.8 so that after 10 dB gain on mic amp output is ~ +/-10V p-p %chaged to 10 after attenuator got installed
search_start=1;save search_start search_start;
search_handles = Search_GUIx;
h = figure;
PA_L = actxcontrol('PA5.x',[5 5 26 26]);
PA_R = actxcontrol('PA5.x',[5 5 26 26]);
set(h,'visible','off');
PA_L.ConnectPA5('USB',1);
PA_R.ConnectPA5('USB',2);
played_noise=0;
sfreqLo=Svaltofreq(get(search_handles.Tone_Freq,'Value'))*1000;
%% setting the attenuation
sattLo=Svaltoatt(get(search_handles.Attenuation,'Value'));
PA_L.SetAtten(sattLo); %%% change for binaural
PA_R.SetAtten(sattLo);pause(1e-3); %%% change for binaural
t=0:1/Fss:(dur-1/Fss);total_t=0:1/Fss:(totdur-1/Fss);
wls=2*pi*sfreqLo;
yls=sin(wls.*t);
yls=aud_gate_on(yls,5,Fss);
yls=aud_gate_off(yls,5,Fss);
yls=[yls zeros(1,length(total_t)-length(t))];
%yrs=yls;%%%%%%%%%%% change for binaural
load search_noise_short %50 ms 200 ms isi
search_start=0;save search_start search_start;
Quit_search=0;snbits=24;dev_ids=6;

%%%%%%%%%%%%%% Input
ai=analoginput('nidaq','Dev3');ao=analogoutput('nidaq','Dev3');
set(ai,'InputType','SingleEnded');
ch1=addchannel(ai,[0]);cho=addchannel(ao,[0 1]);
%set(ai,'DriveAISenseToGround','On'); % Do not use DAQ.AI sense to ground
set(ai,'TriggerType','HwDigital');
set(ao,'TriggerType','HwDigital');
Fsai=20000;
set(ai,'SampleRate',Fsai);set(ao,'SampleRate',Fss);
set(ai,'SamplesPerTrigger',fix(length(yls)/Fss*Fsai)+100);
set(ai,'Timeout',1000*((fix(length(yls)/Fss*Fsai)+100)/Fsai))
dio=digitalio('nidaq','Dev3');
addline(dio,0,'Out');%digital line to trigger ai and ao - this line is connected to PFI0 and PFI6 of the USB-6259 device
putvalue(dio.Line(1),[1]);
mxold=.3;
%%%% filtering of input
hpco=100;lpco=6000;
[bh,ah] = butter(2,2*hpco/Fsai,'high');
[bl,al] = butter(2,2*lpco/Fsai,'low');
pd_length=fix(pre_delay*Fss);
%%%%%%%%%%%%%%%%%%
searchnum=0;maxnum=200;
spkwf_samps=fix(2.5/1000*Fsai);%2.5 ms from threshold crossing
start_figure(search_handles,dur,totdur,maxnum)
                    while ~Quit_search
                        [search_handles,Quit_search] = Search_GUIx;
                        axrp=search_handles.Raster_Plot;
                        axsw=search_handles.Spike_waveform;
                        %save search_handles search_handles
                        Quit_search=get(search_handles.Exit_Search,'Value');
                        %Quit_search
                        if Quit_search
                            pause(1)
                            fprintf('\nQuitting Search...\n')
                            close(search_handles.figure1)
                            break
                        end
                        %for mn=1:5000 1+1; end
                        spk_th=Svaltovolt(get(search_handles.Spike_Threshold,'Value'));
                        tmo_samp=fix(Svaltotime(get(search_handles.Timeout,'Value'))*Fsai/1000);
                        
                        %get(search_handles.TONE_NOISE,'Value')
                        if get(search_handles.TONE_NOISE,'Value')==0
                            %fprintf('\nPlay Search Tone')
                            sfreqLc=Svaltofreq(get(search_handles.Tone_Freq,'Value'))*1000;
                            sattLc=Svaltoatt(get(search_handles.Attenuation,'Value'));
                            PA_L.SetAtten(sattLc); %%% change for binaural
                            PA_R.SetAtten(sattLc);pause(1e-3); %%% change for binaural
                            
                            if sfreqLc~=sfreqLo||played_noise==1
                                Fss=200000;
                                t=0:1/Fss:(dur-1/Fss);total_t=0:1/Fss:(totdur-1/Fss);
                                wls=2*pi*sfreqLc;
                                yls=sin(wls.*t);
                                yls=aud_gate_on(yls,5,Fss);
                                yls=aud_gate_off(yls,5,Fss);
                                yls=[yls zeros(1,length(total_t)-length(t))];
                                sfreqLo=sfreqLc;
                            end
                            if sattLo~=sattLc
                                yls=[yls zeros(1,length(total_t)-length(t))];
                                sattLo=sattLc;
                            end
                            played_noise=0;
                            yrs=yls;
                            %p=audioplayer([yls' yrs'],Fss,snbits,dev_ids);
                            putvalue(dio.Line(1),[1]);
                            pause(1e-3)
                            putdata(ao,[ampl*[yls(end-pd_length+1:end) yls(1:end-pd_length)]' ampl*[yrs(end-pd_length+1:end) yrs(1:end-pd_length)]']);
                            searchnum=rem(searchnum+1,maxnum);
                            %length(yl)    
                            %samps=fix(length(yl)/Fs*Fsai)+extra_samp
                            start([ai ao]);
                            pause(.01);
                            putvalue(dio.Line(1),[0]);%actually triggering
                            wait(ai,1000*(fix(length(yls)/Fss*Fsai)+1000)/Fsai)
                            [data.x,data.tr,data.ts]=getdata(ai);
                            stop(ao)
                            %soundsc(data.x,Fsai)
                            fx=data.x;
                            %fx=filtfilt(bh, ah, data.x);
                            %fx=filtfilt(bl, al, fx);
                            mv=mean(fx);fx=fx-ones(size(data.x,1),1)*mv;
                            %soundsc(fx)
                            if searchnum==0
                                start_figure(search_handles,dur,totdur,maxnum)
                                mxold=.3;
                            end
                            last_spk=-(tmo_samp+10);
                            if spk_th>0
                                %pos=1;
                                inx=find(fx>spk_th);
                            else
                                %pos=0;                          
                                inx=find(fx<spk_th);
                            end
                            fx=[fx; zeros(spkwf_samps,1)];
                            for cross=1:length(inx)
                                if (inx(cross)-last_spk)>tmo_samp
                                    %figure(200)
                                    plot(axrp,inx(cross)/Fsai,searchnum,'b.')
                                    pause(1e-6)
                                    %fprintf('.')
                                    %hold(search_handles.Raster_Plot,'on')
                                    plot(axsw,[0:spkwf_samps]/Fsai,fx(inx(cross):(inx(cross)+spkwf_samps)),'r')
                                    mxc=max(abs((fx(inx(cross):(inx(cross)+spkwf_samps)))*11/10));
                                    if mxold<mxc
                                        mxold=mxc;
                                    end
                                    set(gca,'Ylim',[-mxold mxold])
                                    pause(1e-6)
                                    %hold(search_handles.Spike_waveform,'on')
                                    last_spk=inx(cross);
                                end
                            end
                            %pause(totdur)
                        elseif get(search_handles.TONE_NOISE,'Value')==1
                            played_noise=1;
                            %fprintf('\nPlay Search Noise')
                            %fprintf('\nPlay Search Tone')
                            %sfreqLc=Svaltofreq(get(search_handles.Tone_Freq,'Value'))*1000;
                            sattLc=Svaltoatt(get(search_handles.Attenuation,'Value'));
                            sattLo=sattLc;
                            % search 200ms long tone 1 sec inter stim
                            PA_L.SetAtten(sattLo); %%% change for binaural
                            PA_R.SetAtten(sattLo);pause(.01); %%% change for binaural
                            t=0:1/Fss:(dur-1/Fss);total_t=0:1/Fss:(totdur-1/Fss);
                            yls=search_noise;yls=yls(1:length(total_t));
                            
                            yrs=yls;%change for binaural
                            putvalue(dio.Line(1),[1]);
                            pause(1e-3)
                            putdata(ao,[ampl*[yls(end-pd_length+1:end) yls(1:end-pd_length)]' ampl*[yrs(end-pd_length+1:end) yrs(1:end-pd_length)]']);
                            searchnum=rem(searchnum+1,maxnum);
                            %length(yl)    
                            %samps=fix(length(yl)/Fs*Fsai)+extra_samp
                            start([ai ao]);
                            pause(.01);
                            putvalue(dio.Line(1),[0]);%actually triggering
                            wait(ai,1000*(fix(length(yls)/Fss*Fsai)+1000)/Fsai)
                            [data.x,data.tr,data.ts]=getdata(ai);
                            stop(ao)
                            fx=data.x;
                            %fx=filtfilt(bh, ah, data.x);% high pass
                            %fx=filtfilt(bl, al, fx);% low pass
                            mv=mean(fx);fx=fx-ones(size(data.x,1),1)*mv;
                            %sound(fx,Fsai)
                            if searchnum==0
                                start_figure(search_handles,dur,totdur,maxnum)
                                mxold=.3;
                            end
                            last_spk=-(tmo_samp+10);
                            if spk_th>0
                                pos=1;
                                inx=find(fx>spk_th);
                            else
                                pos=0;                          
                                inx=find(fx<spk_th);
                            end
                            fx=[fx; zeros(spkwf_samps,1)];
                            for cross=1:length(inx)
                                if (inx(cross)-last_spk)>tmo_samp
                                    plot(axrp,inx(cross)/Fsai,searchnum,'m.')
                                    pause(1e-6)
                                    %hold(search_handles.Raster_Plot,'on')
                                    plot(axsw,[0:spkwf_samps]/Fsai,fx(inx(cross):(inx(cross)+spkwf_samps)),'r')
                                    mxc=max(abs((fx(inx(cross):(inx(cross)+spkwf_samps)))*11/10));
                                    if mxold<mxc
                                        mxold=mxc;
                                    end
                                    set(gca,'Ylim',[-mxold mxold])
                                    %set(search_handles.Spike_waveform,'YLim',[-mxold mxold])
                                    pause(1e-6)
                                    %hold(search_handles.Spike_waveform,'on')
                                    last_spk=inx(cross);
                                end
                            end
                        end
                    end

PA_L.SetAtten(80); %%% change for binaural
PA_R.SetAtten(80);pause(.01); %%% change for binaural
close(h)
return
                    
function fr=Svaltofreq(val)

fr=2^(1+val*log2(40));
return

function att=Svaltoatt(vala)

att=100*(1-vala);
return

function spk_th=Svaltovolt(val)

spk_th=20*val-10;
return

function tmo=Svaltotime(val)

tmo=4.9*val+.1;
return

function start_figure(search_handles,dur,totdur,maxnum)

cla(search_handles.Raster_Plot)

set(search_handles.Raster_Plot,'XLim',[0 totdur])
hold(search_handles.Raster_Plot,'on')
%get(search_handles.Raster_Plot,'XLim')
set(search_handles.Raster_Plot,'YLim',[0 maxnum])
set(search_handles.Raster_Plot,'XTick',[0:.05:totdur])
%get(search_handles.Raster_Plot,'XTick')
set(search_handles.Raster_Plot,'XTickLabel',[0:.05:totdur]*1000)
%get(search_handles.Raster_Plot,'XTickLabel')
xlabel(search_handles.Raster_Plot,'Time in ms')
set(search_handles.Raster_Plot,'YTick',[0:25:maxnum])
set(search_handles.Raster_Plot,'YTickLabel',[0:25:maxnum])
ylabel(search_handles.Raster_Plot,'Line numbers')
plot(search_handles.Raster_Plot,[0.030 dur+0.03],[0 0],'r')

plot(search_handles.Raster_Plot,[0.030 0.03],[0 maxnum],'m')

plot(search_handles.Raster_Plot,[dur+0.030 dur+0.03],[0 maxnum],'m')


cla(search_handles.Spike_waveform)
set(search_handles.Spike_waveform,'XLim',[0 0.0025])
hold(search_handles.Spike_waveform,'on')
%get(search_handles.Spike_waveform,'XLim')
set(search_handles.Spike_waveform,'YLim',[-1 1])
set(search_handles.Spike_waveform,'XTick',[0:.0005:0.0025])
%get(search_handles.Spike_waveform,'XTick')
set(search_handles.Spike_waveform,'XTickLabel',[0:.0005:0.0025]*1000)
%get(search_handles.Spike_waveform,'XTickLabel')
xlabel(search_handles.Spike_waveform,'Time (ms)')
set(search_handles.Spike_waveform,'YTick',[-1:.25:1])
set(search_handles.Spike_waveform,'YTickLabel',[-1:.25:1])
ylabel(search_handles.Spike_waveform,'Voltage (V)')
plot(search_handles.Spike_waveform,[0 0.0025],[0 0],'k')

return