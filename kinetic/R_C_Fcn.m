function R_C = R_C_Fcn(C_solid, PPT, T, data)
% -------------------------------------------------------------------------
    % R_C_Fcn is a function that calculates the reaction rate for C
    % ----------------------------| input |--------------------------------
    %  T = temperature of the system                                    [K]
    % ----------------------------| output |-------------------------------
    % R_C    =  the reaction rate                          [kmolNi/kgNi s]
% -------------------------------------------------------------------------

    R    = data.R; 

    PCH4 = PPT(1);
    PCO2 = PPT(2);
    PCO  = PPT(3);
    PH2  = PPT(4);
    PH2O = PPT(5);

    C_Ni  = C_solid(2);

    r_cd     = r_cd_Fcn(PCH4, PH2, T, R);
    r_g_CO2  = r_gCO2_Fcn(PCO2, PCO, T, R);
    r_g_H2O  = r_gH2O_Fcn(PCH4, PH2O, PCO, PH2, T, R);
    
% -------------------------------------------------------------------------

    R_C_1 = (r_cd - r_g_CO2 - r_g_H2O)*C_Ni;        %          [molC/g-c s]
    %R_C   = R_C_1*12;                               %            [gC/g-c s]
    R_C   = R_C_1*1;

% -------------------------------------------------------------------------
end
