
global Tcy Tb1 NoSignalCycles SignalCycle PredictionHorizon PredictionCycle Mode
global n_downN n_downW
global n_upN n_upS
global NNp2GreenLimit NNp5GreenLimit NSp1GreenLimit NSp6GreenLimit
global MSG_ICA MSG_EVA

InitialParameters;

Tp1lb = 10;
Tp1ub = 25;
Tp5lb = 10;
Tp5ub = 25; % Variation lengths of Tp1 and Tp5 must be same

Tp3lb = 5;
Tp3ub = 20;
Tp7lb = 5;
Tp7ub = 20;

Tp1 = Tp1lb:1:Tp1ub;
Tp5 = Tp5lb:1:Tp5ub;
LenTp1 = length(Tp1);
LenTp5 = length(Tp5);

Tp3 = Tp3lb:1:Tp3ub;
Tp7 = Tp7lb:1:Tp7ub;
LenTp3 = length(Tp3);
LenTp7 = length(Tp7);

NNp2Init = 105; % 90 (Capacity 150)
NNp5Init = 50; % 50 (Capacity 50)
NSp1Init = 38; % 38 (Capacity 38)
NSp6Init = 95; % 36 (Capacity 112)

NEp4Init = 75; % 2 (Capacity 75)
NEp7Init = 25; % 5 (Capacity 25)
NWp3Init = 25; % 5 (Capacity 25)
NWp8Init = 75; % 2 (Capacity 75)

ObservedNNp2Init = NNp2Init;
ObservedNNp5Init = NNp5Init;
ObservedNSp1Init = NSp1Init;
ObservedNSp6Init = NSp6Init;
ObservedNEp4Init = NEp4Init;
ObservedNEp7Init = NEp7Init;
ObservedNWp3Init = NWp3Init;
ObservedNWp8Init = NWp8Init;

PredictionHorizon = 3;

OptimalTp1 = zeros(PredictionHorizon,NoSignalCycles);
OptimalTp5 = zeros(PredictionHorizon,NoSignalCycles);

OptimalTp3 = zeros(PredictionHorizon,NoSignalCycles);
OptimalTp7 = zeros(PredictionHorizon,NoSignalCycles);

OptimalNNp2Green = zeros(1,NoSignalCycles);
OptimalNNp2Red = zeros(1,NoSignalCycles);
OptimalNNp5Green = zeros(1,NoSignalCycles);
OptimalNNp5Red = zeros(1,NoSignalCycles);
OptimalNSp1Green = zeros(1,NoSignalCycles);
OptimalNSp1Red = zeros(1,NoSignalCycles);
OptimalNSp6Green = zeros(1,NoSignalCycles);
OptimalNSp6Red = zeros(1,NoSignalCycles);

OptimalNEp4Green = zeros(1,NoSignalCycles);
OptimalNEp4Red = zeros(1,NoSignalCycles);
OptimalNEp7Green = zeros(1,NoSignalCycles);
OptimalNEp7Red = zeros(1,NoSignalCycles);
OptimalNWp3Green = zeros(1,NoSignalCycles);
OptimalNWp3Red = zeros(1,NoSignalCycles);
OptimalNWp8Green = zeros(1,NoSignalCycles);
OptimalNWp8Red = zeros(1,NoSignalCycles);

SSTLPhi1FeasibilityUB = ones(1,NoSignalCycles);
SSTLPhi1Feasibility = zeros(1,NoSignalCycles);
SSTLPhi2Feasibility = zeros(1,NoSignalCycles);
SSTLPhi3AFeasibility = zeros(1,NoSignalCycles);
SSTLPhi3BFeasibility = zeros(1,NoSignalCycles);

ObservedNNp2Green = zeros(1,NoSignalCycles);
ObservedNNp2Final = zeros(1,NoSignalCycles);
ObservedNNp5Green = zeros(1,NoSignalCycles);
ObservedNNp5Final = zeros(1,NoSignalCycles);
ObservedNSp1Green = zeros(1,NoSignalCycles);
ObservedNSp1Final = zeros(1,NoSignalCycles);
ObservedNSp6Green = zeros(1,NoSignalCycles);
ObservedNSp6Final = zeros(1,NoSignalCycles);
ObservedNEp4Green = zeros(1,NoSignalCycles);
ObservedNEp4Final = zeros(1,NoSignalCycles);
ObservedNEp7Green = zeros(1,NoSignalCycles);
ObservedNEp7Final = zeros(1,NoSignalCycles);
ObservedNWp3Green = zeros(1,NoSignalCycles);
ObservedNWp3Final = zeros(1,NoSignalCycles);
ObservedNWp8Green = zeros(1,NoSignalCycles);
ObservedNWp8Final = zeros(1,NoSignalCycles);

N_downN = zeros(PredictionHorizon,NoSignalCycles);
N_downW = zeros(PredictionHorizon,NoSignalCycles);
N_upN = zeros(PredictionHorizon,NoSignalCycles);
N_upS = zeros(PredictionHorizon,NoSignalCycles);

SSTLp1p2p5p6 = NaN(LenTp1,LenTp1,NoSignalCycles);
lambda = zeros(1,NoSignalCycles);

BarGraphMatrixp1p2p3p4 = zeros(NoSignalCycles,4);
BarGraphMatrixp5p6p7p8 = zeros(NoSignalCycles,4);

for SignalCycle = 1:NoSignalCycles

if SignalCycle > 1
    [CheckTp1, CheckTp3, CheckTp5, CheckTp7, rho] = SSTLPhi4(MSG_ICA);
else
    rho = 0;
end
                    
