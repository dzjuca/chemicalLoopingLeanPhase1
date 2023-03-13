function u_t = massBalanceFcn(u_b, u_e, estructC, Tbe, alpha,u,db, ...
                              Global, id_1, id_2, id_3)
% -------------------------------------------------------------------------
    % massBalanceFcn 
    % ----------------------------| input |--------------------------------
    % u_b      = gas|solid concentration in the bubble phase
    %            [mol/cm3] [gSolid/g-carrier]
    % u_e      = gas|solid concentration in the emulsion phase
    %            [mol/cm3] [gSolid/g-carrier]
    % estructC = structure with gas and solid concentrations ...
    %            in the bubble and emulsion phase                        []
    % Tbe      = temperature of the bubble or emulsion phase            [K]
    % alpha    = fraction of bubbles in bed                              []
    % u        = bubble|emulsion|solid velocity                      [cm/s]
    % db       = bubble diameter                                       [cm]
    % Global   = structure with global data                              []
    % id_1     = phase identifier                                        []
    % id_2     = state of matter identifier                              []
    % id_3     = element identifier                                      []
    % ----------------------------| output |-------------------------------
    %   u_t    = temporal variation of species ...
    %                                      [mol/cm3-s] [gSolid/g-carrier-s]              
% -------------------------------------------------------------------------

    fw   = Global.fDynamics.fw;
    Emf  = Global.fDynamics.Emf; 
    Dcat = Global.carrier.bulkDensity;

% -------------------------------------------------------------------------

    if strcmp(id_1,'FGBurbuja')

        C_g = estructC.C_g_b;
        FC1 = 1./(alpha + fw*alpha*Emf);
        u_t = -(mbrhs1Fcn(alpha,u,u_b,Global,id_1)).*FC1                ...
            +(mbrhs2Fcn(alpha,u,u_b,u_e,Global,id_2)).*FC1              ... 
            -(mbrhs3Fcn(alpha,db,u,u_b,u_e,C_g,Tbe,Global,id_2,id_3)).*FC1  ...
            +(mbrhs4Fcn(alpha,estructC,Tbe,Global,id_1,id_3)).*FC1;

% -------------------------------------------------------------------------
    elseif strcmp(id_1,'FGEmulsion')

        C_g = estructC.C_g_e;
        FC2 = 1./((1-alpha-alpha*fw)*Emf);
        u_t = -(mbrhs1Fcn(alpha,u(:,2),u_e,Global,id_1)).*FC2            ...
        -(mbrhs2Fcn(alpha,u(:,1),u_b,u_e,Global,id_2)).*FC2              ...
        +(mbrhs3Fcn(alpha,db,u(:,1),u_b,u_e,C_g,Tbe,Global,id_2,id_3)).*FC2 ...
        +(mbrhs4Fcn(alpha,estructC,Tbe,Global,id_1,id_3)).*FC2;
% -------------------------------------------------------------------------
    elseif strcmp(id_1,'FSEstela')

        FC3 = 1./((alpha*fw)*(1-Emf)*Dcat);
        u_t = -mbrhs1Fcn(alpha,u,u_b,Global,id_1).*FC3                  ...
              +mbrhs2Fcn(alpha,u,u_b,u_e,Global,id_2).*FC3              ...
              -mbrhs3Fcn(alpha,db,[],u_b,u_e,[],[],Global,id_2,[]).*FC3 ...
              +mbrhs4Fcn(alpha,estructC,Tbe,Global,id_1,id_3).*FC3;
% -------------------------------------------------------------------------
    elseif strcmp(id_1,'FSEmulsion')

        FC4 = 1./((1-alpha-alpha*fw)*(1-Emf)*Dcat);
        u_t = +mbrhs1Fcn(alpha,u(:,2),u_e,Global,id_1).*FC4             ...
              -mbrhs2Fcn(alpha,u(:,1),u_b,u_e,Global,id_2).*FC4         ...
              +mbrhs3Fcn(alpha,db,[],u_b,u_e,[],[],Global,id_2,[]).*FC4 ...
              +mbrhs4Fcn(alpha,estructC,Tbe,Global,id_1,id_3).*FC4;

    end
% -------------------------------------------------------------------------
end