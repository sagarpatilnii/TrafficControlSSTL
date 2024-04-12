global Tcy Tau SignalCycle PredictionHorizon
global n_downN n_downE n_downW n_downS
global fNS_upN fNS_upE fNS_upW fNS_upS
global fEW_upN fEW_upE fEW_upW fEW_upS
global n_ranN n_ranE n_ranW n_ranS
global N_ranNlb N_ranNub N_ranElb N_ranEub N_ranWlb N_ranWub N_ranSlb N_ranSub
global n_upN n_upS

n_downN = zeros(PredictionHorizon,length(Tau)-1);
n_downE = zeros(PredictionHorizon,length(Tau)-1);
n_downW = zeros(PredictionHorizon,length(Tau)-1);
n_downS = zeros(PredictionHorizon,length(Tau)-1);
fNS_upN = zeros(PredictionHorizon,length(Tau)-1);
fNS_upE = zeros(PredictionHorizon,length(Tau)-1);
fNS_upW = zeros(PredictionHorizon,length(Tau)-1);
fNS_upS = zeros(PredictionHorizon,length(Tau)-1);
fEW_upN = zeros(PredictionHorizon,length(Tau)-1);
fEW_upE = zeros(PredictionHorizon,length(Tau)-1);
fEW_upW = zeros(PredictionHorizon,length(Tau)-1);
fEW_upS = zeros(PredictionHorizon,length(Tau)-1);
n_upN = zeros(PredictionHorizon,length(Tau)-1);
n_upS = zeros(PredictionHorizon,length(Tau)-1);

for PredictionHorizonIndex = 1:PredictionHorizon
if SignalCycle >= 10 && SignalCycle <= 23
    if SignalCycle < 12 || SignalCycle > 21
        mean = 55;
    else
        mean = 65;
    end
    for i = 1:length(Tau)-1
    n_downN(PredictionHorizonIndex,i) = round(sqrt(5)*randn + mean);
    n_downW(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 25);
    end
else
    for i = 1:length(Tau)-1
    n_downN(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 45);
    n_downW(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 25);
    end
end
for i = 1:length(Tau)-1
    n_downE(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 25);
    n_downS(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 50);
    fNS_upN(PredictionHorizonIndex,i) = round(sqrt(0.4)*randn + 1);
    fNS_upE(PredictionHorizonIndex,i) = round(sqrt(0.2)*randn + 1);
    fNS_upW(PredictionHorizonIndex,i) = round(sqrt(0.2)*randn + 1);
    fNS_upS(PredictionHorizonIndex,i) = round(sqrt(0.4)*randn + 1);
    fEW_upN(PredictionHorizonIndex,i) = round(sqrt(0.4)*randn + 0.5);
    fEW_upE(PredictionHorizonIndex,i) = round(sqrt(0.2)*randn + 1);
    fEW_upW(PredictionHorizonIndex,i) = round(sqrt(0.2)*randn + 1);
    fEW_upS(PredictionHorizonIndex,i) = round(sqrt(0.4)*randn + 0.75);
end


if  SignalCycle >= 36 && SignalCycle <= 50
    if SignalCycle < 40 || SignalCycle > 48
        mean = 60; % 60 to demonstrate everywhere operator in phi3 and 49 to demonstrate MSG_EVA
    else
        mean = 70; % 70 and 51
    end
    for i = 1:length(Tau)-1
    n_upN(PredictionHorizonIndex,i) = round(sqrt(5)*randn + mean);
    end
else
    for i = 1:length(Tau)-1
    n_upN(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 50);
    end
end
if  SignalCycle >= 31 && SignalCycle <= 45
    if SignalCycle < 33 || SignalCycle > 43
        mean = 30; % 30 and 24
    else
        mean = 40; % 40 and 26
    end
    for i = 1:length(Tau)-1
    n_upS(PredictionHorizonIndex,i) = round(sqrt(5)*randn + mean);
    end
else
    for i = 1:length(Tau)-1
    n_upS(PredictionHorizonIndex,i) = round(sqrt(5)*randn + 25);
    end
end
end

% Random Number of Vehicles

n_ranN = zeros(2,length(Tau)-1);
N_ranN = N_ranNub; % Prediction Mode
for i = 1:round(Tcy/N_ranN):length(Tau)-1
    n_ranN(1,i) = 1;
end
N_ranN = round(sqrt(4)*randn + 16); % Control Mode
if N_ranN <= N_ranNlb
    N_ranN = N_ranNlb;
elseif N_ranN >= N_ranNub
    N_ranN = N_ranNub;
end
for i = 1:round(Tcy/N_ranN):length(Tau)-1
    n_ranN(2,i) = 1;
end

n_ranE = zeros(2,length(Tau)-1);
N_ranE = N_ranEub;
for i = 1:round(Tcy/N_ranE):length(Tau)-1
    n_ranE(1,i) = 1;
end
N_ranE = round(sqrt(4)*randn + 6);
if N_ranE <= N_ranElb
    N_ranE = N_ranElb;
elseif N_ranE >= N_ranEub
    N_ranE = N_ranEub;
end
for i = 1:round(Tcy/N_ranE):length(Tau)-1
    n_ranE(2,i) = 1;
end

n_ranW = zeros(2,length(Tau)-1);
N_ranW = N_ranWub;
for i = 1:round(Tcy/N_ranW):length(Tau)-1
    n_ranW(1,i) = 1;
end
N_ranW = round(sqrt(4)*randn + 6);
if N_ranW <= N_ranWlb
    N_ranW = N_ranWlb;
elseif N_ranW >= N_ranWub
    N_ranW = N_ranWub;
end
for i = 1:round(Tcy/N_ranW):length(Tau)-1
    n_ranW(2,i) = 1;
end

n_ranS = zeros(2,length(Tau)-1);
N_ranS = N_ranSub;
for i = 1:round(Tcy/N_ranS):length(Tau)-1
    n_ranS(1,i) = 1;
end
N_ranS = round(sqrt(4)*randn + 8);
if N_ranS <= N_ranSlb
    N_ranS = N_ranSlb;
elseif N_ranS >= N_ranSub
    N_ranS = N_ranSub;
end
for i = 1:round(Tcy/N_ranS):length(Tau)-1
    n_ranS(2,i) = 1;
end
















