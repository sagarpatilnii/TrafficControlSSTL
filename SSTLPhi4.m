function [Tp1, Tp3, Tp5, Tp7, rho] = SSTLPhi4(MSG_ICA)

global SignalCycle Tcy Tb1

%global PredictionHorizon

%RHO = zeros(1,PredictionHorizon);

%for i = SignalCycle:1:(SignalCycle+PredictionHorizon-1)    
%end

rho = 0;
Tp1 = 0; 
Tp3 = 0;
Tp5 = 0;
Tp7 = 0;

if MSG_ICA(1,SignalCycle) == "North" && MSG_ICA(2,SignalCycle) == "Disabled"
    Tp1 = 1;
    Tp3 = 0;
    Tb1 = Tcy;
    Tp5 = Tcy;
    Tp7 = 0;
    rho = 1;
end

if MSG_ICA(1,SignalCycle) == "East" && MSG_ICA(2,SignalCycle) == "Disabled"
    Tp1 = 1;
    Tp3 = 0;
    Tb1 = 0;
    Tp5 = 1;
    Tp7 = Tcy;
    rho = 1;
end

if MSG_ICA(1,SignalCycle) == "West" && MSG_ICA(2,SignalCycle) == "Disabled"
    Tp1 = 1;
    Tp3 = Tcy;
    Tb1 = 0;
    Tp5 = 1;
    Tp7 = 0;
    rho = 1;
end

if MSG_ICA(1,SignalCycle) == "South" && MSG_ICA(2,SignalCycle) == "Disabled"
    Tp1 = Tcy;
    Tp3 = 0;
    Tb1 = Tcy;
    Tp5 = 1;
    Tp7 = 0;
    rho = 1;
end











