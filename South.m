function [nn, nn_p1, nn_p6, f_p1, f_p6] = South(t, p1, p6, n_p1, n_p6, ...
                                                n_downN, n_downE, n_downW, f_upE, f_upW, f_upS, n_ranS)

% Southern incoming link l ------------------------------------------------
n_cap = 150; % Capacity
f_p1_sat = 3; % Saturation flow
f_p6_sat = 6;

% l to Downstream ---------------------------------------------------------

% alpha_m_l Supply Ratio (fraction of capacity of m available to l)
alpha_downN = 1;
alpha_downE = 1;
alpha_downW = 1;

% beta_l_m Turn Ratio (fraction of vehicles exiting l that are routed to m)
% beta_downE + beta_downW + beta_downS = 1
beta_downN = 0.5;
beta_downE = 0.25;
beta_downW = 0.25;

% Capacities
n_downN_cap = 200;
n_downE_cap = 75;
n_downW_cap = 75;
                
% Upstream to l -----------------------------------------------------------

% beta_m_l Turn Ratio (fraction of vehicles exiting m that are routed to l)
beta_upE = 0.6;
beta_upW = 0.6;
beta_upS = 0.8;

% Traffic Model -----------------------------------------------------------

% Outflow
if p1(t) == 1
    temp_outflow = (alpha_downW * (n_downW_cap - n_downW) / beta_downW);
    f_p1 = min([n_p1, f_p1_sat, temp_outflow]);
    if f_p1 < 0
        f_p1 = 0;
    end
else
    f_p1 = 0;
end

if p6(t) == 1
    temp_outflow = min([(alpha_downE * (n_downE_cap - n_downE) / beta_downE), ...
                        (alpha_downN * (n_downN_cap - n_downN) / beta_downN)]);
    f_p6 = min([n_p6, f_p6_sat, temp_outflow]);
    if f_p6 < 0
        f_p6 = 0;
    end
else
    f_p6 = 0;
end

% Number of Vehicles (state)
temp_number = ((beta_upS * f_upS) + (beta_upE * f_upE) + (beta_upW * f_upW));
nn_p1 = round(min([beta_downW*n_cap, n_p1 - f_p1 + beta_downW*temp_number + beta_downW*n_ranS]));
nn_p6 = round(min([(beta_downN+beta_downE)*n_cap, n_p6 - f_p6 + (beta_downN+beta_downE)*temp_number + (beta_downN+beta_downE)*n_ranS]));

if nn_p1 < 0
    nn_p1 = 0;
end
if nn_p6 < 0
    nn_p6 = 0;
end

nn = nn_p1 + nn_p6;

