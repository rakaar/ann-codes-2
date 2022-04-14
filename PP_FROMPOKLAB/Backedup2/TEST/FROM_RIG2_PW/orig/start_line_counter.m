function start_line_counter(N,ao)

param = loadNI;

    
    
    iLoopCount = 10000000;        %Number of times to check the counter's value
    %Hardware configuration
    counterNum2 = param.ND_COUNTER_1;    %The ID for the counter frame
    iStatus = GPCTR_Control(1, counterNum2, param.ND_RESET);
    iStatus = GPCTR_Set_Application(1, counterNum2, ...
        param.ND_SIMPLE_EVENT_CNT);
    
    
    fmt = 'uint32Ptr';      % Pointer format string
    pulCount2 = libpointer(fmt,2^24-1-N);  %The number of events counted by the counter (initialized)
    INI_C=2^24-1-N;
     %     /* Load initial count. */
    iStatus = GPCTR_Change_Parameter(1, counterNum2, ...
        param.ND_INITIAL_COUNT, pulCount2.value);
    iStatus = GPCTR_Watch(1, counterNum2, param.ND_COUNT, ...
            pulCount2);
        pulCount2.value
    iStatus = GPCTR_Change_Parameter(1, counterNum2, param.ND_OUTPUT_MODE, ...
        param.ND_PULSE);
   
    
    
    iStatus = GPCTR_Control(1, counterNum2, param.ND_PROGRAM);
    %    /* Loop iLoopCount times. */
    started=0;%armed_started=0;
    waittilstop(ao,10)
    
    return
    %start([ai ao])
    
%     for count=1:iLoopCount
%         %Get the counter value
%         iStatus = GPCTR_Watch(1, counterNum2, param.ND_COUNT, ...
%             pulCount2);
%         pulCount2.value
%         if pulCount2.value>10&pulCount2.value<30
%             waittilstop(ao,10)
%             pause(.01)
%             %stopped=1;
%             iStatus = GPCTR_Control(1, counterNum2, param.ND_RESET);
%             stop(ao)
%             %set(ao,'Triggertype','Immediate')
%             break
%         end
%         
%         pause(.00001);
%     end
% return