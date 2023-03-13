function lr_mbrhs1 = lr_mbrhs1Fcn(Ci, C_gs_dp, C_gs_lp, T, Global, id)
% -------------------------------------------------------------------------
    %  lr_mbrhs1Fcn is a function that returns the right hand side of the
    %  mass balance equation for the lean region inside the fuel reactor.
    % ----------------------------| inlet |--------------------------------
    %   Ci    = concentration of species i in the lean region    
    %                                          [mol/cm3]|[gSolid/g-carrier]
    % C_gs_dp = struct concentration species in the dense phase 
    %                                          [mol/cm3]|[gSolid/g-carrier]
    % C_gs_lp = struct concentration species in the lean phase  
    %                                          [mol/cm3]|[gSolid/g-carrier]
    % Global  = constants structure
    % ----------------------------| outlet |-------------------------------
    % lr_mbrhs1 = right-hand side term-1   [mol/cm3-s]|[gSolid/g-carrier-s]
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

%     xx = Ci > 10;
%     yy = unique(xx);
%     mm = length(yy);
% 
%     if (mm == 2)
% 
%         pause(10)
% 
%     end



% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

     z2     = Global.reactor.z2;  
     xl     = z2(1);
     xu     = z2(end);
     n      = Global.n2;
     C_g_lp = C_gs_lp.C_g;
    
% -------------------------------------------------------------------------

    u_g0_lp    = superficialGasVelocityFreeboardFcn(C_gs_dp,Global);
    mu_lp_g_m  = viscosityGasMixFcn(Global,T,C_g_lp);
    rho_lp_g_m = densityGasMixFcn(C_g_lp,T,Global);
    u_t        = particleTerminalVelocityFcn(mu_lp_g_m,rho_lp_g_m,Global);
    G_sat      = saturatedFluxSolidsFcn(u_t, u_g0_lp, rho_lp_g_m);         % ================> revisar dimensiones 
    f_s        = freeboardSolidFractionFcn(u_g0_lp, G_sat, u_t, Global);
    E_lp       = 1 - f_s;

    if strcmp(id,'g_lp')

%         u_gs_lp = u_g0_lp./E_lp;
        u_gs_lp = u_g0_lp;

    elseif strcmp(id,'s_lp')

%         u_gs_lp = solidVelocityFcn(Global);
        u_gs_lp = u_g0_lp;

    end
    
% -------------------------------------------------------------------------

    dCi_dz    = dss012(xl,xu,n,Ci, 1);
     lr_mbrhs1 = u_gs_lp.*dCi_dz;
%       lr_mbrhs1 = u_gs_lp.*dCi_dz.*0;

% -------------------------------------------------------------------------
end