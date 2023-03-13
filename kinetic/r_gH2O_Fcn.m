function r_gH2O = r_gH2O_Fcn(PCH4, PH2O, PCO, PH2, T, R)
% -------------------------------------------------------------------------
    % r_gH2O_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]
    % Kp_g_H2O   =  equilibrium constant                                 []
    % Kr_g_H2O   =  kinetic constant                                     []
    % KCH4_g_H2O =  kinetic constant                                [bar-1]
    % KH2O_g_H2O =  kinetic constant                                    [ ]
    % k_g_H2O    =  kinetic constant                         [kmolC/kgNi s]
    % ----------------------------| output |-------------------------------
    % r_gH2O   =  the reaction rate                          [kmolC/kgNi s] 
% ------------------------------------------------------------------------- 
    k_g_H2O    = 3.08e4*exp(-166000/(R*T));
    KH2O_g_H2O = 4.73e-6*exp(97700/(R*T));
    KCH4_g_H2O = 3.49;
    Kr_g_H2O   = 1.83e13*exp(-216000/(R*T));
    Kp_g_H2O   = 1*exp(137/R)*1*exp(-126000/(R*T));
% -------------------------------------------------------------------------
    tmp_1 = PCO/Kp_g_H2O;
    if Kp_g_H2O == 0, tmp_1 = 0; end
    tmp_2 = PH2O/PH2;
    if PH2 == 0, tmp_2 = 0; end
    tmp_3 = k_g_H2O/KH2O_g_H2O;
    if KH2O_g_H2O == 0, tmp_3 = 0; end
    tmp_4 = tmp_3*(tmp_2 - tmp_1);
% -------------------------------------------------------------------------
    tmp_5 = KCH4_g_H2O*PCH4;
    tmp_6 = tmp_2/KH2O_g_H2O;
    if KH2O_g_H2O == 0, tmp_6 = 0; end
    tmp_7 = (PH2^(3/2))/Kr_g_H2O;
    if Kr_g_H2O == 0, tmp_7 = 0; end
    tmp_8 = (1 + tmp_5 + tmp_6 + tmp_7)^2;
% -------------------------------------------------------------------------

    r_gH2O = tmp_4/tmp_8;

% -------------------------------------------------------------------------
end
