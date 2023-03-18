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
    Tbed_2(1:Global.n2,1) = Global.Tbed;
    id_g_f  = 'gas_freeboard'; id_s_f  = 'solid_freeboard';
% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    u(u < 0) = 0;
% ---------- gas freeboard phase ------------------------------------------
    [f1g, f2g, f3g, f4g, f5g, f6g] = assignValuesFcn(u, Global, id_g_f);
% ---------- solid freeboard phase ----------------------------------------
                   [f1s, f2s, f3s] = assignValuesFcn(u, Global, id_s_f);
% --------------------| Fluidized Bed |------------------------------------ 
% ---------- bubble - ubFcn.m ---------------------------------------------  
% ---------- concentrations dense phase vector ----------------------------
% --------------------| Boundary Conditions Lean Phase |-------------------
    [f1g, f2g, f3g, f4g, f5g, f6g] = ... 
                      bc_lp_g_Fcn(f1g, f2g, f3g, f4g, f5g, f6g, Global);
    [f1s, f2s, f3s] = bc_lp_s_Fcn(f1s, f2s, f3s, Global);
% ---------- concentrations Lean phase vector -----------------------------
    C_gs_lp.C_g = [f1g,f2g,f3g,f4g,f5g,f6g];
    C_gs_lp.C_s = [f1s,f2s,f3s];
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
% --------------------| Mass Balance - Gas - Emulsion Phase |--------------
% --------------------| Mass Balance - Solid - Wake Phase |----------------
% --------------------| Mass Balance - Solid - Emulsion Phase |------------
% --------------------| Mass Balance - Gas   - Freeboard Phase |-----------
    f1gt = (- lr_mbrhs1Fcn(f1g, C_gs_lp, Tbed_2, Global, 'g_lp')        ... 
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 'g_lp', 'CH4_lp'));

    f2gt = (- lr_mbrhs1Fcn(f2g, C_gs_lp, Tbed_2, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 'g_lp', 'CO2_lp'));   

    f3gt = (- lr_mbrhs1Fcn(f3g, C_gs_lp, Tbed_2, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 'g_lp', 'CO_lp'));

    f4gt = (- lr_mbrhs1Fcn(f4g, C_gs_lp, Tbed_2, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 'g_lp', 'H2_lp'));

    f5gt = (- lr_mbrhs1Fcn(f5g, C_gs_lp, Tbed_2, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 'g_lp', 'H2O_lp'));

    f6gt = (- lr_mbrhs1Fcn(f6g, C_gs_lp, Tbed_2, Global, 'g_lp')        ...
            + lr_mbrhs2Fcn(f1g, Global)                                 ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 'g_lp', 'N2_lp'));

% --------------------| Mass Balance - Solid - Freeboard Phase |-----------
    f1st = (- lr_mbrhs1Fcn(f1s, C_gs_lp, Tbed_2, Global, 's_lp')        ... 
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 's_lp', 'NiO_lp'));

    f2st = (- lr_mbrhs1Fcn(f2s, C_gs_lp, Tbed_2, Global, 's_lp')        ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 's_lp', 'Ni_lp'));

    f3st = (- lr_mbrhs1Fcn(f3s, C_gs_lp, Tbed_2, Global, 's_lp')        ...
            + lr_mbrhs3Fcn(C_gs_lp, Tbed_2, Global, 's_lp', 'C_lp'));
% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
% ---------- z = 0 gas - emulsion phase -----------------------------------
% ---------- z = 0 solid - wake & emulsion phases -------------------------
% ---------- z = Zg solid - wake & emulsion phase -------------------------
% --------------------| Temporal Variation Vector dudt |-------------------
    ut = [f1gt; f2gt; f3gt; f4gt; f5gt; f6gt; f1st; f2st; f3st];
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, t]);
    ncall.incrementNcall();
% --------------------| pdeFcn - End |-------------------------------------
end 