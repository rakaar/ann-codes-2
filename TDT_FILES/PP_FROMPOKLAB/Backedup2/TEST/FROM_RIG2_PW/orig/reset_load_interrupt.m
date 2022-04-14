HW.ao = analogoutput('nidaq',2);
HW.op_ch=addchannel(HW.ao,[0]);
HW.Fso=10000;
output=zeros(200,1);
putdata(HW.ao,output)
start(HW.ao)
clear