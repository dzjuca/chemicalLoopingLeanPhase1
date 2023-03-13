function [ub,db,us,ue,alpha]= ubFcn(Global)
% -------------------------------------------------------------------------
    % The ubFcn.m function allows for the calculation of bubble diameter 
    % and velocity as a function of the reactor height (z).
    % ----------------------------| input |--------------------------------
    %     usg0 = superficial gas velocity                            [cm/s]
    %      umf = minimum fluidization velocity                       [cm/s]
    %        g = acceleration of gravity                            [cm/s2]
    %       Di = internal diameter of the reactor                      [cm]
    %       zg = mesh values                                           [cm]
    %       fw = fraction of wake in bubbles                             []
    %      Emf = minimum fluidization porosity                           []
    % ----------------------------| output |-------------------------------
    %       ub = bubble velocity                                     [cm/s]
    %       db = bubble diameter                                       [cm]
    %       us = downward solid velocity in emulsion                 [cm/s]
    %       ue = emulsion velocity                                   [cm/s]
    %    alpha = fraction of bubbles in bed                              []
% -------------------------------------------------------------------------
    g    = Global.g;
    usg0 = Global.fDynamics.usg0;
    umf  = Global.fDynamics.umf;
    fw   = Global.fDynamics.fw;
    Emf  = Global.fDynamics.Emf;
    Di   = Global.reactor.rID;
    z1   = Global.reactor.z1;
    n1    = Global.n1;
% -------------------------------------------------------------------------
    db    = zeros(n1,1); 
    ub    = zeros(n1,1);
    us    = zeros(n1,1);
    ue    = zeros(n1,1);
    alpha = zeros(n1,1);
% -------------------------------------------------------------------------
%   dbo = (3.77*(usg0 - umf)^2)/g;   
    dbo = 0.02;
    dbm = 0.652*((pi/4)*(Di^2)*(usg0-umf))^(0.4);
    for  i = 1:n1
        db(i)    = dbm-(dbm-dbo)*exp(-0.3*z1(i)/Di);
        ub(i)    = (usg0-umf)+0.711*(g*db(i))^(0.5);
        alpha(i) = (usg0-umf)/(ub(i)-umf-umf*fw);
        us(i)    = ((fw*alpha(i)*ub(i))/(1-alpha(i)-alpha(i)*fw));
        ue(i)    = (umf/Emf)-us(i);
    end
% -------------------------------------------------------------------------
end