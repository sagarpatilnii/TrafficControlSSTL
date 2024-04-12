function [nn, nn_p4, nn_p7, f_p4, f_p7] = East(t, p4, p7, n_p4, n_p7, ...
                                               n_downN, n_downW, n_downS, f_upN, f_upE, f_upS, n_ranE)

% Eastern incoming link l -------------------------------------------------
n_cap = 100; % Capacity
f_p4_sat = 6; % Saturation flow
f_p7_sat = 3;

% l to Downstream ---------------------------------------------------------

% alpha_m_l Supply Ratio (fraction of capacity of m available to l)
alpha_downN = 1;
alpha_downW = 1;
alpha_downS = 1;

% beta_l_m Turn Ratio (fraction of vehicles exiting l that are routed to m)
% beta_downE + beta_downW + beta_downS = 1
beta_downN = 0.25;
beta_downW = 0.5;
beta_downS = 0.25;

% Capacities
n_downN_cap = 200;
n_downW_cap = 100;
n_downS_cap = 150;
                
% Upstream to l -----------------------------------------------------------

% beta_m_l Turn Ratio (fraction of vehicles exiting m that are routed to l)
beta_upN = 0.6;
beta_upE = 0.8;
beta_upS = 0.6;

% Traffic Model -----------------------------------------------------------

% Outflow
if p4(t) == 1
    temp_outflow = min([(alpha_downW * (n_downW_cap - n_downW) / beta_downW), ...
                        (alpha_downN * (n_downN_cap - n_downN) / beta_downN)]);
    f_p4 = min([n_p4, f_p4_sat, temp_outflow]);
    if f_p4 < 0
        f_p4 = 0;
    end
else
    f_p4 = 0;
end

if p7(t)== 1
    temp_outflow = (alpha_downS * (n_downS_cap - n_downS) / beta_downS);
    f_p7 = min([n_p7, f_p7_sat, temp_outflow]);
    if f_p7 < 0
        f_p7 = 0;
    end
else
    f_p7 = 0;
end

% Number of Vehicles (state)
temp_number = ((beta_upN * f_upN) + (beta_upE * f_upE) + (beta_upS * f_upS));
nn_p4 = round(min([(beta_downW+beta_downN)*n_cap, n_p4 - f_p4 + (beta_downW+beta_downN)*temp_number + (beta_downW+beta_downN)*n_ranE]));
nn_p7 = round(min([beta_downS*n_cap, n_p7 - f_p7 + beta_downS*temp_number + beta_downS*n_ranE]));

if nn_p4 < 0
    nn_p4 = 0;
end
if nn_p7 < 0
    nn_p7 = 0;
end

nn = nn_p4 + nn_p7;