if rho == 1
    
    [ObservedNNp2Green(1,SignalCycle), ~, ObservedNNp2Final(1,SignalCycle), ObservedNNp5Green(1,SignalCycle), ~, ObservedNNp5Final(1,SignalCycle), ...
     ObservedNSp1Green(1,SignalCycle), ~, ObservedNSp1Final(1,SignalCycle), ObservedNSp6Green(1,SignalCycle), ~, ObservedNSp6Final(1,SignalCycle), ...
     ObservedNEp4Green(1,SignalCycle), ~, ObservedNEp4Final(1,SignalCycle), ObservedNEp7Green(1,SignalCycle), ~, ObservedNEp7Final(1,SignalCycle), ...
     ObservedNWp3Green(1,SignalCycle), ~, ObservedNWp3Final(1,SignalCycle), ObservedNWp8Green(1,SignalCycle), ~, ObservedNWp8Final(1,SignalCycle)] ...
            = Intersection(CheckTp1, CheckTp5, CheckTp3, CheckTp7, ...
                           ObservedNNp2Init, ObservedNNp5Init, ...
                           ObservedNSp1Init, ObservedNSp6Init, ...
                           ObservedNEp4Init, ObservedNEp7Init, ...
                           ObservedNWp3Init, ObservedNWp8Init);
    
    ObservedNNp2Init = ObservedNNp2Final(1,SignalCycle);
    ObservedNNp5Init = ObservedNNp5Final(1,SignalCycle);
    ObservedNSp1Init = ObservedNSp1Final(1,SignalCycle);
    ObservedNSp6Init = ObservedNSp6Final(1,SignalCycle);
    ObservedNEp4Init = ObservedNEp4Final(1,SignalCycle);
    ObservedNEp7Init = ObservedNEp7Final(1,SignalCycle);
    ObservedNWp3Init = ObservedNWp3Final(1,SignalCycle);
    ObservedNWp8Init = ObservedNWp8Final(1,SignalCycle);
    
    NNp2Init = ObservedNNp2Init;
    NNp5Init = ObservedNNp5Init;
    NSp1Init = ObservedNSp1Init;
    NSp6Init = ObservedNSp6Init;
    NEp4Init = ObservedNEp4Init;
    NEp7Init = ObservedNEp7Init;
    NWp3Init = ObservedNWp3Init;
    NWp8Init = ObservedNWp8Init;

    OptimalTp1(1,SignalCycle) = CheckTp1;
    OptimalTp3(1,SignalCycle) = CheckTp3;
    OptimalTp5(1,SignalCycle) = CheckTp5;
    OptimalTp7(1,SignalCycle) = CheckTp7;
    BarGraphMatrixp1p2p3p4(SignalCycle,1) = OptimalTp1(1,SignalCycle);
    BarGraphMatrixp1p2p3p4(SignalCycle,2) = Tb1 - OptimalTp1(1,SignalCycle);
    BarGraphMatrixp1p2p3p4(SignalCycle,3) = OptimalTp3(1,SignalCycle);
    BarGraphMatrixp1p2p3p4(SignalCycle,4) = Tcy - Tb1 - OptimalTp3(1,SignalCycle);
    BarGraphMatrixp5p6p7p8(SignalCycle,1) = OptimalTp5(1,SignalCycle);
    BarGraphMatrixp5p6p7p8(SignalCycle,2) = Tb1 - OptimalTp5(1,SignalCycle);
    BarGraphMatrixp5p6p7p8(SignalCycle,3) = OptimalTp7(1,SignalCycle)';
    BarGraphMatrixp5p6p7p8(SignalCycle,4) = Tcy - Tb1 - OptimalTp7(1,SignalCycle);
    Tb1 = 35; % Reassigned regular value
    
else

CycleParameters;
Mode = 1; % 1 - Prediction Mode

% Prediction Cycle 1

PredictionCycle = 1;

NNp2GreenInit = zeros(1,LenTp1);
NNp2RedInit = zeros(1,LenTp1);
NNp2FinalInit = zeros(1,LenTp1);
NNp5GreenInit = zeros(1,LenTp5);
NNp5RedInit = zeros(1,LenTp5);
NNp5FinalInit = zeros(1,LenTp5);

NSp1GreenInit = zeros(1,LenTp1);
NSp1RedInit = zeros(1,LenTp1);
NSp1FinalInit = zeros(1,LenTp1);
NSp6GreenInit = zeros(1,LenTp5);
NSp6RedInit = zeros(1,LenTp5);
NSp6FinalInit = zeros(1,LenTp5);

NEp4GreenInit = zeros(1,LenTp3);
NEp4RedInit = zeros(1,LenTp3);
NEp4FinalInit = zeros(1,LenTp3);
NEp7GreenInit = zeros(1,LenTp7);
NEp7RedInit = zeros(1,LenTp7);
NEp7FinalInit = zeros(1,LenTp7);

NWp3GreenInit = zeros(1,LenTp3);
NWp3RedInit = zeros(1,LenTp3);
NWp3FinalInit = zeros(1,LenTp3);
NWp8GreenInit = zeros(1,LenTp7);
NWp8RedInit = zeros(1,LenTp7);
NWp8FinalInit = zeros(1,LenTp7);

N_downN(PredictionCycle,SignalCycle) = n_downN(PredictionCycle,end);
N_downW(PredictionCycle,SignalCycle) = n_downW(PredictionCycle,end);
N_upN(PredictionCycle,SignalCycle) = n_upN(PredictionCycle,end);
N_upS(PredictionCycle,SignalCycle) = n_upS(PredictionCycle,end);

for i = 1:LenTp1
    [NNp2GreenInit(1,i), NNp2RedInit(1,i), NNp2FinalInit(1,i), NNp5GreenInit(1,i), NNp5RedInit(1,i), NNp5FinalInit(1,i), ...
     NSp1GreenInit(1,i), NSp1RedInit(1,i), NSp1FinalInit(1,i), NSp6GreenInit(1,i), NSp6RedInit(1,i), NSp6FinalInit(1,i), ...
     NEp4GreenInit(1,i), NEp4RedInit(1,i), NEp4FinalInit(1,i), NEp7GreenInit(1,i), NEp7RedInit(1,i), NEp7FinalInit(1,i), ...
     NWp3GreenInit(1,i), NWp3RedInit(1,i), NWp3FinalInit(1,i), NWp8GreenInit(1,i), NWp8RedInit(1,i), NWp8FinalInit(1,i)] ...
            = Intersection(Tp1(i), Tp5(i), Tp3(i), Tp7(i), ...
                           NNp2Init, NNp5Init, ...
                           NSp1Init, NSp6Init, ...
                           NEp4Init, NEp7Init, ...
                           NWp3Init, NWp8Init);
end

% Prediction Cycles = 2:PredictionHorizon

