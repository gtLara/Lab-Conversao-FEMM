addpath("../classes"); % se essa pasta não contiver point.m o script não funciona.
addpath("../functions"); % se essa pasta não contiver drawline.m o script não funciona.
openfemm;
newdocument(0);
opendocument("/home/gala/2022-1/lconv/femm/pratica_4/maquina_CC.FEM") % carrega desenho

% probdef:

% Defining number of turns

N_series_field = 23;
N_parallel_field = 3700;
N_interpole = 118;

% Defining current

I = 1;

% Defining geometry - not necessary, drawing already loaded



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creating Materials and Circuits %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



mi_getmaterial("Air");
mi_getmaterial("14 AWG");
mi_getmaterial("18 AWG");
mi_addmaterial("Iron", mu_x=500, mu_y=500);

mi_addcircprop("series_field_windings", I, 1);
mi_addcircprop("parallel_field_windings", I, 1);
mi_addcircprop("interpole_windings", I, 1);
mi_addcircprop("core_windings", I, 1);

%%%%%%%%%%%%%%%%%%%%%%
% Defining Labels    %
%%%%%%%%%%%%%%%%%%%%%%

%   Defining air label

air_label = point(7.4, 0);
air_label = point(17.4, 0);
mi_addblocklabel(air_label.x, air_label.y);
mi_selectlabel(air_label.x, air_label.y);
mi_setblockprop("Air", 0, 0, 0, 0, 3, 0);
mi_clearselected;

%   Defining poles

%       Interpoles

interpole_label = point(8.5, 8.5);
mi_addblocklabel(interpole_label.x, interpole_label.y);
mi_selectlabel(interpole_label.x, interpole_label.y);
mi_setblockprop("Iron", 0, 0, 0, 0, 3, 0);
mi_copyrotate2(0, 0, 90, 3, 2);
mi_clearselected;

%       Poles

pole_label = point(8.5, -1);
mi_addblocklabel(pole_label.x, pole_label.y);
mi_selectlabel(pole_label.x, pole_label.y);
mi_setblockprop("Iron", 0, 0, 0, 0, 3, 0);
mi_copyrotate2(0, 0, 90, 3, 2);
mi_clearselected;

%   Defining circuit labels

%       Series field circuit

series_field_circuit_positive_label = point(-3.8, 11.5);
mi_addblocklabel(series_field_circuit_positive_label.x, series_field_circuit_positive_label.y);
mi_selectlabel(series_field_circuit_positive_label.x, series_field_circuit_positive_label.y);
mi_setblockprop("18 AWG", 0, 0, "series_field_windings", 0, 3, N_series_field);
mi_copyrotate2(0, 0, 180, 1, 2);
mi_clearselected;

series_field_circuit_negative_label = point(+3.8, 11.5);
mi_addblocklabel(series_field_circuit_negative_label.x, series_field_circuit_negative_label.y);
mi_selectlabel(series_field_circuit_negative_label.x, series_field_circuit_negative_label.y);
mi_setblockprop("18 AWG", 0, 0, "series_field_windings", 0, 3, -N_series_field);
mi_copyrotate2(0, 0, 180, 1, 2);
mi_clearselected;

%       Parallel field circuit

parallel_field_circuit_positive_label = point(11.5, -3.8);
mi_addblocklabel(parallel_field_circuit_positive_label.x, parallel_field_circuit_positive_label.y);
mi_selectlabel(parallel_field_circuit_positive_label.x, parallel_field_circuit_positive_label.y);
mi_setblockprop("18 AWG", 0, 0, "parallel_field_windings", 0, 3, N_parallel_field);
mi_copyrotate2(0, 0, 180, 1, 2);
mi_clearselected;

parallel_field_circuit_negative_label = point(11.5, 3.8);
mi_addblocklabel(parallel_field_circuit_negative_label.x, parallel_field_circuit_negative_label.y);
mi_selectlabel(parallel_field_circuit_negative_label.x, parallel_field_circuit_negative_label.y);
mi_setblockprop("18 AWG", 0, 0, "parallel_field_windings", 0, 3, -N_parallel_field);
mi_copyrotate2(0, 0, 180, 1, 2);
mi_clearselected;

%       Interpole circuit

interpole_circuit_positive_label = point(8, 10);
mi_addblocklabel(interpole_circuit_positive_label.x, interpole_circuit_positive_label.y);
mi_selectlabel(interpole_circuit_positive_label.x, interpole_circuit_positive_label.y);
mi_setblockprop("18 AWG", 0, 0, "interpole_windings", 0, 3, N_interpole);
mi_copyrotate2(0, 0, 90, 3, 2);
mi_clearselected;

interpole_circuit_negative_label = point(10, 8);
mi_addblocklabel(interpole_circuit_negative_label.x, interpole_circuit_negative_label.y);
mi_selectlabel(interpole_circuit_negative_label.x, interpole_circuit_negative_label.y);
mi_setblockprop("18 AWG", 0, 0, "interpole_windings", 0, 3, -N_interpole);
mi_copyrotate2(0, 0, 90, 3, 2);
mi_clearselected;

%       Core Circuit

core_circuit_1_label = point(6.32, 0);
mi_addblocklabel(core_circuit_1_label.x, core_circuit_1_label.y);
mi_selectlabel(core_circuit_1_label.x, core_circuit_1_label.y);
mi_setblockprop("14 AWG", 0, 0, 0, "core_circuit", 3, 1);
mi_copyrotate2(0, 0, 45, 7, 2);
mi_clearselected;

% Core

core_label = point(0, 0);
mi_addblocklabel(core_label.x, core_label.y);
mi_selectlabel(core_label.x, core_label.y);
mi_setblockprop("Iron", 0, 0, 0, 0, 3, 0);
mi_clearselected;

% Armature

armature_label = point(14, 0);
mi_addblocklabel(armature_label.x, armature_label.y);
mi_selectlabel(armature_label.x, armature_label.y);
mi_setblockprop("Iron", 0, 0, 0, 0, 3, 0);
mi_clearselected;

% Creating countour conditions graphically

input("Crie condicao de contorno em interface grafica: os resultados sao mais confiaveis")

input("Salve o arquivo por meio do FEMM grafico e de ENTER para prosseguir.")

% Analyzing solution

% PROBLEM: FEMM cannot load mesh on drawing on virtual wine machine
% must try on windows machine

mi_analyze;
mi_loadsolution;

% Inductances

series_field_inductance = mo_getcircuitproperties("series_field_windings")(3)/I
parallel_field_inductance = mo_getcircuitproperties("parallel_field_windings")(3)/I
interpole_inductance = mo_getcircuitproperties("interpole_windings")(3)/I

% Torque: how?
