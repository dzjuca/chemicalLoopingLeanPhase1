function densityGasMix = densityGasMixFcn(Cgas, T, Global)

    MM     = Global.MMG;
    [~, n] = size(Cgas);
    fld    = fieldnames(MM);
    mMolar = zeros(1,n);

    for i = 1:n
        mMolar(i) = MM.(fld{i});
    end

    % ----
    P   = Global.P_atm;
    R   = Global.R_atm;
    y_i = molarFractionFcn(Cgas);

    densityGasMix = (P.*sum(y_i.* mMolar,2)./(R.*T))./1000; % ==== g/cm3

    % ---
    %% densityGasMix(:,1) = 1.2e-3;

end