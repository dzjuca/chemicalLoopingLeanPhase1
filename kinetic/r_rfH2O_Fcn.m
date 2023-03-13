function r_rfH2O = r_rfH2O_Fcn(PCH4, PH2O, PH2, PCO, T, R)
% -------------------------------------------------------------------------
    % r_rfH2O_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]
    % KCO_rf_H2O  =  kinetic constant                               [bar-1]
    % KH2_rf_H2O  =  kinetic constant                             [bar-0.5]
    % KH2O_rf_H2O =  kinetic constant                                    []
    % Kp_rf_H2O   =  kinetic constant                                [bar2]
    % k_rf_H2O    =  kinetic constant                 [kmol/kgNi s bar0.25]
    % ----------------------------| output |-------------------------------
    %   r_rfH2O = the reaction rate                           [kmol/kgNi s] 
% ----------------------------| constants |--------------------------------
    KCO_rf_H2O  = 5.18e-11*exp(140000/(R*T));
    KH2_rf_H2O  = 5.7e-9*exp(93400/(R*T));
    KH2O_rf_H2O = 9.25*exp(-15900/(R*T));
    Kp_rf_H2O   = 1.17e13*exp(-26830/(R*T)); %==============> Quitar R en la exp
    k_rf_H2O    = 6.237e6*exp(-209000/(R*T));
% -------------------------------------------------------------------------
    tmp_1 = k_rf_H2O*PCH4*(PH2O^(0.5));
    tmp_2 = PH2^(1.25);
    tmp_3 = tmp_1/tmp_2;
    if tmp_2 == 0, tmp_3 = 0; end
    % ---------------------------------------------------------------------

    tmp_4 = PCO*(PH2^3);
    tmp_5 = Kp_rf_H2O*PCH4*PH2O;
    tmp_6 = tmp_4/tmp_5;
    if tmp_5 == 0, tmp_6 = 0; end
    tmp_7 = 1 - tmp_6;
    % ---------------------------------------------------------------------

    tmp_8 = KCO_rf_H2O*PCO;
    tmp_9 = KH2_rf_H2O*(PH2^(0.5));
    tmp_10 = PH2O/PH2;
    if PH2 == 0, tmp_10 = 0; end

    tmp_11 = KH2O_rf_H2O*tmp_10;
    tmp_12 = (1 + tmp_8 + tmp_9 + tmp_11)^2;
    % ---------------------------------------------------------------------
    r_rfH2O = (tmp_3*tmp_7)/tmp_12;
% -------------------------------------------------------------------------
end
