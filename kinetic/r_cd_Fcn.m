function r_cd = r_cd_Fcn(PCH4, PH2, T, R)
% -------------------------------------------------------------------------
    % r_cd_Fcn is a function that calculates the reaction rate of ...
    % ----------------------------| input |--------------------------------
    % T = temperature of the system                                     [K]
    % R = Universal Gas Constant                                   [J/molK]
    % Kr_cd    = kinetic constant                                 [bar 3/2]
    % KCH4_cd  =  kinetic constant                                  [bar-1]
    % Kp_cd    =  kinetic constant                                       []
    % k_cd     =  kinetic constant                           [kmolC/kgNi s]
    % ----------------------------| output |-------------------------------
    % r_cd     =  the reaction rate                          [kmolC/kgNi s]
% ------------------------------------------------------------------------- 
    k_cd    = 43.4*exp(-58900/(R*T));
    Kp_cd   = 1*exp(104/(R))*1*exp(-88400/(R*T)); % ==========> NO MUY CLARO ESTE MODELO
    KCH4_cd = 2.1e-6*exp(78000/(R*T));
    Kr_cd   = 5.18e7*exp(-133000/(R*T));
% -------------------------------------------------------------------------
    tmp_1 = (PH2^(2))/Kp_cd;
    if Kp_cd == 0, tmp_1 = 0; end
    tmp_2 = k_cd*KCH4_cd*(PCH4 - tmp_1);
% -------------------------------------------------------------------------
    tmp_3 = 1/Kr_cd;
    if Kr_cd == 0, tmp_3 = 0; end
    tmp_4 = (1 + tmp_3*(PH2^(3/2)) + KCH4_cd*PCH4)^2;
% -------------------------------------------------------------------------

    r_cd  = tmp_2/tmp_4;

% -------------------------------------------------------------------------
end