NNp2Green = zeros(LenTp1,LenTp1,PredictionHorizon);
NNp2Red = zeros(LenTp1,LenTp1,PredictionHorizon);
NNp2Final = zeros(LenTp1,LenTp1,PredictionHorizon);
NNp5Green = zeros(LenTp5,LenTp5,PredictionHorizon);
NNp5Red = zeros(LenTp5,LenTp5,PredictionHorizon);
NNp5Final = zeros(LenTp5,LenTp5,PredictionHorizon);

NSp1Green = zeros(LenTp1,LenTp1,PredictionHorizon);
NSp1Red = zeros(LenTp1,LenTp1,PredictionHorizon);
NSp1Final = zeros(LenTp1,LenTp1,PredictionHorizon);
NSp6Green = zeros(LenTp5,LenTp5,PredictionHorizon);
NSp6Red = zeros(LenTp5,LenTp5,PredictionHorizon);
NSp6Final = zeros(LenTp5,LenTp5,PredictionHorizon);

NEp4Green = zeros(LenTp3,LenTp3,PredictionHorizon);
NEp4Red = zeros(LenTp3,LenTp3,PredictionHorizon);
NEp4Final = zeros(LenTp3,LenTp3,PredictionHorizon);
NEp7Green = zeros(LenTp7,LenTp7,PredictionHorizon);
NEp7Red = zeros(LenTp7,LenTp7,PredictionHorizon);
NEp7Final = zeros(LenTp7,LenTp7,PredictionHorizon);

NWp3Green = zeros(LenTp3,LenTp3,PredictionHorizon);
NWp3Red = zeros(LenTp3,LenTp3,PredictionHorizon);
NWp3Final = zeros(LenTp3,LenTp3,PredictionHorizon);
NWp8Green = zeros(LenTp7,LenTp7,PredictionHorizon);
NWp8Red = zeros(LenTp7,LenTp7,PredictionHorizon);
NWp8Final = zeros(LenTp7,LenTp7,PredictionHorizon);

for i = 1:LenTp1
    NNp2Green(i,:,1) = NNp2GreenInit(1,i);
    NNp2Red(i,:,1) = NNp2RedInit(1,i);
    NNp2Final(i,:,1) = NNp2FinalInit(1,i);
    NSp1Green(i,:,1) = NSp1GreenInit(1,i);
    NSp1Red(i,:,1) = NSp1RedInit(1,i);
    NSp1Final(i,:,1) = NSp1FinalInit(1,i);
end
for i = 1:LenTp5
    NNp5Green(i,:,1) = NNp5GreenInit(1,i);
    NNp5Red(i,:,1) = NNp5RedInit(1,i);
    NNp5Final(i,:,1) = NNp5FinalInit(1,i);
    NSp6Green(i,:,1) = NSp6GreenInit(1,i);
    NSp6Red(i,:,1) = NSp6RedInit(1,i);
    NSp6Final(i,:,1) = NSp6FinalInit(1,i);
end
for i = 1:LenTp3
    NEp4Green(i,:,1) = NEp4GreenInit(1,i);
    NEp4Red(i,:,1) = NEp4RedInit(1,i);
    NEp4Final(i,:,1) = NEp4FinalInit(1,i);
    NWp3Green(i,:,1) = NWp3GreenInit(1,i);
    NWp3Red(i,:,1) = NWp3RedInit(1,i);
    NWp3Final(i,:,1) = NWp3FinalInit(1,i);
end
for i = 1:LenTp7
    NEp7Green(i,:,1) = NEp7GreenInit(1,i);
    NEp7Red(i,:,1) = NEp7RedInit(1,i);
    NEp7Final(i,:,1) = NEp7FinalInit(1,i);
    NWp8Green(i,:,1) = NWp8GreenInit(1,i);
    NWp8Red(i,:,1) = NWp8RedInit(1,i);
    NWp8Final(i,:,1) = NWp8FinalInit(1,i);
end


for PredictionCycle = 2:PredictionHorizon
    
    N_downN(PredictionCycle,SignalCycle) = n_downN(PredictionCycle,end);
    N_downW(PredictionCycle,SignalCycle) = n_downW(PredictionCycle,end);
    N_upN(PredictionCycle,SignalCycle) = n_upN(PredictionCycle,end);
    N_upS(PredictionCycle,SignalCycle) = n_upS(PredictionCycle,end);
    
    for i = 1:LenTp1
        
        for j = 1:LenTp1
            
            [NNp2Green(i,j,PredictionCycle), NNp2Red(i,j,PredictionCycle), NNp2Final(i,j,PredictionCycle), NNp5Green(i,j,PredictionCycle), NNp5Red(i,j,PredictionCycle), NNp5Final(i,j,PredictionCycle), ...
             NSp1Green(i,j,PredictionCycle), NSp1Red(i,j,PredictionCycle), NSp1Final(i,j,PredictionCycle), NSp6Green(i,j,PredictionCycle), NSp6Red(i,j,PredictionCycle), NSp6Final(i,j,PredictionCycle), ...
             NEp4Green(i,j,PredictionCycle), NEp4Red(i,j,PredictionCycle), NEp4Final(i,j,PredictionCycle), NEp7Green(i,j,PredictionCycle), NEp7Red(i,j,PredictionCycle), NEp7Final(i,j,PredictionCycle), ...
             NWp3Green(i,j,PredictionCycle), NWp3Red(i,j,PredictionCycle), NWp3Final(i,j,PredictionCycle), NWp8Green(i,j,PredictionCycle), NWp8Red(i,j,PredictionCycle), NWp8Final(i,j,PredictionCycle)] ...
                    = Intersection(Tp1(j), Tp5(j), Tp3(j), Tp7(j), ...
                                   NNp2Final(i,j,PredictionCycle-1), NNp5Final(i,j,PredictionCycle-1), ...
                                   NSp1Final(i,j,PredictionCycle-1), NSp6Final(i,j,PredictionCycle-1), ...
                                   NEp4Final(i,j,PredictionCycle-1), NEp7Final(i,j,PredictionCycle-1), ...
                                   NWp3Final(i,j,PredictionCycle-1), NWp8Final(i,j,PredictionCycle-1));
        
        end
        
    end
    
end

% Major Street ------------------------------------------------------------

% SSTL Specification for Major Street

