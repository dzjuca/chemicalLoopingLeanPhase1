function r_WGS = r_WGS_Fcn(PCO2, PH2, PCO, PH2O, T, R)
% -------------------------------------------------------------------------
    % r_WGS_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]

    % KCO_rf_H2O  =  kinetic constant                               [bar-1]
    % KH2_rf_H2O  =  kinetic constant                             [bar-0.5]
    % KH2O_rf_H2O =  kinetic constant                                    []

    % Kp_WGS      =  kinetic constant                                    []
    % k_WGS       =  kinetic constant                     [kmol/kgNi s bar]
    % ----------------------------| output |-------------------------------
    %   r_WGS = the reaction rate                             [kmol/kgNi s] 
% -------------------------------------------------------------------------
    k_WGS       = 3.8e-2  *exp(-15400/(R*T));
    Kp_WGS      = 1.77e-2 *exp(4400/  (R*T)); %==============> Quitar R en la exp 
    KCO_rf_H2O  = 5.18e-11*exp(140000/(R*T));
    KH2_rf_H2O  = 5.7e-9  *exp(93400/ (R*T));
    KH2O_rf_H2O = 9.25    *exp(-15900/(R*T));
% -------------------------------------------------------------------------
    tmp_1 = k_WGS*PCO*(PH2O^(0.5));
    tmp_2 = (PH2^(0.5));
    tmp_3 = tmp_1/tmp_2;
    if tmp_2 == 0, tmp_3 = 0; end
% -------------------------------------------------------------------------
    tmp_4 = PCO2*PH2; % ========> cambiar PCO2 por PCO (Revisar)
    tmp_5 = Kp_WGS*PCO*PH2O;
    tmp_6 = tmp_4/tmp_5;
    if tmp_5 == 0, tmp_6 = 0; end
    tmp_7 = 1 - tmp_6;
% -------------------------------------------------------------------------
    tmp_8 = KCO_rf_H2O*PCO;
    tmp_9 = KH2_rf_H2O*(PH2^(0.5));
    tmp_10 = KH2O_rf_H2O*PH2O/PH2;
    if PH2 == 0, tmp_10 = 0; end
    tmp_11 = (1 + tmp_8 + tmp_9 + tmp_10)^2;
% -------------------------------------------------------------------------

    r_WGS = (tmp_3*tmp_7)/tmp_11;

% -------------------------------------------------------------------------
end