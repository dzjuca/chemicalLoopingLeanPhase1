        Re  = dp.*u_g0_lp.*rho_g./(mu_g.*(1 - Emf));

        a1 = zeros(length(Re),1);
        b1 = zeros(length(Re),1);

        if (Re > 0 && Re < 0.4
            a1 = 24;
            b1 = 1;

        elseif 0.4 <= Re && Re < 500
            a1 = 10;
            b1 = 0.5;
        elseif Re >= 500
            a1 = 0.44;
            b1 = 0.00;
        end