for i = 1:LenTp1
    
    for j = 1:LenTp1
        
        rho = SSTLPhi1(NNp2Green(i,j,:), NNp5Green(i,j,:), ...
                       NSp1Green(i,j,:), NSp6Green(i,j,:), lambda(1,SignalCycle));
        if rho > 0
            SSTLp1p2p5p6(i,j,SignalCycle) = 1;
        end
                          
    end
    
end

if isnan(min(min(SSTLp1p2p5p6(:,:,SignalCycle))))
    SSTLPhi1FeasibilityUB(1,SignalCycle) = 0;
end

while isnan(min(min(SSTLp1p2p5p6(:,:,SignalCycle))))
    
    lambda(1,SignalCycle) = lambda(1,SignalCycle) + 1;
    
    for i = 1:LenTp1
        
        for j = 1:LenTp1
            
            rho = SSTLPhi1(NNp2Green(i,j,:), NNp5Green(i,j,:), ...
                           NSp1Green(i,j,:), NSp6Green(i,j,:), lambda(1,SignalCycle));
            if rho > 0
                SSTLp1p2p5p6(i,j,SignalCycle) = 1;
            end
                          
        end
    
    end
    
end

% Phases p1 and p2 Optimization

Costp1p2 = zeros(LenTp1,LenTp1);

for i = 1:LenTp1
    
    for j = 1:LenTp1
        
        Costp1p2(i,j) = sum(NNp2Green(i,j,:)) + sum(NSp1Green(i,j,:));
        
    end
    
end

SSTLp1p2 = SSTLp1p2p5p6(:,:,SignalCycle);
if isnan(min(min(Costp1p2.*SSTLp1p2)))
    FeasibleRegion = Costp1p2;
else
    FeasibleRegion = Costp1p2.*SSTLp1p2;
end

[ColumnMin, ColumnMinRowIndices] = min(FeasibleRegion);
[~, IndexJ] = min(ColumnMin);
IndexI = ColumnMinRowIndices(IndexJ);

OptimalTp1(1,SignalCycle) = Tp1(IndexI);
OptimalTp1(2:3,SignalCycle) = Tp1(IndexJ);

OptimalNNp2Green(1,SignalCycle) = NNp2Green(IndexI,IndexJ,1);
OptimalNNp2Red(1,SignalCycle) = NNp2Red(IndexI,IndexJ,1);
OptimalNSp1Green(1,SignalCycle) = NSp1Green(IndexI,IndexJ,1);
OptimalNSp1Red(1,SignalCycle) = NSp1Red(IndexI,IndexJ,1);

NNp2Init = NNp2Final(IndexI,IndexJ,1);
NSp1Init = NSp1Final(IndexI,IndexJ,1);

% Phases p5 and p6 Optimization

Costp5p6 = zeros(LenTp5,LenTp5);

for i = 1:LenTp5
    
    for j = 1:LenTp5
        
        Costp5p6(i,j) = sum(NNp5Green(i,j,:)) + sum(NSp6Green(i,j,:));
        
    end
    
end

SSTLp5p6 = SSTLp1p2p5p6(:,:,SignalCycle);
if isnan(min(min(Costp5p6.*SSTLp5p6)))
    FeasibleRegion = Costp5p6;
else
    FeasibleRegion = Costp5p6.*SSTLp5p6;
end

[ColumnMin, ColumnMinRowIndices] = min(FeasibleRegion);
[~, IndexJ] = min(ColumnMin);
IndexI = ColumnMinRowIndices(IndexJ);

OptimalTp5(1,SignalCycle) = Tp5(IndexI);
OptimalTp5(2:3,SignalCycle) = Tp5(IndexJ);

OptimalNNp5Green(1,SignalCycle) = NNp5Green(IndexI,IndexJ,1);
OptimalNNp5Red(1,SignalCycle) = NNp5Red(IndexI,IndexJ,1);
OptimalNSp6Green(1,SignalCycle) = NSp6Green(IndexI,IndexJ,1);
OptimalNSp6Red(1,SignalCycle) = NSp6Red(IndexI,IndexJ,1);

NNp5Init = NNp5Final(IndexI,IndexJ,1);
NSp6Init = NSp6Final(IndexI,IndexJ,1);

%rho = SSTLPhi1(OptimalNNp2Green(1,SignalCycle), OptimalNNp5Green(1,SignalCycle), ...
%               OptimalNSp1Green(1,SignalCycle), OptimalNSp6Green(1,SignalCycle), 0);
%if rho > 0
%    SSTLPhi1FeasibilityUB(1,SignalCycle) = 1;
%end

% Minor Street ------------------------------------------------------------

% Phases p3 and p4 Optimization

Costp3p4 = zeros(LenTp3,LenTp3);

for i = 1:LenTp3
    
    for j = 1:LenTp3
        
        Costp3p4(i,j) = sum(NEp4Green(i,j,:)) + sum(NWp3Green(i,j,:));
        
    end
    
end

SSTLp3p4A = NaN(LenTp3,LenTp3);
if SignalCycle > 1    
for i = 1:LenTp3
    
    for j = 1:LenTp3
        
        rho = SSTLPhi2(N_downN(:,SignalCycle-1), N_downW(:,SignalCycle-1), [Tp3(i) Tp3(j) Tp3(j)]);
        if rho > 0
            SSTLp3p4A(i,j) = 1;
        end
        
    end
    
end
end
SSTLp3p4B = NaN(LenTp3,LenTp3);
if SignalCycle > PredictionHorizon+1 && SignalCycle < NoSignalCycles-PredictionHorizon-1
for i = 1:LenTp3
    
    for j = 1:LenTp3
        
        rho = SSTLPhi3A(MSG_EVA, N_upN(1,:), N_upS(1,:), [Tp3(i) Tp3(j) Tp3(j)]);
        if rho > 0
            SSTLp3p4B(i,j) = 1;
        end
        
    end
    
end
end

if isnan(min(min(Costp3p4.*SSTLp3p4A.*SSTLp3p4B)))
    FeasibleRegion = Costp3p4;
else
    FeasibleRegion = Costp3p4.*SSTLp3p4A.*SSTLp3p4B;
end

[ColumnMin, ColumnMinRowIndices] = min(FeasibleRegion);
[~, IndexJ] = min(ColumnMin);
IndexI = ColumnMinRowIndices(IndexJ);

