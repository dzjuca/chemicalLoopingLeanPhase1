function R_H2O = R_H2O_Fcn(C_gas, C_solid, PPT, T, data)
% -------------------------------------------------------------------------
    % R_H2O_Fcn is a function that calculates the reaction rate for H2O
    % ----------------------------| input |--------------------------------
    % a0 = initial specific surface area of the O2 carrier   [m2/kgCarrier]
    %  X = NiO conversion                                                []
    %  T = temperature of the system                                    [K]
    %  R = Universal Gas Constant                                  [J/molK]

    % ----------------------------| output |-------------------------------
    % R_H2    =  the reaction rate                           [kmol/kgNi s]
% -------------------------------------------------------------------------

    R       = data.R; 
    a0      = data.a0; 
    C_NiO_o = data.C_NiO_o;

    PCH4 = PPT(1);
    PCO2 = PPT(2);
    PCO  = PPT(3);
    PH2  = PPT(4);
    PH2O = PPT(5);

    C_H2  = C_gas(4);

    C_NiO = C_solid(1);
    C_Ni  = C_solid(2);

% ------------------------------------------------------------------------- 

    k_s2 = 100*(1.31e-4*exp(-26413/(R*T)));

% ------------------------------------------------------------------------- 

    X = conversionFcn(C_NiO, C_NiO_o);

% ------------------------------------------------------------------------- 

    r_rf_H2O = r_rfH2O_Fcn(PCH4, PH2O, PH2, PCO, T, R);
    r_WGS    = r_WGS_Fcn(PCO2, PH2, PCO, PH2O, T, R);
    r_g_H2O  = r_gH2O_Fcn(PCH4, PH2O, PCO, PH2, T, R);
    r_CH4_m  = r_CH4m_Fcn(PCO, PH2, T, R);

% -------------------------------------------------------------------------

    tmp_1 = k_s2*C_H2*C_NiO/C_Ni;
    if C_Ni == 0, tmp_1 = 0; end

      R_H2O = (a0*(1 - X)*tmp_1 - r_rf_H2O - r_WGS + r_CH4_m - r_g_H2O)*C_Ni;
    % R_H2O = (a0*(1 - X)*tmp_1 - r_rf_H2O - r_WGS - r_g_H2O)*C_Ni;

% -------------------------------------------------------------------------
end
