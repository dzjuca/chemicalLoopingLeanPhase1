function ut = pdeFcn(t,u,Global)
% -------------------------------------------------------------------------
    % pdeFcn function define the EDOs for the numerical solution with 
    % the method of lines
    % ----------------------------| input |--------------------------------
    %       t = interval of integration, specified as a vector
    %       u = time-dependent terms, specified as a vector
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------
    %      ut =  time-dependent terms variation, specified as a vector
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------

    ncall   = Global.iterations;
    Tbed  (1:Global.n1,1) = Global.Tbed;
    Tbed_2(1:Global.n2,1) = Global.Tbed;
    index1  = Global.n1;
    id_g_b  = 'gas_bubble';    id_g_e  = 'gas_emulsion';
    id_s_w  = 'solid_wake';    id_s_e  = 'solid_emulsion';
    id_g_f  = 'gas_freeboard'; id_s_f  = 'solid_freeboard';
% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    u(u < 0) = 0;
% ---------- gas - bubble & wake phases------------------------------------
    [u1b, u2b, u3b, u4b, u5b, u6b] = assignValuesFcn(u, Global, id_g_b);
% ---------- gas - emulsion phase -----------------------------------------
    [u1e, u2e, u3e, u4e, u5e, u6e] = assignValuesFcn(u, Global, id_g_e);
% ---------- solid - wake phase -------------------------------------------
                   [u7w, u8w, u9w] = assignValuesFcn(u, Global, id_s_w);
% ---------- solid - emulsion phase ---------------------------------------
                   [u7e, u8e, u9e] = assignValuesFcn(u, Global, id_s_e);
% ---------- gas freeboard phase ------------------------------------------
    [f1g, f2g, f3g, f4g, f5g, f6g] = assignValuesFcn(u, Global, id_g_f);
% ---------- solid freeboard phase ----------------------------------------
                   [f1s, f2s, f3s] = assignValuesFcn(u, Global, id_s_f);
% --------------------| Fluidized Bed |------------------------------------ 
% --------------------| Boundary Conditions Dense Phase |------------------
    [u1b, u2b, u3b, u4b, u5b, u6b] = ... 
                    bc_dp_gb_Fcn(u1b, u2b, u3b, u4b, u5b, u6b, Global); 
    [u1e, u2e, u3e, u4e, u5e, u6e] = ...
                    bc_dp_ge_Fcn(u1e, u2e, u3e, u4e, u5e, u6e, Global); 
    [u7w, u8w, u9w, u7e, u8e, u9e] = ...
                    bc_dp_swe_Fcn(u7w, u8w, u9w, u7e, u8e, u9e, Global);
% ---------- bubble - ubFcn.m ---------------------------------------------
    [ub,db,us,ue,alpha] = ubFcn(Global);    
% ---------- concentrations dense phase vector ----------------------------
    C_gs_dp.C_g_b = [u1b,u2b,u3b,u4b,u5b,u6b];
    C_gs_dp.C_g_e = [u1e,u2e,u3e,u4e,u5e,u6e];
    C_gs_dp.C_s_w = [u7w,u8w,u9w]; 
    C_gs_dp.C_s_e = [u7e,u8e,u9e];
% --------------------| Boundary Conditions Lean Phase |-------------------
    [f1g, f2g, f3g, f4g, f5g, f6g] = ... 
                bc_lp_g_Fcn(f1g, f2g, f3g, f4g, f5g, f6g, C_gs_dp, Global);
    [f1s, f2s, f3s] = bc_lp_s_Fcn(f1s, f2s, f3s, C_gs_dp, Global);
% ---------- concentrations Lean phase vector -----------------------------
    C_gs_lp.C_g = [f1g,f2g,f3g,f4g,f5g,f6g];
    C_gs_lp.C_s = [f1s,f2s,f3s];
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
    id_1 = 'FGBurbuja'; id_2 = 'FGas';
    u1bt = massBalanceFcn(u1b,u1e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'CH4');
    u2bt = massBalanceFcn(u2b,u2e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'CO2');
    u3bt = massBalanceFcn(u3b,u3e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'CO' );
    u4bt = massBalanceFcn(u4b,u4e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'H2' );
    u5bt = massBalanceFcn(u5b,u5e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'H2O');
    u6bt = massBalanceFcn(u6b,u6e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'N2' );
