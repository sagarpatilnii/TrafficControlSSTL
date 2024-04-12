function rho = SSTLPhi2(N_downN, N_downW, Tp3)

PredictionHorizon = length(N_downN);

RHO = zeros(1,PredictionHorizon);

for i = 1:PredictionHorizon
   
    if N_downN(i) > 59 || N_downW(i) > 33
      
        if Tp3(i) > 15 && Tp3(i) <= 20
            RHO(i) = 1;
        end
        
    else
        
        RHO(i) = 1;
        
    end
    
end

rho = min(RHO);