clear all
close all
clc
% Datos de entrada
H = 1; % Altura del reactor [m]
D = 0.3; % Diámetro del reactor [m]
G = 50; % Flujo másico del gas [kg/m^2s]
W = 25; % Flujo másico de las partículas [kg/m^2s]
rhog = 0.5; % Densidad del gas [kg/m^3]
rhos = 2000; % Densidad de las partículas [kg/m^3]
dp = 0.001; % Diámetro de las partículas [m]
phi0 = 0.4; % Fracción de vacíos del lecho en el fondo del reactor
epsilon = 0.4; % Porosidad del lecho
mu = 1.8e-5; % Viscosidad del gas [Pa·s]

% Cálculo de la velocidad superficial del gas a lo largo de la altura del reactor
z = linspace(0,H,100); % Vector con las alturas a lo largo del reactor
L = H./phi0; % Altura del lecho
phi = phi0.*ones(size(z)); % Vector con la fracción de vacíos del lecho a lo largo del reactor
Re = (G.*dp)./mu; % Número de Reynolds del gas
C1 = 150; % Constante empírica
C2 = 1.75; % Constante empírica
C3 = 1.5; % Constante empírica
C4 = 2; % Constante empírica
C5 = 1; % Constante empírica
ug = G./(rhog.*phi); % Velocidad superficial del gas
tau = (ug.^2)./((1-phi).^2); % Tensión cortante del gas
dp2 = dp.*(1-phi)./phi; % Diámetro efectivo de las partículas
up = W./(rhos.*pi.*(dp.^2)./4); % Velocidad de las partículas
Rep = (up.*dp2)./mu; % Número de Reynolds de las partículas
Cd = (1-phi).^2.*(C1+C2.*Rep+C3.*Rep.^2)./((dp./dp2).*Rep.^C4+C5.*Rep.^2); % Coeficiente de arrastre
dP = (150.*tau.*(1-phi).^2+1.75.*rhog.*phi.*ug.^2)./((1-phi).^3.*dp.^2.*epsilon.^3)+1.5.*Cd.*rhog.*ug.^2./(dp.*epsilon.^3); % Pérdida de presión
dP0 = dP(end); % Pérdida de presión en la salida del reactor
ug = sqrt((dP-dP0).*((1-phi).^3.*dp.^2.*epsilon.^3)./((150.*(1-phi).^2.*tau+1.75.*rhog.*phi.*ug.^2))); % Nueva velocidad superficial del gas

% Gráfico de la velocidad superficial del gas a lo largo del reactor
figure
plot(z,ug,'LineWidth',2)
xlabel('Altura del reactor [m]')
ylabel('Velocidad superficial del gas [m/s]')
