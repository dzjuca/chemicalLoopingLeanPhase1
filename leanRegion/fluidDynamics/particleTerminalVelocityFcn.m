function u_t = particleTerminalVelocityFcn(mu_lp_g_m, rho_lp_g_m, Global,id)
% -------------------------------------------------------------------------

    dp         = Global.carrier.dp; 
    sphericity = Global.carrier.sphericity;
    u_g0_lp    = Global.fDynamics.usg0;
    rho_s      = Global.carrier.rho_s;
    rho_g      = rho_lp_g_m;
    mu_g       = mu_lp_g_m;
    g          = Global.g;
    Emf        = Global.fDynamics.Emf;
% -------------------------------------------------------------------------

    if     strcmp(id,'mod_1')

        dp_ast = dp.*((rho_g.*(rho_s - rho_g).*g)./(mu_g.^2)).^(1/3);
        ut_ast = ((18./(dp_ast.^2))+(0.59./dp_ast.^(0.5))).^(-1);
        u_t    = ut_ast.*(mu_g.*(rho_s - rho_g).*g./(rho_g.^2)).^(1/3);

    elseif strcmp(id,'mod_2')

        dp_ast = dp.*((rho_g.*(rho_s - rho_g).*g)./(mu_g.^2)).^(1/3);
        ut_ast = ((18./(dp_ast.^2)) + ... 
                 ((2.335 - 1.744.*sphericity)./dp_ast.^(0.5))).^(-1);
        u_t    = ut_ast.*(mu_g.*(rho_s - rho_g).*g./(rho_g.^2)).^(1/3);

    elseif strcmp(id,'mod_3')

        tmp_1 = 3.*(mu_g.^2);
        tmp_2 = 4.*g.*rho_g.*(rho_s - rho_g);
        delta = (tmp_1./tmp_2).^(1/3);
    
        tmp_3 = 4.*g.*mu_g.*(rho_s - rho_g);
        tmp_4 = 3.*(rho_g).^2;
        omega = (tmp_3./tmp_4).^(1/3);

        tmp_5 = (24./((dp./delta).^2));
        tmp_6 = ((2.696 - 2.013.*sphericity)./((dp./delta).^(1/2)));
        tmp_7 = (tmp_5 + tmp_6).^(-1);
        u_t   = omega.*tmp_7;


    elseif strcmp(id,'mod_4')

        % Re  = dp.*u_g0_lp.*rho_g./(mu_g.*(1 - Emf));
        Re  = dp.*u_g0_lp.*rho_g./(mu_g);

        a1 = zeros(length(Re),1);
        b1 = zeros(length(Re),1);

        Re_max = max(Re);

        if Re_max > 0 && Re_max <= 0.4
            a1(:,1) = 24;
            b1(:,1) = 1.0;
        elseif Re_max > 0.4 && Re_max <= 500
            a1(:,1) = 10;
            b1(:,1) = 0.5;
        elseif Re_max > 500
            a1(:,1) = 0.40;
            b1(:,1) = 0.00;
        end
        
        CD = a1.*(Re.^b1);
        u_t = (((4.*g.*dp)./(3.*CD)).*((rho_s./rho_g) - 1)).^(1/2);
    end

    u_t(isinf(u_t)) = 0;
    u_t(isnan(u_t)) = 0;

end


