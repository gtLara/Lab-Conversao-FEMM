addpath("../classes"); % se essa pasta não contiver point.m o script não funciona.
addpath("../functions"); % se essa pasta não contiver drawline.m o script não funciona.
openfemm;
newdocument(0);
opendocument("/home/gala/2022-1/lconv/femm/pratica_4/maquina_CC.FEM") % carrega desenho

% probdef:

% Defining number of turns

N_series_field = 23
N_parallel_field = 3700
N_interpole = 118

% Defining current

I = 1

% Defining geometry - not necessary, drawing already loaded



%%%%%%%%%%%%%%%%%%%%%%
% Creating Materials %
%%%%%%%%%%%%%%%%%%%%%%



mi_getmaterial("Air");
mi_getmaterial("14 AWG");
mi_addmaterial("Iron", mu_x=500, mu_y=500)

%%%%%%%%%%%%%%%%%%%%%%
% Defining Labels    %
%%%%%%%%%%%%%%%%%%%%%%

%   Defining air label

air_label = point(7.4, 0);
mi_addblocklabel(air_label.x, air_label.y)

%   Defining poles

%       Interpoles

interpole_label = point(8.5, 8.5);
mi_addblocklabel(interpole_label.x, interpole_label.y)
mi_selectlabel(interpole_label.x, interpole_label.y);
mi_copyrotate(0, 0, 90, 3);

%       Poles

pole_label = point(8.5, -1);
mi_addblocklabel(pole_label.x, pole_label.y)
mi_selectlabel(pole_label.x, pole_label.y);
mi_copyrotate(0, 0, 90, 3);

%   Defining circuit labels

%       Series field circuit

%       Parallel field circuit

%       Interpole circuit

%       Core Circuit

core_circuit_1_label = point(6.32, 0);
mi_addblocklabel(core_circuit_1_label.x, core_circuit_1_label.y);
mi_selectlabel(core_circuit_1_label.x, core_circuit_1_label.y);
mi_copyrotate(0, 0, 45, 7);

% Core

core_label = point(0, 0);
mi_addblocklabel(core_label.x, core_label.y);

% circunferência maior = armadura

% polo menorzinho = interpolo

% polo maior = polo



%%%%%%%%%%%%%%%%%%%%%%
% Atribuindo Rótulos %
%%%%%%%%%%%%%%%%%%%%%%



% Attributing material labels

%   Attributing air label

mi_selectlabel(air_label.x, air_label.y);
mi_setblockprop("Air", 0, 0, 0, 0, 3, 0);

%   Attributing circuit labels

%       Series field circuit

%       Parallel field circuit

%       Interpole circuit

%       Core circuit

mi_selectlabel(core_circuit_1_label.x, core_circuit_1_label.y);
mi_setblockprop("14 AWG", 0, 0, 0, "core_circuit", 3, 1);

% Core

mi_selectlabel(core_label.x, core_label.y);
mi_setblockprop("Iron", 0, 0, 0, 0, 3, 0);

% Creating countour conditions graphically

% input("Crie condicao de contorno em interface grafica: os resultados sao mais confiaveis")

% input("Salve o arquivo por meio do FEMM grafico e de ENTER para prosseguir.")

% % Analyzing solution

% mi_analyze;
% mi_loadsolution;

% % Inductances

% series_field_inductance = mo_getcircuitproperties("series_field_windings")(3)/I
% parallel_field_inductance = mo_getcircuitproperties("parallel_field_windings")(3)/I
% interpole_inductance = mo_getcircuitproperties("interpole_windings")(3)/I

% % Torque