OptimalTp3(1,SignalCycle) = Tp3(IndexI);
OptimalTp3(2:3,SignalCycle) = Tp3(IndexJ);

OptimalNEp4Green(1,SignalCycle) = NEp4Green(IndexI,IndexJ,1);
OptimalNEp4Red(1,SignalCycle) = NEp4Red(IndexI,IndexJ,1);
OptimalNWp3Green(1,SignalCycle) = NWp3Green(IndexI,IndexJ,1);
OptimalNWp3Red(1,SignalCycle) = NWp3Red(IndexI,IndexJ,1);

NEp4Init = NEp4Final(IndexI,IndexJ,1);
NWp3Init = NWp3Final(IndexI,IndexJ,1);

if SignalCycle > 1 
rho = SSTLPhi2(N_downN(1,SignalCycle-1), N_downW(1,SignalCycle-1), OptimalTp3(1,SignalCycle));
if rho > 0
    SSTLPhi2Feasibility(1,SignalCycle) = 1;
end
end
if SignalCycle > PredictionHorizon+1 && SignalCycle < NoSignalCycles - PredictionHorizon - 1
rho = SSTLPhi3A(MSG_EVA, N_upN(1,:), N_upS(1,:), OptimalTp3(:,SignalCycle));
if rho > 0
    SSTLPhi3AFeasibility(1,SignalCycle) = 1;
end
end

% Phases p7 and p8 Optimization

Costp7p8 = zeros(LenTp7,LenTp7);

for i = 1:LenTp7
    
    for j = 1:LenTp7
        
        Costp7p8(i,j) = sum(NEp7Green(i,j,:)) + sum(NWp8Green(i,j,:));
        
    end
    
end

SSTLp7p8 = NaN(LenTp7,LenTp7);

if SignalCycle > PredictionHorizon+1 && SignalCycle < NoSignalCycles - PredictionHorizon
for i = 1:LenTp7
    
    for j = 1:LenTp7
        
        rho = SSTLPhi3B(MSG_EVA, N_upN(1,:), N_upS(1,:), [Tp7(i) Tp7(j) Tp7(j)]);
        if rho > 0
            SSTLp7p8(i,j) = 1;
        end
        
    end
    
end
end

if isnan(min(min(Costp7p8.*SSTLp7p8)))
    FeasibleRegion = Costp7p8;
else
    FeasibleRegion = Costp7p8.*SSTLp7p8;
end

[ColumnMin, ColumnMinRowIndices] = min(FeasibleRegion);
[~, IndexJ] = min(ColumnMin);
IndexI = ColumnMinRowIndices(IndexJ);

OptimalTp7(1,SignalCycle) = Tp7(IndexI);
OptimalTp7(2:3,SignalCycle) = Tp7(IndexJ);

OptimalNEp7Green(1,SignalCycle) = NEp7Green(IndexI,IndexJ,1);
OptimalNEp7Red(1,SignalCycle) = NEp7Red(IndexI,IndexJ,1);
OptimalNWp8Green(1,SignalCycle) = NWp8Green(IndexI,IndexJ,1);
OptimalNWp8Red(1,SignalCycle) = NWp8Red(IndexI,IndexJ,1);

NEp7Init = NEp7Final(IndexI,IndexJ,1);
NWp8Init = NWp8Final(IndexI,IndexJ,1);

if SignalCycle > PredictionHorizon+1 && SignalCycle < NoSignalCycles - PredictionHorizon - 1
rho = SSTLPhi3B(MSG_EVA, N_upN(1,:), N_upS(1,:), OptimalTp7(:,SignalCycle));
if rho > 0
    SSTLPhi3BFeasibility(1,SignalCycle) = 1;
end
end

PredictionCycle = 1;
Mode = 2; % 2 - Control Mode

[ObservedNNp2Green(1,SignalCycle), ~, ObservedNNp2Final(1,SignalCycle), ObservedNNp5Green(1,SignalCycle), ~, ObservedNNp5Final(1,SignalCycle), ...
 ObservedNSp1Green(1,SignalCycle), ~, ObservedNSp1Final(1,SignalCycle), ObservedNSp6Green(1,SignalCycle), ~, ObservedNSp6Final(1,SignalCycle), ...
 ObservedNEp4Green(1,SignalCycle), ~, ObservedNEp4Final(1,SignalCycle), ObservedNEp7Green(1,SignalCycle), ~, ObservedNEp7Final(1,SignalCycle), ...
 ObservedNWp3Green(1,SignalCycle), ~, ObservedNWp3Final(1,SignalCycle), ObservedNWp8Green(1,SignalCycle), ~, ObservedNWp8Final(1,SignalCycle)] ...
    = Intersection(OptimalTp1(1,SignalCycle), OptimalTp5(1,SignalCycle), OptimalTp3(1,SignalCycle), OptimalTp7(1,SignalCycle), ...
                        ObservedNNp2Init, ObservedNNp5Init, ...
                        ObservedNSp1Init, ObservedNSp6Init, ...
                        ObservedNEp4Init, ObservedNEp7Init, ...
                        ObservedNWp3Init, ObservedNWp8Init);

ObservedNNp2Init = min(ObservedNNp2Final(1,SignalCycle),NNp2Init);
ObservedNNp5Init = min(ObservedNNp5Final(1,SignalCycle),NNp5Init);
ObservedNSp1Init = min(ObservedNSp1Final(1,SignalCycle),NSp1Init);
ObservedNSp6Init = min(ObservedNSp6Final(1,SignalCycle),NSp6Init);
ObservedNEp4Init = min(ObservedNEp4Final(1,SignalCycle),NEp4Init);
ObservedNEp7Init = min(ObservedNEp7Final(1,SignalCycle),NEp7Init);
ObservedNWp3Init = min(ObservedNWp3Final(1,SignalCycle),NWp3Init);
ObservedNWp8Init = min(ObservedNWp8Final(1,SignalCycle),NWp8Init);

rho = SSTLPhi1(ObservedNNp2Green(1,SignalCycle), ObservedNNp5Green(1,SignalCycle), ...
               ObservedNSp1Green(1,SignalCycle), ObservedNSp6Green(1,SignalCycle), 0);
