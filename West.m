function [nn, nn_p3, nn_p8, f_p3, f_p8] = West(t, p3, p8, n_p3, n_p8, ...
                                               n_downN, n_downE, n_downS, f_upN, f_upW, f_upS, n_ranW)

% Western incoming link l ------------------------------------------------
n_cap = 100; % Capacity
f_p3_sat = 3; % Saturation flow
f_p8_sat = 6;

% l to Downstream ---------------------------------------------------------

% alpha_m_l Supply Ratio (fraction of capacity of m available to l)
alpha_downN = 1;
alpha_downE = 1;
alpha_downS = 1;

% beta_l_m Turn Ratio (fraction of vehicles exiting l that are routed to m)
% beta_downE + beta_downW + beta_downS = 1
beta_downN = 0.25;
beta_downE = 0.5;
beta_downS = 0.25;

% Capacities
n_downN_cap = 200;
n_downE_cap = 100;
n_downS_cap = 150;
                
% Upstream to l -----------------------------------------------------------

% beta_m_l Turn Ratio (fraction of vehicles exiting m that are routed to l)
beta_upN = 0.6;
beta_upW = 0.8;
beta_upS = 0.6;

% Traffic Model -----------------------------------------------------------

% Outflow
if p3(t) == 1
    temp_outflow = (alpha_downN * (n_downN_cap - n_downN) / beta_downN);
    f_p3 = min([n_p3, f_p3_sat, temp_outflow]);
    if f_p3 < 0
        f_p3 = 0;
    end
else
    f_p3 = 0;
end

if p8(t) == 1
    temp_outflow = min([(alpha_downE * (n_downE_cap - n_downE) / beta_downE), ...
                        (alpha_downS * (n_downS_cap - n_downS) / beta_downS)]);
    f_p8 = min([n_p8, f_p8_sat, temp_outflow]);
    if f_p8 < 0
        f_p8 = 0;
    end
else
    f_p8 = 0;
end

% Number of Vehicles (state)
temp_number = ((beta_upN * f_upN) + (beta_upS * f_upS) + (beta_upW * f_upW));
nn_p3 = round(min([beta_downN*n_cap, n_p3 - f_p3 + beta_downN*temp_number + beta_downN*n_ranW]));
nn_p8 = round(min([(beta_downE+beta_downS)*n_cap, n_p8 - f_p8 + (beta_downE+beta_downS)*temp_number + (beta_downE+beta_downS)*n_ranW]));

if nn_p3 < 0
    nn_p3 = 0;
end
if nn_p8 < 0
    nn_p8 = 0;
end

nn = nn_p3 + nn_p8;

