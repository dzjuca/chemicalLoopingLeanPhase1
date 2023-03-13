function [u1b, u2b, u3b, u4b, u5b, u6b] = bc_dp_gb_Fcn(u1b, u2b, u3b, ... 
                                                     u4b, u5b, u6b, Global)
% ---------- z = 0 gas - bubble & wake phase ------------------------------

    u1b(1) = Global.CH4in; u2b(1) = 0.000; u3b(1) = 0.000; 
    u4b(1) = 0.000;        u5b(1) = 0.000; u6b(1) = Global.N2in;

end