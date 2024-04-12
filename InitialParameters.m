global Tcy Tb1 NoSignalCycles tau Tau
global N_ranNlb N_ranNub N_ranElb N_ranEub N_ranWlb N_ranWub N_ranSlb N_ranSub
global MSG_ICA MSG_EVA

Tcy = 60;
Tb1 = 35;
NoSignalCycles = 60;

tau = 1;
Tau = 1:tau:Tcy;

N_ranNlb = 11;
N_ranNub = 23;
N_ranElb = 3;
N_ranEub = 11;
N_ranWlb = 3;
N_ranWub = 11;
N_ranSlb = 4;
N_ranSub = 15;

MSG_ICA = string(zeros(2,NoSignalCycles)); % Approach, Lane(Phase), Event
MSG_ICA(:,8) = ["North" "Disabled"];

MSG_EVA = string(zeros(2,NoSignalCycles)); % Siren, Response type
MSG_EVA(:,35) = ["InUse" "Emergency"];

% SSTL Phi 1 Parameters

global NNp2GreenLimit NNp5GreenLimit NSp1GreenLimit NSp6GreenLimit

NNp2GreenLimit = 8; %5; %7;

NNp5GreenLimit = 8; %6; %5;

NSp1GreenLimit = 8; %6; %5;

NSp6GreenLimit = 8; %5; %7;