if rho > 0
    SSTLPhi1Feasibility(1,SignalCycle) = 1;
end

BarGraphMatrixp1p2p3p4(SignalCycle,1) = OptimalTp1(1,SignalCycle);
BarGraphMatrixp1p2p3p4(SignalCycle,2) = Tb1 - OptimalTp1(1,SignalCycle);
BarGraphMatrixp1p2p3p4(SignalCycle,3) = OptimalTp3(1,SignalCycle);
BarGraphMatrixp1p2p3p4(SignalCycle,4) = Tcy - Tb1 - OptimalTp3(1,SignalCycle);
BarGraphMatrixp5p6p7p8(SignalCycle,1) = OptimalTp5(1,SignalCycle);
BarGraphMatrixp5p6p7p8(SignalCycle,2) = Tb1 - OptimalTp5(1,SignalCycle);
BarGraphMatrixp5p6p7p8(SignalCycle,3) = OptimalTp7(1,SignalCycle)';
BarGraphMatrixp5p6p7p8(SignalCycle,4) = Tcy - Tb1 - OptimalTp7(1,SignalCycle);

end
    
end

%{
figure;
subplot(2,4,1); stairs(OptimalTp1(1,:),'LineWidth',1.2); title('Optimal Tp1'); xlabel('Time (sec)'); ylabel('Tp1 Interval (sec)');
subplot(2,4,2); stairs(OptimalNSp1Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNSp1Red,'r','LineWidth',1.2); title('Phase p1');
subplot(2,4,3); stairs(OptimalNNp2Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNNp2Red,'r','LineWidth',1.2); title('Phase p2');
subplot(2,4,4); stairs(SSTLPhi1Feasibility,'b','LineWidth',1.2); title('SSTL1 Feasibility'); xlabel('Time (sec)');               

subplot(2,4,5); stairs(OptimalTp5(1,:),'LineWidth',1.2); title('Optimal Tp5'); xlabel('Time (sec)'); ylabel('Tp5 Interval (sec)');
subplot(2,4,6); stairs(OptimalNNp5Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNNp5Red,'r','LineWidth',1.2); title('Phase p5');
subplot(2,4,7); stairs(OptimalNSp6Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNSp6Red,'r','LineWidth',1.2); title('Phase p6');

figure;
subplot(2,4,1); stairs(OptimalTp3(1,:),'LineWidth',1.2); title('Optimal Tp3'); xlabel('Time (sec)'); ylabel('Tp3 Interval (sec)');
subplot(2,4,2); stairs(OptimalNWp3Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNWp3Red,'r','LineWidth',1.2); title('Phase p3');
subplot(2,4,3); stairs(OptimalNEp4Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNEp4Red,'r','LineWidth',1.2); title('Phase p4');
                
subplot(2,4,5); stairs(OptimalTp7(1,:),'LineWidth',1.2); title('Optimal Tp7'); xlabel('Time (sec)'); ylabel('Tp7 Interval (sec)');
subplot(2,4,6); stairs(OptimalNEp7Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNEp7Red,'r','LineWidth',1.2); title('Phase p7');
subplot(2,4,7); stairs(OptimalNWp8Green,'g','LineWidth',1.2); xlabel('Time (sec)'); ylabel('No of Vehicles'); hold on;
                stairs(OptimalNWp8Red,'r','LineWidth',1.2); title('Phase p8');
%}

FaceSize = 20;

figure;
subplot(2,4,1); bar(BarGraphMatrixp1p2p3p4,'stacked','BarWidth',1);
                legend('$T^{p_{1}}$','$T^{p_{2}}$','$T^{p_{3}}$','$T^{p_{4}}$','Interpreter','latex','FontSize',FaceSize);
                title('Optimized Intervals','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Time (sec)','Interpreter','latex','FontSize',FaceSize); 
                
