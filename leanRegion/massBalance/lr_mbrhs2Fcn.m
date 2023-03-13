function lr_mbrhs2 =  lr_mbrhs2Fcn(Ci, Global)
% -------------------------------------------------------------------------
    %  lr_mbrhs2Fcn is a function that returns the 2-right hand side of the
    %  mass balance equation for the lean region inside the fuel reactor.
    % ----------------------------| inlet |--------------------------------
    %   Ci        = concentration of species i in the lean region [mol/cm3]
    %   Global    = constants structure
    % --------
    %   Ef_f      = freeboard porosity                                   []
    %   D_ax      = axial dispersion coefficient                    [cm2/s]
    % ----------------------------| outlet |-------------------------------
    %   lr_mbrhs2 = right-hand side term-1 [mol/cm3-s] [gSolid/g-carrier-s]
% -------------------------------------------------------------------------

    z2 = Global.reactor.z2;  
    xl = z2(1);
    xu = z2(end);
    n2 = Global.n2;

% -------------------------------------------------------------------------

    D_ax      = axialDispersionCoefficientFcn();
    dCi_dz    = dss012(xl,xu,n2,Ci, 1);
    tmp_1     = D_ax.*dCi_dz;
      lr_mbrhs2 = dss012(xl,xu,n2,tmp_1, 1);
%        lr_mbrhs2 = dss012(xl,xu,n2,tmp_1, 1).*0;

% -------------------------------------------------------------------------
end
