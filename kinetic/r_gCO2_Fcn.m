function r_gCO2 = r_gCO2_Fcn(PCO2, PCO, T, R)
% -------------------------------------------------------------------------
    % r_gCO2_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]
    % k_g_CO2    =  kinetic constant                         [kmolC/kgNi s]
    % KCO_g_CO2 =  kinetic constant                                 [bar-1]
    % KCO2_g_CO2 =  kinetic constant                                  [bar]
    % Kp_g_CO2   =  equilibrium constant                                 []
    % ----------------------------| output |-------------------------------
    % r_gCO2     =  the reaction rate                        [kmolC/kgNi s] 
% -------------------------------------------------------------------------

    k_g_CO2     = 8.37e10*exp(-312000/(R*T));
    KCO_g_CO2   = 37.8e-6*exp(100000/(R*T));
    KCO2_g_CO2  = 8.17e7*exp(-104000/(R*T));
    Kp_g_CO2    = 1*exp(178/R)*1*exp(-169000/(R*T));
    
% -------------------------------------------------------------------------
    tmp_1 = PCO2/Kp_g_CO2;
    if Kp_g_CO2 == 0, tmp_1 = 0; end

    tmp_2 = PCO2/PCO;
    if PCO == 0, tmp_2 = 0; end
    
    tmp_3 = KCO2_g_CO2*KCO_g_CO2;
    tmp_4 = k_g_CO2/tmp_3;
    if tmp_3 == 0, tmp_4 = 0; end

    tmp_5 = tmp_4*(tmp_2 - tmp_1);

% -------------------------------------------------------------------------

    tmp_6 = KCO_g_CO2*PCO;
    tmp_7 = tmp_2/tmp_3;
    if tmp_3 == 0, tmp_7 = 0; end
    tmp_8 = (1 + tmp_6 + tmp_7)^2;

% -------------------------------------------------------------------------

    r_gCO2 = tmp_5/tmp_8;

% -------------------------------------------------------------------------
end
