function [u7w, u8w, u9w, u7e, u8e, u9e] = bc_dp_swe_Fcn(u7w, u8w, u9w, ... 
                                                    u7e, u8e, u9e, Global)

    index1 = Global.n1;
% % ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7w(1) = u7e(1); 
    u8w(1) = u8e(1); 
    u9w(1) = u9e(1);
% % ---------- z = Zg solid - wake & emulsion phases ------------------------
    u7e(index1) = u7w(index1); 
    u8e(index1) = u8w(index1);
    u9e(index1) = u9w(index1);

end