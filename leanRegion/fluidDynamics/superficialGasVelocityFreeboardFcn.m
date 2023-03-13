function u_g0_lp = superficialGasVelocityFreeboardFcn(C_gs_dp, Global)
% -------------------------------------------------------------------------


    Emf = Global.fDynamics.Emf;
    fw  = Global.fDynamics.fw;
    A   = Global.reactor.rArea1; 
    n1  = Global.n1;

% -------------------------------------------------------------------------

    [ub,db,us,ue,alpha]= ubFcn(Global);

    C_gb_dp_i = C_gs_dp.C_g_b;
    C_ge_dp_i = C_gs_dp.C_g_e;

    F_gb_dp_i = C_gb_dp_i.*ub.*A.*(alpha + alpha.*fw.*Emf);
    F_ge_dp_i = C_ge_dp_i.*ue.*A.*(1 - alpha - alpha.*fw).*Emf;
    F_g_dp_i  = F_gb_dp_i + F_ge_dp_i;
    Q_g_dp_i  = sum(F_g_dp_i,2).*22.4.*1000;

    u_g0_i    = Q_g_dp_i./A;
% -------------------------------------------------------------------------

    u_g0_lp   = u_g0_i(n1);

% -------------------------------------------------------------------------
end