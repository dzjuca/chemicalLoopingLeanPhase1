function graphsMfgAllSpeciesFcn(t, u, Global)
% -------------------------------------------------------------------------
       % graphs_C_g_b_Fcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  ebrhs1 = right-hand side term-1                         [J/s cm3]
% -------------------------------------------------------------------------

    m  = length(t);
    n2 = Global.n2;

% -------------------------------------------------------------------------

    tmin = t/60; 

% -------------------------------------------------------------------------
    z2     = Global.reactor.z2;
    index1 = length(t);    % tiempo
    index2 = Global.n2;    % espacio
% -------------------------------------------------------------------------

    f1g = zeros(index1,index2); f2g = zeros(index1,index2); 
    f3g = zeros(index1,index2); f4g = zeros(index1,index2); 
    f5g = zeros(index1,index2); f6g = zeros(index1,index2);

% -------------------------------------------------------------------------
    for j=1:index1 
        for i=1:index2, f1g(j,i)=u(j,i+0*index2);     end
        for i=1:index2, f2g(j,i)=u(j,i+1*index2);     end
        for i=1:index2, f3g(j,i)=u(j,i+2*index2);     end
        for i=1:index2, f4g(j,i)=u(j,i+3*index2);     end
        for i=1:index2, f5g(j,i)=u(j,i+4*index2);     end 
        for i=1:index2, f6g(j,i)=u(j,i+5*index2);     end 
    end

% -------------------------------------------------------------------------

    ft = f1g + f2g + f3g + f4g + f5g + f6g;

    x1 = f1g./ft;
    x2 = f2g./ft;
    x3 = f3g./ft;
    x4 = f4g./ft;
    x5 = f5g./ft;
    x6 = f6g./ft;

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

        plot(tmin,x1(:,n2)','ko-','MarkerSize',MZ1); % CH4
        plot(tmin,x2(:,n2)','ks-','MarkerSize',MZ1); % CO2
        plot(tmin,x3(:,n2)','kp-','MarkerSize',MZ1); % CO
        plot(tmin,x4(:,n2)','kd-','MarkerSize',MZ1); % H2
        plot(tmin,x5(:,n2)','k*-','MarkerSize',MZ1); % H2O

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex')
        ylim([0 1])


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

        plot(z2,x1(m,:)','ko-','MarkerSize',MZ1);
        plot(z2,x2(m,:)','ks-','MarkerSize',MZ1);
        plot(z2,x3(m,:)','kp-','MarkerSize',MZ1);
        plot(z2,x4(m,:)','kd-','MarkerSize',MZ1);
        plot(z2,x5(m,:)','k*-','MarkerSize',MZ1);

        ley2 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};

        legend(ley2,'Interpreter','Latex',               ...
            'Location','north',                          ...
            'Orientation','horizontal',                  ...
            'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
        'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex') 

        ylim([0 0.6])

        max2 = max(z2); 
        xlim([0 max2])

    hold off
    print(fig2,'-dpdf','-r500',dir)
    close all
end