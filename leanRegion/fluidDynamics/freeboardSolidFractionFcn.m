function f_s = freeboardSolidFractionFcn(G_sat, rho_g, mu_g, u_t, Global)
% -------------------------------------------------------------------------

    z2    = Global.reactor.z2;
    z1    = Global.reactor.z1;
    H     = z2 - z1(end);
    rho_p = Global.carrier.rho_s;
    f_d   = Global.fDynamics.f_d;
    u_g0  = Global.fDynamics.usg0;

% -------------------------------------------------------------------------

  % f_ast  = G_sat./(u_g0.*rho_p);
  % f_exit = G_sat./(u_g0 - u_t).*rho_p;

    f_ast  = 0.01;
  % a = decayFactorFcn(u_g0, rho_g, mu_g, u_t, Global, 'mod_1');          
    a = decayFactorFcn(u_g0, rho_g, mu_g, u_t, Global, 'mod_5');
% -------------------------------------------------------------------------

    f_s = f_ast + (f_d - f_ast).*exp(-a.*H);

% -------------------------------------------------------------------------
end