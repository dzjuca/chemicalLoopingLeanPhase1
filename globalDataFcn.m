function Global = globalDataFcn()
% -------------------------------------------------------------------------
      % globalData-function return a structure 'Global' with data constants
% -------------------------------------------------------------------------
% -------------------- | General Data |------------------------------------
      Global.R = 8.314472e-3;         % Universal Gas Constant    [kJ/molK]    
      Global.P = 1.01325;             % Pressure                      [bar]  
      Global.P_atm = 1;               % Pressure                      [atm]  
      Global.R_atm = 0.08206;         % Universal Gas Constant [atm L/molK]
      Global.Tbed    = (623 + 273.15);% Temperature                     [K]
      Global.g       = 981.0;         % Gravity                     [cm/s2]
      Global.Num_esp_1 = 18;          % number of species               [#]
      Global.Num_esp_2 = 9;           % number of species               [#]
      Global.gen     = 6;             % gas species number              [#]
      Global.sen     = 3;             % solid species number            [#]
      Global.iterations = Iterations.getInstance();% number of iterations
      Global.n1      = 40;            % mesh points number              [#] 
      Global.n2      = 60;            % mesh points number              [#]
      Global.nt      = Global.n1 + Global.n2; % total mesh points number[#]
% ---------- thermal conductivity - constant E ---------------------------- 
      Global.E = 1;                  %   E - numeral constant near to 1  []
      Global.k_factor = 0;           %   k - factor correction           [] 
% ----------| Flow rate and concentration of species |---------------------
% ----- total feed flow in the reactor's bottom ---------------------------
      Global.QT_in = 1200;            %  condicion_1           [STP ml/min]
% ----- flow feed ratio for each specie -----------------------------------
      CH4in_rat = 50.0;               % CH4                             [%]
      N2in_rat  = 50.0;               % N2                              [%]
% ----- flow feed for each specie -----------------------------------------
      FCH4in = (CH4in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
      FN2in  = ( N2in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
% ----- feed concentration for each specie --------------------------------
      Global.CH4in = (FCH4in*60/Global.QT_in); %                  [mol/cm3]
      Global.N2in  = ( FN2in*60/Global.QT_in); %                  [mol/cm3]

      if (Global.QT_in == 0) 
          Global.CH4in =  0;  
          Global.N2in  =  0;  
      end
% ---------- reactor constant data  ---------------------------------------
      Global.reactor.rID     = 4.6;% internal diameter of the reactor  [cm]
      Global.reactor.rID_2   = 4.6;% internal diameter of the reactor  [cm]
      Global.reactor.bHeight = 23; % bed height                        [cm]
      Global.reactor.rHeight = 94; % reactor height                    [cm]
      Global.reactor.rArea1   = pi*(Global.reactor.rID/2)^2; % area    [cm2]
      Global.reactor.z1      = linspace(0,                       ...
                                    Global.reactor.bHeight,      ...
                                    Global.n1)'; % mesh                [cm]
      Global.reactor.z2      = linspace(Global.reactor.bHeight,  ...
                                        Global.reactor.rHeight,  ...
                                        Global.n2)'; % mesh2           [cm]
% ---------- fluid Dynamics -----------------------------------------------
      Global.fDynamics.usg0 = Global.QT_in./...
                              (Global.reactor.rArea1*60.0); 
                                     % In-Flow rate                  [cm/s]
      Global.fDynamics.usg0_umf = 5; % ratio usg0/umf                    []
      Global.fDynamics.umf  = Global.fDynamics.usg0/... 
                              Global.fDynamics.usg0_umf;
                              % minimum fluidization velocity        [cm/s] 
      Global.fDynamics.fw   = 0.15;% fraction of wake in bubbles         []
      Global.fDynamics.Emf  = 0.45;% minimum fluidization porosity       []
% ---------- Carrier Data -------------------------------------------------
      Global.carrier.R       = 8.314472;  % Universal Gas Constant [J/molK] 
      Global.carrier.a0      = 1020000;   % specific surface area   [cm2/g]
      Global.carrier.C_NiO_o = 0.14;      % NiO concentration    [gNiO/g-c]=== 0.08
      Global.carrier.load    = 300;   % catalyst weight                 [g]
      Global.carrier.dp          = 0.014; % particle diameter          [cm]
      Global.carrier.bulkDensity = 1.1;   % particle density        [g/cm3]
      Global.carrier.density     = 0.785; % particle density        [g/cm3]
      Global.carrier.sphericity  = 0.95;  % particle sphericity          []
% ---------- molar mass for each specie -----------------------------------
      Global.MMASS(1) = 16.0426;      % - CH4                       [g/mol]
      Global.MMASS(2) = 44.0090;      % - CO2                       [g/mol]
      Global.MMASS(3) = 28.0100;      % - CO                        [g/mol]
      Global.MMASS(4) = 2.01580;      % - H2                        [g/mol]
      Global.MMASS(5) = 18.0148;      % - H2O                       [g/mol]
      Global.MMASS(6) = 28.0140;      % - N2                        [g/mol] 
% ---------- Potentials for each compound - LENNARD-JONES -----------------
      Global.SIGMA(1) = 3.758;        % - CH4                           [A]
      Global.SIGMA(2) = 3.941;        % - CO2                           [A]
      Global.SIGMA(3) = 3.690;        % - CO                            [A]
      Global.SIGMA(4) = 2.827;        % - H2                            [A]
      Global.SIGMA(5) = 2.641;        % - H2O                           [A]
      Global.SIGMA(6) = 3.798;        % - N2                            [A]
      Global.EK(1)    = 148.6;        % - CH4                           [K]
      Global.EK(2)    = 195.2;        % - CO2                           [K]
      Global.EK(3)    = 91.70;        % - CO                            [K]
      Global.EK(4)    = 59.70;        % - H2                            [K]
      Global.EK(5)    = 809.1;        % - H2O                           [K]
      Global.EK(6)    = 71.40;        % - N2                            [K]
% -------------------------------------------------------------------------
% ---------| viscosity constants data |------------------------------------
% ---------- experimental temperature was used to determine Tc and Pc -----
      Global.Tb.CH4 = 111.66;        % - CH4                            [K] 
      Global.Tb.CO2 = 81.660;        % - CO2                            [K] # pendiente revisar el valor (no existe en las tablas)
      Global.Tb.CO  = 81.660;        % - CO                             [K] 
      Global.Tb.H2  = 20.270;        % - H2                             [K] 
      Global.Tb.H2O = 373.15;        % - H2O                            [K] 
      Global.Tb.N2  = 77.350;        % - N2                             [K] 
% ---------- volume, critical constant for each specie --------------------
      Global.Vc.CH4 = 98.600;        % - CH4                      [cm3/mol]
      Global.Vc.CO2 = 94.070;        % - CO2                      [cm3/mol]
      Global.Vc.CO  = 93.100;        % - CO                       [cm3/mol]
      Global.Vc.H2  = 64.200;        % - H2                       [cm3/mol]
      Global.Vc.H2O = 55.950;        % - H2O                      [cm3/mol]
      Global.Vc.N2  = 90.100;        % - N2                       [cm3/mol]
% ---------- dipole moment for each specie --------------------------------
      Global.Mu.CH4 = 0.00;          % CH4                         [debyes]
      Global.Mu.CO2 = 0.00;          % CO2                         [debyes]
      Global.Mu.CO  = 0.10;          % CO                          [debyes]
      Global.Mu.H2  = 0.00;          % H2                          [debyes]
      Global.Mu.H2O = 1.80;          % H2O                         [debyes]
      Global.Mu.N2  = 0.00;          % N2                          [debyes]
% ---------- molar mass for each specie -----------------------------------
      Global.MMG.CH4 = 16.0426;      % - CH4                        [g/mol]
      Global.MMG.CO2 = 44.0090;      % - CO2                        [g/mol]
      Global.MMG.CO  = 28.0100;      % - CO                         [g/mol]
      Global.MMG.H2  = 2.01580;      % - H2                         [g/mol]
      Global.MMG.H2O = 18.0148;      % - H2O                        [g/mol]
      Global.MMG.N2  = 28.0140;      % - N2                         [g/mol]
      Global.MMS.NiO = 74.7100;      % - NiO(s)                     [g/mol]  
      Global.MMS.Ni  = 58.7100;      % - Ni(s)                      [g/mol]   
      Global.MMS.C   = 12.0110;      % - C(s)                       [g/mol]   
% ---------- temperature for each specie - critical constant --------------
      Global.Tcr.CH4 = 190.56;       % - CH4                            [K]
      Global.Tcr.CO2 = 304.12;       % - CO2                            [K]
      Global.Tcr.CO  = 132.85;       % - CO                             [K]
      Global.Tcr.H2  = 32.980;       % - H2                             [K]
      Global.Tcr.H2O = 647.14;       % - H2O                            [K]
      Global.Tcr.N2  = 126.20;       % - N2                             [K]
% ---------- pressure for each specie - critical constant -----------------
      Global.Pcr.CH4 = 45.990;       % - CH4                          [bar]
      Global.Pcr.CO2 = 73.740;       % - CO2                          [bar]
      Global.Pcr.CO  = 34.940;       % - CO                           [bar]
      Global.Pcr.H2  = 12.930;       % - H2                           [bar]
      Global.Pcr.H2O = 220.64;       % - H2O                          [bar]
      Global.Pcr.N2  = 33.980;       % - N2                           [bar]
end