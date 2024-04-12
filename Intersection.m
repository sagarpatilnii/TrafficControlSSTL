function [NNp2Green, NNp2Red, NNp2Final, NNp5Green, NNp5Red, NNp5Final, ...
          NSp1Green, NSp1Red, NSp1Final, NSp6Green, NSp6Red, NSp6Final, ...
          NEp4Green, NEp4Red, NEp4Final, NEp7Green, NEp7Red, NEp7Final, ...
          NWp3Green, NWp3Red, NWp3Final, NWp8Green, NWp8Red, NWp8Final] = Intersection(Tp1, Tp5, Tp3, Tp7, ...
                                                                                       NNp2Init, NNp5Init, ...
                                                                                       NSp1Init, NSp6Init, ...
                                                                                       NEp4Init, NEp7Init, ...
                                                                                       NWp3Init, NWp8Init)

global Tcy Tb1 Tau PredictionCycle Mode
global n_downN n_downE n_downW n_downS
global fNS_upN fNS_upE fNS_upW fNS_upS
global fEW_upN fEW_upE fEW_upW fEW_upS
global n_ranN n_ranE n_ranW n_ranS

p1 = zeros(1,Tcy); p1(1:Tp1) = 1;
p2 = zeros(1,Tcy); p2(Tp1+1:Tb1) = 1;
p5 = zeros(1,Tcy); p5(1:Tp5) = 1;
p6 = zeros(1,Tcy); p6(Tp5+1:Tb1) = 1;

p3 = zeros(1,Tcy); p3(Tb1+1:Tb1+Tp3) = 1;
p4 = zeros(1,Tcy); p4(Tb1+Tp3+1:Tcy) = 1;
p7 = zeros(1,Tcy); p7(Tb1+1:Tb1+Tp7) = 1;
p8 = zeros(1,Tcy); p8(Tb1+Tp7+1:Tcy) = 1;

% Northern Incoming Link

nN = zeros(1,length(Tau));
nNp2 = zeros(1,length(Tau));
nNp5 = zeros(1,length(Tau));
fNp2 = zeros(1,length(Tau));
fNp5 = zeros(1,length(Tau));

nNp2(1) = NNp2Init;
nNp5(1) = NNp5Init;
nN(1) = nNp2(1) + nNp5(1);

for i = 1:length(Tau)-1
    
    t = Tau(i);
    
    [nN(i+1), nNp2(i+1), nNp5(i+1), fNp2(i), fNp5(i)] = North(t, p2, p5, nNp2(i), nNp5(i), ...
                    n_downE(PredictionCycle,i), n_downW(PredictionCycle,i), n_downS(PredictionCycle,i), ...
                    fNS_upN(PredictionCycle,i), fNS_upE(PredictionCycle,i), fNS_upW(PredictionCycle,i), n_ranN(Mode,i));

end

NNp2Green = nNp2(Tb1);
NNp2Red = nNp2(Tp1);
NNp2Final = nNp2(end);
NNp5Green = nNp5(Tp5);
NNp5Red = nNp5(end);
NNp5Final = nNp5(end);

% Southern Incoming Link

nS = zeros(1,length(Tau));
nSp1 = zeros(1,length(Tau));
nSp6 = zeros(1,length(Tau));
fSp1 = zeros(1,length(Tau));
fSp6 = zeros(1,length(Tau));

nSp1(1) = NSp1Init;
nSp6(1) = NSp6Init;
nS(1) = nSp1(1) + nSp6(1);

for i = 1:length(Tau)-1
    
    t = Tau(i);
    
    [nS(i+1), nSp1(i+1), nSp6(i+1), fSp1(i), fSp6(i)] = South(t, p1, p6, nSp1(i), nSp6(i), ...
                    n_downN(PredictionCycle,i), n_downE(PredictionCycle,i), n_downW(PredictionCycle,i), ...
                    fNS_upE(PredictionCycle,i), fNS_upW(PredictionCycle,i), fNS_upS(PredictionCycle,i), n_ranS(Mode,i));
    
end

NSp1Green = nSp1(Tp1);
NSp1Red = nSp1(end);
NSp1Final = nSp1(end);
NSp6Green = nSp6(Tb1);
NSp6Red = nSp6(Tp5);
NSp6Final = nSp6(end);

% Eastern Incoming Link

nE = zeros(1,length(Tau));
nEp4 = zeros(1,length(Tau));
nEp7 = zeros(1,length(Tau));
fEp4 = zeros(1,length(Tau));
fEp7 = zeros(1,length(Tau));

nEp4(1) = NEp4Init;
nEp7(1) = NEp7Init;
nE(1) = nEp4(1) + nEp7(1);

for i = 1:length(Tau)-1
    
    t = Tau(i);
    
    [nE(i+1), nEp4(i+1), nEp7(i+1), fEp4(i), fEp7(i)] = East(t, p4, p7, nEp4(i), nEp7(i), ...
                    n_downN(PredictionCycle,i), n_downW(PredictionCycle,i), n_downS(PredictionCycle,i), ...
                    fEW_upN(PredictionCycle,i), fEW_upE(PredictionCycle,i), fEW_upS(PredictionCycle,i), n_ranE(Mode,i));
    
end

NEp4Green = nEp4(end);
NEp4Red = nEp4(Tb1+Tp3);
NEp4Final = nEp4(end);
NEp7Green = nEp7(Tb1+Tp7);
NEp7Red = nEp7(Tb1);
NEp7Final = nEp7(end);

% Western Incoming Link

nW = zeros(1,length(Tau));
nWp3 = zeros(1,length(Tau));
nWp8 = zeros(1,length(Tau));
fWp3 = zeros(1,length(Tau));
fWp8 = zeros(1,length(Tau));

nWp3(1) = NWp3Init;
nWp8(1) = NWp8Init;
nW(1) = nWp3(1) + nWp8(1);

for i = 1:length(Tau)-1
    
    t = Tau(i);
    
    [nW(i+1), nWp3(i+1), nWp8(i+1), fWp3(i), fWp8(i)] = West(t, p3, p8, nWp3(i), nWp8(i), ...
                    n_downN(PredictionCycle,i), n_downE(PredictionCycle,i), n_downS(PredictionCycle,i), ...
                    fEW_upN(PredictionCycle,i), fEW_upW(PredictionCycle,i), fEW_upS(PredictionCycle,i), n_ranW(Mode,i));
    
end

NWp3Green = nWp3(Tb1+Tp3);
NWp3Red = nWp3(Tb1);
NWp3Final = nWp3(end);
NWp8Green = nWp8(end);
NWp8Red = nWp8(Tb1+Tp7);
NWp8Final = nWp8(end);

