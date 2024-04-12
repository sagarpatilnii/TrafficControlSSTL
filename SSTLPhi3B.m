function rho = SSTLPhi3B(MSG_EVA, N_upN, N_upS, Tp7)

global PredictionHorizon SignalCycle

Flag = 0;

for i = SignalCycle:1:SignalCycle+PredictionHorizon-1
    
    if MSG_EVA(1,i) == "InUse" && MSG_EVA(2,i) == "Emergency"
        Flag = i;    
    end
    
end

if Flag ~= 0
    
    InternalRHO1 = zeros(1,Flag-SignalCycle+1);
    
    for j = 1:Flag-SignalCycle+1
        
        if Tp7(j) >= 5 && Tp7(j) <=7
            InternalRHO1(j) = 1;
        end
                
    end
    
    if min(InternalRHO1) == 1
        rho1 = 1;
    else
        rho1 = 0;
    end
    
else
    
    rho1 = 1;
    
end

Flag = 0;

for i = (SignalCycle-PredictionHorizon):1:(SignalCycle-1)
    
    if N_upN(1,i) > 65 && N_upS(1,i) > 35
        Flag = i+PredictionHorizon;    
    end
    
end

if Flag ~= 0
    
    InternalRHO2 = zeros(1,Flag-SignalCycle-1);
    
    for j = 1:(Flag-SignalCycle+1)
        
        if Tp7(j) >= 5 && Tp7(j) <= 7
            InternalRHO2(j) = 1;
        end
                
    end
    
    if min(InternalRHO2) == 1
        rho2 = 1;
    else
        rho2 = 0;
    end
    
else
    
    rho2 = 1;
    
end

rho = min(rho1,rho2);

% RHO = zeros(1,PredictionHorizon);
% 
% for i = 1:PredictionHorizon
%     
%     if SignalCycle < NoSignalCycles - PredictionHorizon
%         
%         if MSG_EVA(1,SignalCycle-1+i+PredictionHorizon-1) == "InUse" && MSG_EVA(2,SignalCycle-1+i+PredictionHorizon-1) == "Emergency"
%             
%             InternalRHO = zeros(1,PredictionHorizon);
%             
%             for j = 1:PredictionHorizon
%                 
%                 if Tp7(j) >= 5 && Tp7(j) <= 7
%                     InternalRHO(j) = 1;
%                 end
%                 
%             end
%             
%             if min(InternalRHO) == 1
%                 RHO(i) = 1;
%             end
%             
%         end
%         
%     elseif i <= length(N_upN)
%         
%         if N_upN(i) > 65 && N_upS(i) > 35
%             
%             if Tp7(i) >= 5 && Tp7(i) <= 7
%                 RHO(i) = 1;
%             end
%             
%         end
%         
%     else
%         
%         RHO(i) = 1;
%         
%     end
%     
% end
% 
% rho = min(RHO);