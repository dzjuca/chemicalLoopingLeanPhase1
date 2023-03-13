function f_s = freeboardSolidFractionFcn(u_g0_lp, G_sat, u_t, Global)
% -------------------------------------------------------------------------

    z2    = Global.reactor.z2;
    z1    = Global.reactor.z1;
    a_u0  = 7; % s-1
    rho_p = Global.carrier.bulkDensity;
    f_d   = 0.3;
% -------------------------------------------------------------------------

    f_asterisk = G_sat./(u_g0_lp.*rho_p);
    f_exit     = G_sat./(u_g0_lp - u_t).*rho_p;
  % a   = a_u0./u_g0_lp;
    a = (1/z2(end))*log((f_d - f_asterisk(end))/(f_exit(end) - f_asterisk(end))); % ============> revisar este es solo un remiendo

% -------------------------------------------------------------------------

    f_s = f_asterisk + (f_d - f_asterisk).*exp(-a.*z2);

% -------------------------------------------------------------------------
end