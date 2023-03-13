function ad = ad_fractionFcn(u_g0_lp, u_t, Global)

    dp = Global.carrier.dp/100; % m
    D  = Global.reactor.rID/100;% m
    u_g0_lp = u_g0_lp./100; %m
    u_t = u_t./100; % m

    ad = (3.5 - 1670.*dp)./(((u_g0_lp - u_t ).^2).*(D.^(0.6)));
end