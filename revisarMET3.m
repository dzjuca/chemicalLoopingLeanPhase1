% Parámetros del reactor
D = 0.3; % diámetro del reactor (m)
L = 5; % longitud del reactor (m)
Vf = pi/4*D^2*L; % volumen del reactor (m^3)
A = pi/4*D^2; % área transversal del reactor (m^2)
G0 = 100; % flujo másico de gas inicial (kg/m^2s)
rho0 = 1.2; % densidad del gas a la entrada del reactor (kg/m^3)
P0 = 101325; % presión del gas a la entrada del reactor (Pa)
T0 = 298; % temperatura del gas a la entrada del reactor (K)
eps = 0.4; % fracción de vacío del lecho fluidizado
dp = 0.0005; % diámetro de partícula promedio (m)
phi = 0.4; % fracción volumétrica de partículas en el lecho

% Parámetros del modelo
nt = 100; % número de pasos de tiempo
dt = 0.1; % tamaño del paso de tiempo (s)
dz = L/nt; % tamaño de la celda espacial (m)
tol = 1e-6; % tolerancia para la convergencia
maxit = 100; % número máximo de iteraciones

% Inicialización de variables
G = zeros(nt+1,1); % flujo másico de gas (kg/m^2s)
rho = zeros(nt+1,1); % densidad del gas (kg/m^3)
P = zeros(nt+1,1); % presión del gas (Pa)
T = zeros(nt+1,1); % temperatura del gas (K)
u = zeros(nt+1,1); % velocidad del gas (m/s)

% Condiciones iniciales
G(1) = G0;
rho(1) = rho0;
P(1) = P0;
T(1) = T0;
u(1) = G(1)/(rho(1)*A);

% Resolución de las ecuaciones de continuidad y momentum
for i = 1:nt
    % Cálculo de la velocidad del gas
    u(i+1) = G(i)/(rho(i)*A*(1-eps));
    
    % Cálculo de la densidad del gas
    rho(i+1) = P(i)/(287*T(i));
    
    % Cálculo de la caída de presión por fricción
    Re = rho(i+1)*u(i+1)*dp/(1.8e-5);
    f = 0.046/(Re^0.2);
    deltaPf = f*rho(i+1)*u(i+1)^2*L/(2*D);
    
    % Cálculo de la caída de presión por expansión
    deltaPe = eps*rho(i+1)*u(i+1)^2/(2*(1-eps));
    
    % Cálculo de la caída de presión total
    deltaP = deltaPf + deltaPe;
    P(i+1) = P(i) - deltaP;
    
    % Cálculo de la temperatura del gas
