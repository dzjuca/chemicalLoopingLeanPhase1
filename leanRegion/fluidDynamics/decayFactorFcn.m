function a = decayFactorFcn(u_g0, rho_g, mu_g, u_t, Global, id)

    if strcmp(id,'mod_1')
        a_u0 = Global.fDynamics.a_u0;
        a    = a_u0./u_g0;

    elseif strcmp(id,'mod_2')
        dp    = Global.carrier.dp/100; % m
        D     = Global.reactor.rID/100;% m
        u_g0  = u_g0./100; %m
        u_t   = u_t./100; % m
        a_3_m = (3.5 - 1670.*dp)./(((u_g0 - u_t ).^2).*(D.^(0.6)));
        a     = a_3_m./100;

    elseif strcmp(id,'mod_3')
        dp    = Global.carrier.dp/100; % m
        D     = Global.reactor.rID/100;% m
        u_g0  = u_g0./100; %m
        u_t   = u_t./100; % m
        a_4_m = (0.88 - 420.*dp)./(((u_g0 - u_t ).^2).*(D.^(0.6)));
        a     = a_4_m./100;
    
    elseif strcmp(id,'mod_4')
        K     = 8.6;
        D     = Global.reactor.rID/100;% m
        u_g0  = u_g0./100; %m
        u_t   = u_t./100; % m
        a_5_m = K./(((u_g0 - u_t ).^2).*(D.^(0.6)));
        a     = a_5_m./100;

    elseif strcmp(id,'mod_5')
        
        dp    = Global.carrier.dp;
        rho_s = Global.carrier.rho_s;
        g     = Global.g;

        Ar  = ((dp.^3).*rho_g.*(rho_s - rho_g).*g)./(mu_g.^2);
        a_m = 1 + 0.5.*(Ar.^(1/3));
        a   = a_m./100;

    end


end