% --------------------| Mass Balance - Gas - Emulsion Phase |--------------
    id_1 = 'FGEmulsion'; 
    u1et = massBalanceFcn(u1b,u1e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'CH4');
    u2et = massBalanceFcn(u2b,u2e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'CO2');
    u3et = massBalanceFcn(u3b,u3e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'CO' );
    u4et = massBalanceFcn(u4b,u4e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'H2' );
    u5et = massBalanceFcn(u5b,u5e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'H2O');
    u6et = massBalanceFcn(u6b,u6e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'N2' );
% --------------------| Mass Balance - Solid - Wake Phase |----------------
    id_1 = 'FSEstela'; id_2 = 'FSolido';
    u7wt = massBalanceFcn(u7w,u7e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'NiO');
    u8wt = massBalanceFcn(u8w,u8e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'Ni' );
    u9wt = massBalanceFcn(u9w,u9e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'C'  );
% --------------------| Mass Balance - Solid - Emulsion Phase |------------
    id_1 = 'FSEmulsion'; 
    u7et = massBalanceFcn(u7w,u7e,C_gs_dp,Tbed,alpha,[ub,us],db,Global,id_1,id_2,'NiO');
    u8et = massBalanceFcn(u8w,u8e,C_gs_dp,Tbed,alpha,[ub,us],db,Global,id_1,id_2,'Ni' );
    u9et = massBalanceFcn(u9w,u9e,C_gs_dp,Tbed,alpha,[ub,us],db,Global,id_1,id_2,'C'  );
% --------------------| Mass Balance - Gas   - Freeboard Phase |-----------
    f1gt = (- lr_mbrhs1Fcn(f1g, C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp') ... 
            + lr_mbrhs2Fcn(f1g, Global)... 
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp', 'CH4_lp'));
    f2gt = (- lr_mbrhs1Fcn(f2g, C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp') ...
            + lr_mbrhs2Fcn(f2g, Global) ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp', 'CO2_lp'));
    f3gt = (- lr_mbrhs1Fcn(f3g, C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp') ...
            + lr_mbrhs2Fcn(f3g, Global) ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp', 'CO_lp'));
    f4gt = (- lr_mbrhs1Fcn(f4g, C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp') ...
            + lr_mbrhs2Fcn(f4g, Global) ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp', 'H2_lp'));
    f5gt = (- lr_mbrhs1Fcn(f5g, C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp') ...
            + lr_mbrhs2Fcn(f5g, Global) ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp', 'H2O_lp'));
    f6gt = (- lr_mbrhs1Fcn(f6g, C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp') ...
            + lr_mbrhs2Fcn(f6g, Global) ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 'g_lp', 'H2O_lp'));
% --------------------| Mass Balance - Solid - Freeboard Phase |-----------
    f1st = (- lr_mbrhs1Fcn(f1s, C_gs_dp, C_gs_lp, Tbed_2, Global, 's_lp') ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 's_lp', 'NiO_lp'));
    f2st = (- lr_mbrhs1Fcn(f2s, C_gs_dp, C_gs_lp, Tbed_2, Global, 's_lp') ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 's_lp', 'Ni_lp'));
    f3st = (- lr_mbrhs1Fcn(f3s, C_gs_dp, C_gs_lp, Tbed_2, Global, 's_lp') ...
            + lr_mbrhs3Fcn(C_gs_dp, C_gs_lp, Tbed_2, Global, 's_lp', 'C_lp'));
% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    u1bt(1) = 0; u2bt(1) = 0; u3bt(1) = 0; 
    u4bt(1) = 0; u5bt(1) = 0; u6bt(1) = 0;
% ---------- z = 0 gas - emulsion phase -----------------------------------
    u1et(1) = 0; u2et(1) = 0; u3et(1) = 0; 
    u4et(1) = 0; u5et(1) = 0; u6et(1) = 0;
% ---------- z = 0 solid - wake & emulsion phases -------------------------
     u7wt(1) = u7et(1); 
     u8wt(1) = u8et(1); 
     u9wt(1) = u9et(1);
% ---------- z = Zg solid - wake & emulsion phase -------------------------
     u7et(index1) = u7wt(index1); 
     u8et(index1) = u8wt(index1);
     u9et(index1) = u9wt(index1);
% --------------------| Temporal Variation Vector dudt |-------------------
    ut = [u1bt; u2bt; u3bt; u4bt; u5bt; u6bt; ...
          u1et; u2et; u3et; u4et; u5et; u6et; ...
          u7wt; u8wt; u9wt; u7et; u8et; u9et; ...
          f1gt; f2gt; f3gt; f4gt; f5gt; f6gt; ...
          f1st; f2st; f3st];
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, t]);
    ncall.incrementNcall();
% --------------------| pdeFcn - End |-------------------------------------
end 