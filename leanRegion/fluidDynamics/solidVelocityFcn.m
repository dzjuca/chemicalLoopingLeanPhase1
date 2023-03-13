function u_sf = solidVelocityFcn(Global)
% -----------------------------------------------------------------------

    g = Global.g;
    D = Global.reactor.rID_2;
    n2 = Global.n2;

% -----------------------------------------------------------------------
%     u_gf  = gasVelocityFreeboardFcn();
%     u_sgf = superficialGasVelocityFreeboardFcn();
%     u_t   = particleTerminalVelocityFcn();
% -----------------------------------------------------------------------
%     Fr_gf = u_sgf./((g.*D).^(0.5));
%     Fr_t  = u_t./((g.*D).^(0.5));
%     phi   = 1 + (5.6./Fr_gf) + 0.47.*(Fr_t.^(0.41));
% -----------------------------------------------------------------------
%     u_sf  = u_gf/phi;
%     id    = isinf(u_sf);
%     u_sf(id) = 0;
% -----------------------------------------------------------------------

    u_sf(1:n2,1) = 0.4;                                                    % ===========> valor ficticio
    
end