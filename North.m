function [nn, nn_p2, nn_p5, f_p2, f_p5] = North(t, p2, p5, n_p2, n_p5, ...
                                                n_downE, n_downW, n_downS, f_upN, f_upE, f_upW, n_ranN)

% Northern incoming link l ------------------------------------------------
n_cap = 200; % Capacity
f_p5_sat = 3; % Saturation flow
f_p2_sat = 6;

% l to Downstream ---------------------------------------------------------

% alpha_m_l Supply Ratio (fraction of capacity of m available to l)
alpha_downE = 1;
alpha_downW = 1;
alpha_downS = 1;

% beta_l_m Turn Ratio (fraction of vehicles exiting l that are routed to m)
% beta_downE + beta_downW + beta_downS = 1
beta_downE = 0.25;
beta_downW = 0.25;
beta_downS = 0.5;

% Capacities
n_downE_cap = 75;
n_downW_cap = 75;
n_downS_cap = 150;
                
% Upstream to l -----------------------------------------------------------

% beta_m_l Turn Ratio (fraction of vehicles exiting m that are routed to l)
beta_upN = 0.8;
beta_upE = 0.6;
beta_upW = 0.6;

% Traffic Model -----------------------------------------------------------

% Outflow
if p2(t) == 1
    temp_outflow = min([(alpha_downW * (n_downW_cap - n_downW) / beta_downW), ...
                        (alpha_downS * (n_downS_cap - n_downS) / beta_downS)]);
    f_p2 = min([n_p2, f_p2_sat, temp_outflow]);
    if f_p2 < 0
        f_p2 = 0;
    end
else
    f_p2 = 0;
end

if p5(t) == 1
    temp_outflow = (alpha_downE * (n_downE_cap - n_downE) / beta_downE);
    f_p5 = min([n_p5, f_p5_sat, temp_outflow]);
    if f_p5 < 0
        f_p5 = 0;
    end
else
    f_p5 = 0;
end

% Number of Vehicles (state)
temp_number = ((beta_upN * f_upN) + (beta_upE * f_upE) + (beta_upW * f_upW));
nn_p2 = round(min([(beta_downW+beta_downS)*n_cap, n_p2 - f_p2 + (beta_downW+beta_downS)*temp_number + (beta_downW+beta_downS)*n_ranN]));
nn_p5 = round(min([beta_downE*n_cap, n_p5 - f_p5 + beta_downE*temp_number + beta_downE*n_ranN]));

if nn_p2 < 0
    nn_p2 = 0;
end
if nn_p5 < 0
    nn_p5 = 0;
end

nn = nn_p2 + nn_p5;

