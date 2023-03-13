function graphsMf_g_lp_Fcn(t, u_t, Global)
% -------------------------------------------------------------------------
       % graphsMf_g_lp_Fcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  
% -------------------------------------------------------------------------
 
    gen = Global.gen;
    sen = Global.sen;
    n1  = Global.n1;

    id1 = (n1*gen + n1*sen)*2;

    u = u_t(:, id1+1:end);


% -------------------------------------------------------------------------

    tmin = t/60; 

% -------------------------------------------------------------------------

    z2     = Global.reactor.z2;
    index1 = length(t);    % tiempo
    index2 = Global.n2;     % espacio
    index3 = Global.gen;   % # de compuestos

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

    Ct = f1g + f2g + f3g + f4g + f5g + f6g;

    x1 = f1g./Ct; 
    x2 = f2g./Ct; 
    x3 = f3g./Ct; 
    x4 = f4g./Ct; 
    x5 = f5g./Ct; 
    x6 = f6g./Ct;     


    %x1(isnan(x1)) = 0;
    x2(isnan(x2)) = 0;
    x3(isnan(x3)) = 0;
    x4(isnan(x4)) = 0;
    x5(isnan(x5)) = 0;
    x6(isnan(x6)) = 0;

% -------------------------------------------------------------------------
end