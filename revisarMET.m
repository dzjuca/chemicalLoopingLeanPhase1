% Parámetros del reactor
T0 = 773;           % Temperatura inicial [K]
P0 = 5e5;           % Presión inicial [Pa]
V0 = 1;             % Volumen inicial [m^3]
m0 = 10;            % Masa inicial de gas [kg]
cat_area = 50;      % Área superficial del catalizador [m^2/m^3]
e = 0.4;            % Fracción de vacíos del lecho
rho_s = 2500;       % Densidad de sólidos [kg/m^3]
rho_g = P0 / (8.314 * T0); % Densidad de gas [kg/m^3]
dp = 200e-6;        % Diámetro de partícula [m]
epsilon = 0.4;      % Coeficiente de restitución
V_dot = 0.1;        % Caudal volumétrico de entrada de gas [m^3/s]

% Condiciones iniciales
y0 = [T0; P0; V0; m0];

% Intervalo de integración
tspan = [0 100];

% Función que representa el modelo de equilibrio termodinámico en el reactor
f = @(t, y) [(-cat_area * y(4) / (e * rho_s * (1 - e)^2 * dp^2) * (y(1) - T0) + V_dot * (y(2) - P0) / (y(3) * rho_g * (1 - e))); ...
             (V_dot - cat_area * y(4) / (e * rho_s * (1 - e)^2 * dp^2) * y(2) / (8.314 * y(1))); ...
             (V_dot - cat_area * y(4) / (e * rho_s * (1 - e)^2 * dp^2)); ...
             (-cat_area / (e * rho_s * (1 - e) * dp^2) * y(4) * (y(2) / (8.314 * y(1)) - P0 / (8.314 * T0)))];

% Opciones del solver ode15s
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);

% Integración numérica con ode15s
[t, y] = ode15s(f, tspan, y0, options);

% Impresión de resultados
figure;
subplot(2,2,1);
plot(t, y(:,1));
xlabel('Tiempo [s]');
ylabel('Temperatura [K]');
subplot(2,2,2);
plot(t, y(:,2));
xlabel('Tiempo [s]');
ylabel('Presión [Pa]');
subplot(2,2,3);
plot(t, y(:,3));
xlabel('Tiempo [s]');
ylabel('Volumen [m^3]');
subplot(2,2,4);
plot(t, y(:,4));
xlabel('Tiempo [s]');
ylabel('Masa [kg]');
