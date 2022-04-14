function prairie_estim_start_line_counter(N,HW)

TC=2^24;
param = loadNI;
iLoopCount = 10000000;        %Number of times to check the counter's value
%Hardware configuration
counterNum2 = param.ND_COUNTER_1;    %The ID for the counter frame
iStatus = GPCTR_Control(HW.boardID1, counterNum2, param.ND_RESET);
iStatus = GPCTR_Set_Application(HW.boardID1, counterNum2, ...
     param.ND_SIMPLE_EVENT_CNT);
    
    
fmt = 'uint32Ptr';      % Pointer format string
pulCount2 = libpointer(fmt,TC-N);  %The number of events counted by the counter (initialized)
%     /* Load initial count. */
iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum2, ...
    param.ND_INITIAL_COUNT, pulCount2.value);
iStatus = GPCTR_Watch(HW.boardID1, counterNum2, param.ND_COUNT, ...
    pulCount2);
        
iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum2, param.ND_OUTPUT_MODE, ...
    param.ND_PULSE);
   
iStatus = GPCTR_Control(HW.boardID1, counterNum2, param.ND_PROGRAM);
%    /* Loop iLoopCount times. */
started=0;%armed_started=0;
waittilstop(HW.ao,10)
return