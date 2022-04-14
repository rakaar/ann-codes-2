function tpls=generate_mtrigger_begin(T,fs,a,time_to_trig)

tpls=a*ones(1,fix(T*fs));
tpls(1:fix(time_to_trig*fs))=0;
tpls(end)=0;