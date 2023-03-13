function [u1e, u2e, u3e, u4e, u5e, u6e] = bc_dp_ge_Fcn(u1e, u2e, u3e, ... 
                                                u4e, u5e, u6e, Global)
% ---------- z = 0 gas - emulsion phase -----------------------------------

    u1e(1) = Global.CH4in; u2e(1) = 0.000; u3e(1) = 0.000;
    u4e(1) = 0.000;        u5e(1) = 0.000; u6e(1) = Global.N2in;

end