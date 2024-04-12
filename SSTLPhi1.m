function rho = SSTLPhi1(NNp2Green, NNp5Green, ...
                               NSp1Green, NSp6Green, lambda)

global NNp2GreenLimit NNp5GreenLimit NSp1GreenLimit NSp6GreenLimit

rhop2 = min(NNp2GreenLimit - NNp2Green) + lambda;

rhop5 = min(NNp5GreenLimit - NNp5Green) + lambda;

rhop1 = min(NSp1GreenLimit - NSp1Green) + lambda;

rhop6 = min(NSp6GreenLimit - NSp6Green) + lambda;

rho = min([rhop2, rhop5, rhop1, rhop6]);

