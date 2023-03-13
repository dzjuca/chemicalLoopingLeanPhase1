function r_CH4m = r_CH4m_Fcn(PCO, PH2, T, R)
% -------------------------------------------------------------------------
    % r_CH4m_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]
    % KH2_m    =  kinetic constant                                [bar-0.5]
    % KCO_m    =  kinetic constant                                [bar-0.5]
    % k_CH4_m  =  kinetic constant                            [kmol/kgNi s]
    % ----------------------------| output |-------------------------------
    % r_CH4m   =  the reaction rate                           [kmol/kgNi s] 
% ------------------------------------------------------------------------- 
    k_CH4_m = 4.17e6*exp(-105000/(R*T));
    KCO_m   = 5.8e-4*exp( 42000/ (R*T));
    KH2_m   = 1.6e-2*exp( 16000/ (R*T));
% -------------------------------------------------------------------------
    tmp_1 = k_CH4_m*KCO_m*(KH2_m^(2))*(PCO^(0.5))*PH2;
    tmp_2 = (1 + KCO_m*(PCO^(0.5)) + KH2_m*(PH2^(0.5)))^3;
% -------------------------------------------------------------------------

    r_CH4m = tmp_1/tmp_2;

% -------------------------------------------------------------------------    
end