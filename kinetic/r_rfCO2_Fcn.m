function r_rfCO2 = r_rfCO2_Fcn(PCH4, PCO2, T, R)
 % -------------------------------------------------------------------------
    % r_rfCO2_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]
    % KCO2_rf_CO2   =  kinetic constant                             [bar-1]
    % k_rf_CO2      =  kinetic constant                  [kmol/kgNi s bar2]
    % ----------------------------| output |-------------------------------
    % r_rfCO2       =  the reaction rate                      [kmol/kgNi s] 
% -------------------------------------------------------------------------
    k_rf_CO2    = 0.207 *exp(-9920/(R*T));
    KCO2_rf_CO2 = 2.4e-3*exp(77500/(R*T));
% -------------------------------------------------------------------------
    tmp_1 = k_rf_CO2*PCH4*PCO2;
    tmp_2 = 1 + KCO2_rf_CO2*PCO2;
% -------------------------------------------------------------------------

    r_rfCO2 = tmp_1/tmp_2;

% -------------------------------------------------------------------------
end