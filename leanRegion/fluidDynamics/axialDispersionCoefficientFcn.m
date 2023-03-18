function D_ax = axialDispersionCoefficientFcn(Global)
% -------------------------------------------------------------------------
 u_sg  = Global.fDynamics.usg0;
 dp    = Global.carrier.dp;
 Pe_ax = Global.fDynamics.Pe_ax;
% -------------------------------------------------------------------------
    D_ax = dp.*u_sg./Pe_ax;
    D_ax(isnan(D_ax)) = 0;
    D_ax(isinf(D_ax)) = 0;
% -------------------------------------------------------------------------
%    D_ax      = 0.01; % ======> valor de diseño
%    D_ax(:,1) = 0.28;
% -------------------------------------------------------------------------
end

        
        