subplot(2,4,2); stairs(0.5:1:59.5,OptimalNSp1Green,'k','LineWidth',2);
                hold on;
                bar(ObservedNSp1Green,'FaceColor',[0 0.4470 0.7410],'BarWidth',1);
                title('Phase $p_{1}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                %ylim([0,18]);
                ylabel('$n^{p_{1}}$','Interpreter','latex','FontSize',FaceSize);
                hold on;
                plot(NSp1GreenLimit*ones(1,NoSignalCycles),'--','Color','k','LineWidth',2);
                legend('$n^{p_{1}}$ using $\overline{n}_{l_{s}^{in}}^{ran}$','$n^{p_{1}}$ using $n_{l_{s}^{in}}^{ran}$','$c^{p_{1}}$','Interpreter','latex','FontSize',FaceSize);
                text(45,NSp1GreenLimit+0.5,{'$c^{p_{1}}$'},'Interpreter','latex','FontSize',FaceSize);
                
subplot(2,4,3); stairs(0.5:1:59.5,OptimalNNp2Green,'k','LineWidth',2);
                hold on;
                bar(ObservedNNp2Green,'FaceColor',[0.8500 0.3250 0.0980],'BarWidth',1);
                title('Phase $p_{2}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                %ylim([0,18]);
                ylabel('$n^{p_{2}}$','Interpreter','latex','FontSize',FaceSize);
                hold on;
                plot(NNp2GreenLimit*ones(1,NoSignalCycles),'--','Color','k','LineWidth',2);
                legend('$n^{p_{2}}$ using $\overline{n}_{l_{n}^{in}}^{ran}$','$n^{p_{2}}$ using $n_{l_{n}^{in}}^{ran}$','$c^{p_{2}}$','Interpreter','latex','FontSize',FaceSize);
                text(45,NNp2GreenLimit+0.5,{'$c^{p_{2}}$'},'Interpreter','latex','FontSize',FaceSize);
                
subplot(2,4,4); plot(SSTLPhi1FeasibilityUB,'.','MarkerSize',10);
                title({'Feasibility of $\mu_{1}$ in SSTL $\varphi_{1}$'},'Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylim([-0.5,1.5]);
                yticks([0 1]);
                yticklabels({'Infeasible','Feasible'});
                ytickangle(90);

subplot(2,4,5); BarGraphp5p6p7p8 = bar(BarGraphMatrixp5p6p7p8, 'stacked','BarWidth',1); 
                BarGraphp5p6p7p8(1).FaceColor = [0.3010 0.7450 0.9330]; BarGraphp5p6p7p8(2).FaceColor = [0.6350 0.0780 0.1840]; 
                BarGraphp5p6p7p8(3).FaceColor = [0.9 0.8 0]; BarGraphp5p6p7p8(4).FaceColor = [.2 .6 .5];
                legend('$T^{p_{5}}$','$T^{p_{6}}$','$T^{p_{7}}$','$T^{p_{8}}$','Interpreter','latex','FontSize',FaceSize);
                title('Optimized Intervals','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Time (sec)','Interpreter','latex','FontSize',FaceSize); 
                
subplot(2,4,6); stairs(0.5:1:59.5,OptimalNNp5Green,'k','LineWidth',2);
                hold on;
                bar(ObservedNNp5Green,'FaceColor',[0.3010 0.7450 0.9330],'BarWidth',1);
                title('Phase $p_{5}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('$n^{p_{5}}$','Interpreter','latex','FontSize',FaceSize);
                ylim([0,30]);
                hold on;
                plot(NNp5GreenLimit*ones(1,NoSignalCycles),'--','Color','k','LineWidth',2);
                legend('$n^{p_{5}}$ using $\overline{n}_{l_{n}^{in}}^{ran}$','$n^{p_{5}}$ using $n_{l_{n}^{in}}^{ran}$','$c^{p_{5}}$','Interpreter','latex','FontSize',FaceSize);
                text(45,NNp5GreenLimit+0.7,{'$c^{p_{5}}$'},'Interpreter','latex','FontSize',FaceSize);
                
subplot(2,4,7); stairs(0.5:1:59.5,OptimalNSp6Green,'k','LineWidth',2);
                hold on;
                bar(ObservedNSp6Green,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',1);
                title('Phase $p_{6}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('$n^{p_{6}}$','Interpreter','latex','FontSize',FaceSize); 
                %ylim([0, 10]);
                hold on;
                plot(NSp6GreenLimit*ones(1,NoSignalCycles),'--','Color','k','LineWidth',2);
                legend('$n^{p_{6}}$ using $\overline{n}_{l_{s}^{in}}^{ran}$','$n^{p_{6}}$ using $n_{l_{s}^{in}}^{ran}$','$c^{p_{6}}$','Interpreter','latex','FontSize',FaceSize);
                text(45,NSp6GreenLimit+0.3,{'$c^{p_{6}}$'},'Interpreter','latex','FontSize',FaceSize);

subplot(2,4,8); histogram(OptimalNNp5Green,'Normalization','probability','FaceColor',[0.3010 0.7450 0.9330]);
                title('PDF for Phase $p_{5}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('$n^{p_{5}}$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Probability','Interpreter','latex','FontSize',FaceSize);
                
figure;
subplot(2,4,1); bar(BarGraphMatrixp1p2p3p4, 'stacked','BarWidth',1);
                legend('$T^{p_{1}}$','$T^{p_{2}}$','$T^{p_{3}}$','$T^{p_{4}}$','Interpreter','latex','FontSize',FaceSize);
                title('Optimized Intervals','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Time (sec)','Interpreter','latex','FontSize',FaceSize);
                
subplot(2,4,2); bar(ObservedNWp3Green,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',1);
                title('Phase $p_{3}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('$n^{p_{3}}$','Interpreter','latex','FontSize',FaceSize);
                ylim([0,8]);
                
subplot(2,4,3); bar(ObservedNEp4Green,'FaceColor',[0.4940 0.1840 0.5560],'BarWidth',1); 
                title('Phase $p_{4}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('$n^{p_{4}}$','Interpreter','latex','FontSize',FaceSize);
                %ylim([0,40]);
                
subplot(2,4,4); yyaxis left;
                stairs(N_downN(1,1:35),'LineWidth',2); hold on;
                stairs(N_downW(1,1:35),':','LineWidth',2);
                plot(59*ones(1,NoSignalCycles),'-','Color',[0 0.4470 0.7410],'LineWidth',1);
                plot(33*ones(1,NoSignalCycles),':','Color',[0 0.4470 0.7410],'LineWidth',1);
                legend('$l_{n}^{out}$','$l_{w}^{out}$','Interpreter','latex','FontSize',FaceSize);
                title({'Trace $X_{2}$ for $\varphi_{2}$'},'Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Number of Vehicles','Interpreter','latex','FontSize',FaceSize);
                yticks([20 30 33 40 50 59 70 80]);
                yticklabels({'20','30','Limit c^{w}','40','50','Limit c^{n}','70','80'});
                yyaxis right;
                stairs(BarGraphMatrixp1p2p3p4(1:35,4),'LineWidth',2);
                plot(10*ones(1,NoSignalCycles),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
                plot(6*ones(1,NoSignalCycles),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
                legend('$l_{n}^{out}$','$l_{w}^{out}$','','','$T^{p_{4}}$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Time (sec)','Interpreter','latex','FontSize',FaceSize);
                yticks([0 5 6 10 15 20]);
                yticklabels({'0','5','Limit a^{l}','Limit a^{u}','15','25'});
                xlim([0,60]);
                ylim([0,20]);
                
subplot(2,4,5); BarGraphp5p6p7p8 = bar(BarGraphMatrixp5p6p7p8,'stacked','BarWidth',1); 
                BarGraphp5p6p7p8(1).FaceColor = [0.3010 0.7450 0.9330]; BarGraphp5p6p7p8(2).FaceColor = [0.6350 0.0780 0.1840]; 
                BarGraphp5p6p7p8(3).FaceColor = [0.9 0.8 0]; BarGraphp5p6p7p8(4).FaceColor = [.2 .6 .5];
                legend('$T^{p_{5}}$','$T^{p_{6}}$','$T^{p_{7}}$','$T^{p_{8}}$','Interpreter','latex','FontSize',FaceSize);
                title('Optimized Intervals','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Time (sec)','Interpreter','latex','FontSize',FaceSize); 
                
subplot(2,4,6); bar(ObservedNEp7Green,'FaceColor',[0.9 0.8 0],'BarWidth',1); 
                title('Phase $p_{7}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('$n^{p_{7}}$','Interpreter','latex','FontSize',FaceSize);
                ylim([0,12]);
                
subplot(2,4,7); bar(ObservedNWp8Green,'FaceColor',[.2 .6 .5],'BarWidth',1); 
                title('Phase $p_{8}$','Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('$n^{p_{8}}$','Interpreter','latex','FontSize',FaceSize);
                ylim([0,5]);
                
subplot(2,4,8); yyaxis left;
                stairs((26:1:60),N_upN(1,26:end),'LineWidth',2); hold on;
                stairs((26:1:60),N_upS(1,26:end),':','LineWidth',2);
                plot(65*ones(1,NoSignalCycles),'-','Color',[0 0.4470 0.7410],'LineWidth',1);
                plot(35*ones(1,NoSignalCycles),':','Color',[0 0.4470 0.7410],'LineWidth',1); 
                title({'Trace $X_{3}$ for $\varphi_{3}$'},'Interpreter','latex','FontSize',FaceSize);
                xlabel('Signal Cycle $k$','Interpreter','latex','FontSize',FaceSize);
                ylabel('Number of Vehicles','Interpreter','latex','FontSize',FaceSize);
                yticks([20 30 35 40 50 60 65 70 80]);
                yticklabels({'20','30','Limit c^{2}','40','50','60','Limit c^{1}','70','80'});
                yyaxis right;
                stairs((26:1:60),BarGraphMatrixp1p2p3p4(26:end,3),'LineWidth',2);
                stairs((26:1:60),BarGraphMatrixp5p6p7p8(26:end,4),':','LineWidth',2);
                plot(15*ones(1,NoSignalCycles),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
                plot(20*ones(1,NoSignalCycles),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1);
                legend('$l_{1}$','$l_{2}$','','','$T^{p_{3}}$','$T^{p_{8}}$','','','Interpreter','latex','FontSize',FaceSize);
                ylabel('Time (sec)','Interpreter','latex','FontSize',FaceSize);
                yticks([0 5 10 15 20 25]);
                yticklabels({'0','5','10','Limit b^{l}','Limit b^{u}','25'});
                ylim([0,25]);
                

%{
% No of Vehicles (Red - Green) vs Green Interval %
                
PercentTp1 = zeros(1,NoSignalCycles);
PercentTp2 = zeros(1,NoSignalCycles);
PercentTp3 = zeros(1,NoSignalCycles);
PercentTp4 = zeros(1,NoSignalCycles);
PercentTp5 = zeros(1,NoSignalCycles);
PercentTp6 = zeros(1,NoSignalCycles);
PercentTp7 = zeros(1,NoSignalCycles);
PercentTp8 = zeros(1,NoSignalCycles);

for i = 1:NoSignalCycles
    PercentTp1(1,i) = (BarGraphMatrixp1p2p3p4(i,1)/Tcy)*100;
    PercentTp2(1,i) = (BarGraphMatrixp1p2p3p4(i,2)/Tcy)*100;
    PercentTp3(1,i) = (BarGraphMatrixp1p2p3p4(i,3)/Tcy)*100;
    PercentTp4(1,i) = (BarGraphMatrixp1p2p3p4(i,4)/Tcy)*100;
    PercentTp5(1,i) = (BarGraphMatrixp5p6p7p8(i,1)/Tcy)*100;
    PercentTp6(1,i) = (BarGraphMatrixp5p6p7p8(i,2)/Tcy)*100;
    PercentTp7(1,i) = (BarGraphMatrixp5p6p7p8(i,3)/Tcy)*100;
    PercentTp8(1,i) = (BarGraphMatrixp5p6p7p8(i,4)/Tcy)*100;

end

DifferenceNSp1 = OptimalNSp1Red - OptimalNSp1Green;
DifferenceNNp2 = OptimalNNp2Red - OptimalNNp2Green;
DifferenceNWp3 = OptimalNWp3Red - OptimalNWp3Green;
DifferenceNEp4 = OptimalNEp4Red - OptimalNEp4Green;
DifferenceNNp5 = OptimalNNp5Red - OptimalNNp5Green;
DifferenceNSp6 = OptimalNSp6Red - OptimalNSp6Green;
DifferenceNEp7 = OptimalNEp7Red - OptimalNEp7Green;
DifferenceNWp8 = OptimalNWp8Red - OptimalNWp8Green;

figure; 
subplot(2,4,1); scatter(PercentTp1,DifferenceNSp1(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p1'); xlabel('Tp1 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,2); scatter(PercentTp2,DifferenceNNp2(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p2'); xlabel('Tp2 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,3); scatter(PercentTp3,DifferenceNWp3(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p3'); xlabel('Tp3 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,4); scatter(PercentTp4,DifferenceNEp4(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p4'); xlabel('Tp4 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,5); scatter(PercentTp5,DifferenceNNp5(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p5'); xlabel('Tp5 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,6); scatter(PercentTp6,DifferenceNSp6(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p6'); xlabel('Tp6 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,7); scatter(PercentTp7,DifferenceNEp7(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p7'); xlabel('Tp7 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
subplot(2,4,8); scatter(PercentTp8,DifferenceNWp8(Tcy:Tcy:NoSignalCycles*Tcy),'filled'); title('Phase p8'); xlabel('Tp8 %'); ylabel('(Red - Green) No of Vehicles'); xlim([0,50]); ylim([15,75]);
%}


%{
% Reference contrl input for infeasible case
                
PredictedOptimalTp1(:,SignalCycle) = ReferenceTp1;
OptimalNNp2Green(1,((SignalCycle-1)*Tcy)+1:SignalCycle*Tcy) = NNp2Green(ReferenceTp1-Tp1lb+1,ReferenceTp1-Tp1lb+1,1);
OptimalNNp2Red(1,((SignalCycle-1)*Tcy)+1:SignalCycle*Tcy) = NNp2Red(ReferenceTp1-Tp1lb+1,ReferenceTp1-Tp1lb+1,1);
OptimalNSp1Green(1,((SignalCycle-1)*Tcy)+1:SignalCycle*Tcy) = NSp1Green(ReferenceTp1-Tp1lb+1,ReferenceTp1-Tp1lb+1,1);
OptimalNSp1Red(1,((SignalCycle-1)*Tcy)+1:SignalCycle*Tcy) = NSp1Red(ReferenceTp1-Tp1lb+1,ReferenceTp1-Tp1lb+1,1);                
%}
