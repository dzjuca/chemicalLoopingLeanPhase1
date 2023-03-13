function graphsMfgAllSpeciesFcn(t, u, Global)
% -------------------------------------------------------------------------
       % graphs_C_g_b_Fcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  ebrhs1 = right-hand side term-1                         [J/s cm3]
% -------------------------------------------------------------------------

    A = Global.reactor.rArea1;
    [ub,db,us,ue,alpha] = ubFcn(Global);  
    m      = length(t);
    n1      = Global.n1;

% -------------------------------------------------------------------------

    tseg = t; 
    tmin = t/60; 
    thor = t/3600;

% -------------------------------------------------------------------------
    z1     = Global.reactor.z1;
    index1 = length(t);    % tiempo
    index2 = Global.n1;     % espacio
    index3 = Global.gen;   % # de compuestos
% -------------------------------------------------------------------------

    u1b = zeros(index1,index2); u2b = zeros(index1,index2); 
    u3b = zeros(index1,index2); u4b = zeros(index1,index2); 
    u5b = zeros(index1,index2); u6b = zeros(index1,index2);

    u1e = zeros(index1,index2); u2e = zeros(index1,index2); 
    u3e = zeros(index1,index2); u4e = zeros(index1,index2); 
    u5e = zeros(index1,index2); u6e = zeros(index1,index2);


% -------------------------------------------------------------------------
    for j=1:index1 
        for i=1:index2, u1b(j,i)=u(j,i+0*index2);     end
        for i=1:index2, u2b(j,i)=u(j,i+1*index2);     end
        for i=1:index2, u3b(j,i)=u(j,i+2*index2);     end
        for i=1:index2, u4b(j,i)=u(j,i+3*index2);     end
        for i=1:index2, u5b(j,i)=u(j,i+4*index2);     end 
        for i=1:index2, u6b(j,i)=u(j,i+5*index2);     end 
        for i=1:index2, u1e(j,i)=u(j,i+6*index2);     end 
        for i=1:index2, u2e(j,i)=u(j,i+7*index2);     end 
        for i=1:index2, u3e(j,i)=u(j,i+8*index2);     end 
        for i=1:index2, u4e(j,i)=u(j,i+9*index2);     end
        for i=1:index2, u5e(j,i)=u(j,i+10*index2);    end
        for i=1:index2, u6e(j,i)=u(j,i+11*index2);    end
    end

% -------------------------------------------------------------------------

    f1 = A.*(ub'.*u1b + ue'.*u1e); 
    f2 = A.*(ub'.*u2b + ue'.*u2e);
    f3 = A.*(ub'.*u3b + ue'.*u3e);
    f4 = A.*(ub'.*u4b + ue'.*u4e);
    f5 = A.*(ub'.*u5b + ue'.*u5e);
    f6 = A.*(ub'.*u6b + ue'.*u6e);

    ft = f1 + f2 + f3 + f4 + f5 + f6;

    x1 = f1./ft;
    x2 = f2./ft;
    x3 = f3./ft;
    x4 = f4./ft;
    x5 = f5./ft;
    x6 = f6./ft;

% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
    TAG1 = {'Molar Fraction $(CH_{4}, CO_{2}, H_{2}O)$',
            'Molar Fraction $(CO, H_{2})$',
            'Molar Fraction $x_{i}$'}; 
    TAG3 = {'x_Time','x_Space'};
    TAG5 = {'graphs/MolarFraction'};
% -------------------------------------------------------------------------

    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Gas');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Gas');
    end

    % ---------------------------------------------------------------------
    fig1 = figure;
        set(fig1,'Units','centimeters',              ...
        'PaperPosition',[0 0 15 15],                 ...
        'PaperSize', [15,15]);

    axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
        'YGrid','off','visible','on','Box', 'on',    ...
        'TickLabelInterpreter','latex');

    set(fig1, 'Color', 'w') 
    % ---------------------------------------------------------------------
    hold on

        plot(tmin,x1(:,n1)','ko-','MarkerSize',MZ1); % CH4
        plot(tmin,x2(:,n1)','ks-','MarkerSize',MZ1); % CO2
        plot(tmin,x3(:,n1)','kp-','MarkerSize',MZ1); % CO
        plot(tmin,x4(:,n1)','kd-','MarkerSize',MZ1); % H2
        plot(tmin,x5(:,n1)','k*-','MarkerSize',MZ1); % H2O

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex')
        ylim([0 0.6])


        xlabel('$time\left( {min} \right)$','FontSize',XLFZ,      ...
        'interpreter','Latex')

        ley1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};
        legend(ley1,'Interpreter','Latex','Location','north',   ...
        'Orientation','horizontal','FontSize',LFZ)


        max3 = max(tmin); 
        xlim([0 max3])

    hold off
    print(fig1,'-dpdf','-r500',dir)
    close all
    % -------------------------------------------------------------------------
    % --------------------------| Concentration vs space |---------------------
    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Gas');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Gas');
    end
    % ---------------------------------------------------------------------
    fig2 = figure;

    set(fig2,'Units','centimeters',                       ...
        'PaperPosition',[0 0 15 15],                      ...
        'PaperSize', [15,15]);

    axes('Parent',fig2,'FontSize',FZ1,'XGrid','off',      ...
        'YGrid','off','visible','on','Box', 'on',         ...
        'TickLabelInterpreter','latex');
    set(fig2, 'Color', 'w') 

    hold on

        plot(z1,x1(m,:)','ko-','MarkerSize',MZ1);
        plot(z1,x2(m,:)','ks-','MarkerSize',MZ1);
        plot(z1,x3(m,:)','kp-','MarkerSize',MZ1);
        plot(z1,x4(m,:)','kd-','MarkerSize',MZ1);
        plot(z1,x5(m,:)','k*-','MarkerSize',MZ1);

        ley2 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};

        legend(ley2,'Interpreter','Latex',               ...
            'Location','north',                          ...
            'Orientation','horizontal',                  ...
            'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
        'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex') 

        ylim([0 0.6])

        max2 = max(z1); 
        xlim([0 max2])

    hold off
    print(fig2,'-dpdf','-r500',dir)
    close all
end