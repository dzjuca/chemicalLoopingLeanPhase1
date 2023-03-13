function kinetic = kineticFcn(C_gas, C_solid, T, Global, id)
% -------------------------------------------------------------------------
    % kineticFcn function 
    % ----------------------------| input |--------------------------------
    %        C_gas = matrix with the concentrations for ...
    %                each gaseous specie                          [mol/cm3]
    %      C_solid = matrix with the concentrations for ...
    %                each solid specie                            [mol/cm3]
    %           T = phase temperature                                   [K]
    %      Global = constant values structure                            []
    %          id = species|reaction identifier                          []
    % ----------------------------| output |-------------------------------
    %     kinetic = reaction rate of each species              [mol/gcat s] ===> revisar este valor                      
% -------------------------------------------------------------------------
    
    if strcmp(id,'CH4_lp')||strcmp(id,'CO2_lp')||strcmp(id,'CO_lp')|| ...
       strcmp(id,'H2_lp') ||strcmp(id,'H2O_lp')||strcmp(id,'N2_lp')|| ...
       strcmp(id,'NiO_lp')||strcmp(id,'Ni_lp') ||strcmp(id,'C_lp')
        index1  = Global.n2;
    else
        index1  = Global.n1;
    end
    kinetic = zeros(index1,1);
    data    = Global.carrier;
% -------------------------------------------------------------------------
%     for  i = 1:index1 
% 
%         C_gas_z   = C_gas(i,:);
%         C_solid_z = C_solid(i,:); 
%         PPT       = partialPressureFcn(C_gas_z);
%         T_z       = T(i);
% % -------------------------------------------------------------------------
%         if     strcmp(id,'CH4')
%                 kinetic(i,1) = R_CH4_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
% 
%         elseif strcmp(id,'CO2')
%                 kinetic(i,1) = R_CO2_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
% 
%         elseif strcmp(id,'CO')
%                 kinetic(i,1) = R_CO_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
% 
%         elseif strcmp(id,'H2')
%                 kinetic(i,1) = R_H2_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%     
%         elseif strcmp(id,'H2O')
%                 kinetic(i,1) = R_H2O_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%           
%         elseif strcmp(id,'NiO')
%                 kinetic(i,1) = R_NiO_Fcn(C_gas_z,C_solid_z,T_z,data);
%             
%         elseif strcmp(id,'Ni')
%                 kinetic(i,1) = R_Ni_Fcn(C_gas_z,C_solid_z,T_z,data);
%          
%         elseif strcmp(id,'C')
%                 kinetic(i,1) = R_C_Fcn(C_solid_z,PPT,T_z, data);
%            
%         elseif strcmp(id,'N2')||strcmp(id,'N2_lp')
%                 kinetic(i,1) = 0.0;
% 
%         elseif strcmp(id,'CH4_lp')
% %                 kinetic(i,1) = R_CH4_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'CO2_lp')
% %                 kinetic(i,1) = R_CO2_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'CO_lp')
% %                 kinetic(i,1) = R_CO_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'H2_lp') 
% %                 kinetic(i,1) = R_H2_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'H2O_lp')
% %                 kinetic(i,1) = R_H2O_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'NiO_lp')
% %                 kinetic(i,1) = R_NiO_Fcn(C_gas_z,C_solid_z,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'Ni_lp')
% %                 kinetic(i,1) = R_Ni_Fcn(C_gas_z,C_solid_z,T_z,data);
%                 kinetic(i,1) = 0.0;
%         elseif strcmp(id,'C_lp')
% %                 kinetic(i,1) = R_C_Fcn(C_solid_z,PPT,T_z, data);
%                 kinetic(i,1) = 0.0;
%         else
%             disp('CineticaFcn.m error')
%         end 
% % -------------------------------------------------------------------------
%     end                     
% ------------------------------------------------------------------------- 
end
