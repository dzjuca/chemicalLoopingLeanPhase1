function graphs_c_s_lp_Fcn(t, u, Global)
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

    f1s = zeros(index1,index2); 
    f2s = zeros(index1,index2); 
    f3s = zeros(index1,index2);

% -------------------------------------------------------------------------

    for j=1:index1 
        for i=1:index2, f1s(j,i)=u(j,i+6*index2);     end
        for i=1:index2, f2s(j,i)=u(j,i+7*index2);     end
        for i=1:index2, f3s(j,i)=u(j,i+8*index2);     end
    end

% -------------------------------------------------------------------------

    TAG1 = {'$C_{i}\left( \frac{g}{g_{carrier}} \right)$'}; 
    TAG3 = {'sc_Time','sc_Space'};
    TAG5 = {'graphs/Concentration/leanPhase'};

% -------------------------------------------------------------------------

    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/Concentration/leanPhase','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'Concentration','Solid');
    else
        mkdir('graphs/Concentration/leanPhase')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'Concentration','Solid');
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

        plot(tmin,f1s(:,n2)','ko-','MarkerSize',MZ1); % NiO
        plot(tmin,f2s(:,n2)','ks-','MarkerSize',MZ1); % Ni
        plot(tmin,f3s(:,n2)','kp-','MarkerSize',MZ1); % C

        xlabel('$time\left( {min} \right)$','FontSize',XLFZ,      ...
        'interpreter','Latex')
        max3 = max(tmin); 
        xlim([0 max3])

        ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex')
        max1 = max([max(f1s(:,n2)), max(f2s(:,n2)), max(f3s(:,n2))]);
        max1 = max1 + max1*0.15;
        ylim([0 max1])

        ley1 = {'$NiO$','$Ni$','$C$'};
        legend(ley1,'Interpreter','Latex','Location','north',   ...
            'Orientation','horizontal','FontSize',LFZ)

    hold off
    print(fig1,'-dpdf','-r500',dir)
    close all
% -------------------------------------------------------------------------
% --------------------------| Concentration vs space |---------------------
    id = exist('graphs/Concentration/leanPhase','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'Concentration','Solid');
    else
        mkdir('graphs/Concentration/leanPhase')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'Concentration','Solid');
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

        plot(z2,f1s(m,:)','ko-','MarkerSize',MZ1);
        plot(z2,f2s(m,:)','ks-','MarkerSize',MZ1);
        plot(z2,f3s(m,:)','kp-','MarkerSize',MZ1);

        ley2 = {'$NiO$','$Ni$','$C$'};
        legend(ley2,'Interpreter','Latex',               ...
            'Location','north',                          ...
            'Orientation','horizontal',                  ...
            'FontSize',LFZ)

        ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex')
        max1 = max([max(f1s(m,:)), max(f2s(m,:)), max(f3s(m,:))]);
        max1 = max1 + max1*0.15;
        ylim([0 max1])

        xlabel('$z\left( {cm} \right)$',                 ...
        'FontSize',XLFZ,'interpreter','Latex')
        max2 = max(z2); 
        xlim([0 max2])

    hold off
    print(fig2,'-dpdf','-r500',dir)
    close all
% -------------------------------------------------------------------------
end

