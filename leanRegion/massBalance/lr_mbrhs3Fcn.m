function lr_mbrhs3 = lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, T_lp, Global, id1, id2)
% -------------------------------------------------------------------------
    %  lr_mbrhs1Fcn is a function that returns the right hand side of the
    %  mass balance equation for the lean region inside the fuel reactor.
    % ----------------------------| inlet |--------------------------------
    %   u_gs_lr   = gas|solid velocity in the lean region            [cm/s]
    %   Ci        = concentration of species i in the lean region [mol/cm3]
    %   Global    = constants structure
    % ----------------------------| outlet |-------------------------------
    %   lr_mbrhs1 = right-hand side term-1 [mol/cm3-s] [gSolid/g-carrier-s]
% -------------------------------------------------------------------------
 
    Dcat    = Global.carrier.bulkDensity;
    C_g_lp  = C_gs_lp.C_g;
    C_s_lp  = C_gs_lp.C_s;
    kinetic = kineticFcn(C_g_lp, C_s_lp, T_lp, Global, id2);

% -------------------------------------------------------------------------


    u_g0_lp    = superficialGasVelocityFreeboardFcn(C_gs_dp,Global);
    mu_lp_g_m  = viscosityGasMixFcn(Global,T_lp,C_g_lp);
    rho_lp_g_m = densityGasMixFcn(C_g_lp,T_lp,Global);
    u_t        = particleTerminalVelocityFcn(mu_lp_g_m,rho_lp_g_m,Global);
    G_sat      = saturatedFluxSolidsFcn(u_t, u_g0_lp, rho_lp_g_m);         % ================> revisar dimensiones 
    f_s        = freeboardSolidFractionFcn(u_g0_lp, G_sat, u_t, Global);
    E_lp       = 1 - f_s;



% -------------------------------------------------------------------------

    if     strcmp(id1,'g_lp')

        lr_mbrhs3 = (f_s.*kinetic.*Dcat)./(E_lp);
             
    elseif strcmp(id1,'s_lp')

        lr_mbrhs3 = kinetic;

    else

        disp('Error - Inconsistency - lr_mbrhs3Fcn.m')
        lr_mbrhs3 = 0;

    end
   % lr_mbrhs3 = lr_mbrhs3.*0;
% -------------------------------------------------------------------------
end