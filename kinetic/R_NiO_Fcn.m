function R_NiO = R_NiO_Fcn(C_gas, C_solid, T, data)
% -------------------------------------------------------------------------
    % R_NiO_Fcn is a function that calculates the reaction rate for NiO
    % ----------------------------| input |--------------------------------
    % a0 = initial specific surface area of the O2 carrier   [m2/kgCarrier]
    %  X = NiO conversion                                                []
    %  T = temperature of the system                                    [K]
    %  R = Universal Gas Constant                                  [J/molK]

    % ----------------------------| output |-------------------------------
    % R_NiO    =  the reaction rate                            [gNiO/g-c s]
% -------------------------------------------------------------------------

    R       = data.R; 
    a0      = data.a0; 
    C_NiO_o = data.C_NiO_o;

    C_CH4 = C_gas(1);
    C_CO  = C_gas(3);
    C_H2  = C_gas(4);

    C_NiO = C_solid(1);
    C_Ni  = C_solid(2);

% ------------------------------------------------------------------------- 

    k_s1 = 100*(4.66*exp(-77416/(R*T)));
    k_s2 = 100*(1.31e-4*exp(-26413/(R*T)));
    k_s3 = 100*(1.097e-4*exp(-26505/(R*T)));
    k_s4 = 100*(4.18e-3*exp (-23666/(R*T)));
% ------------------------------------------------------------------------- 

    X = conversionFcn(C_NiO, C_NiO_o);

% ------------------------------------------------------------------------- 

    tmp_1 = (2*k_s1 + k_s4)*C_CH4*C_Ni + k_s2*C_H2 + k_s3*C_CO;

    R_NiO_1 = -a0*(1 - X)*tmp_1*C_NiO;                      %[molNiO/g-c s]
    %R_NiO   = R_NiO_1*74.68;                                  %[gNiO/g-c s]
     R_NiO   = R_NiO_1*1; 
% ------------------------------------------------------------------------- 
end

