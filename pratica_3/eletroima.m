%TODO: add coils
%TODO: simulate

% adicionando caminho para classe point
addpath("../classes") % se essa pasta não contiver point.m o script não funciona.
addpath("../functions") % se essa pasta não contiver drawline.m o script não funciona.
openfemm;
newdocument(0);

% definindo problema

mi_probdef(0, "millimeters", "planar", 1e-8, 0, 30);

% numero de voltas

N = 80

% corrente da simulação

I = 1.5 % A

% definindo geometria

%      LEGENDA DE MEDIDAS
%
%        a      c      b
%       __  f ___  f __         N3
%    { |  |  |   |  |  |        N2
%  e { |  |__|   |__|  |
%    { |_______________| } d    N1

% geometria de armardura inferior

a_i = 35.6;
b_i = a_i;
c_i = 71;
e_i = 140.4;
d_i = 35.2;
f_i = 34.3;

% definindo pontos e ligando pontos por Nível

% N1

p1 = point(1, 1);

y_N1 = p1.y;

p2 = point( (p1.x + (a_i + b_i + c_i + 2*f_i)) , y_N1);
mi_drawline(p1.x, p1.y, p2.x, p2.y);

% N2

y_N2 = p1.y + d_i;

p3 = point(p1.x+a_i, y_N2);
p4 = point(p3.x+f_i, y_N2);
p5 = point(p4.x+c_i, y_N2);
p6 = point(p5.x+f_i, y_N2);

drawline(p3, p4);
drawline(p5, p6);

% N3

y_N3 = p1.y + e_i;

p7 = point(p1.x, y_N3);
p8 = point(p7.x+a_i, y_N3);
p9 = point(p8.x+f_i, y_N3);
p10 = point(p9.x+c_i, y_N3);
p11 = point(p10.x+f_i, y_N3);
p12 = point(p11.x+b_i, y_N3);

drawline(p7, p8);
drawline(p7, p1);
drawline(p8, p3);
drawline(p9, p10);
drawline(p9, p4);
drawline(p10, p5);
drawline(p11, p6);
drawline(p11, p12);
drawline(p12, p2);

% definindo grupos de arestas de armadura inferior

selectnode(p1);
selectnode(p2);
selectnode(p3);
selectnode(p4);
selectnode(p5);
selectnode(p6);
selectnode(p7);
selectnode(p8);
selectnode(p9);
selectnode(p10);
selectnode(p11);
selectnode(p12);

mi_setnodeprop("armadura_inferior", 1);
mi_clearselected;

% Definicao da geometria do papel
espessura_papel = 1

p17 = point((p4.x - espessura_papel), y_N2);
p18 = point((p5.x + espessura_papel), y_N2);
p19 = point((p9.x - espessura_papel), y_N3);
p20 = point((p10.x + espessura_papel), y_N3);

drawline(p19, p9);
drawline(p10, p20);
drawline(p19, p17);
drawline(p20, p18);

% Definicao da geometria da bobina
espessura_fio = 2

p21 = point((p4.x - espessura_fio - espessura_papel), y_N2);
p22 = point((p5.x + espessura_fio + espessura_papel), y_N2);
p23 = point((p9.x - espessura_fio - espessura_papel), y_N3);
p24 = point((p10.x + espessura_fio + espessura_papel), y_N3);

drawline(p23, p19);
drawline(p20, p24);
drawline(p23, p21);
drawline(p24, p22);

% distancia entre armaduras
d_max = .5;

% Definicoes da barra de metal
h = 35.8;
p13 = point(p7.x, (p7.y + d_max) );
p14 = point(p12.x, (p12.y + d_max) );

p15 = point(p13.x, (p13.y + h) );
p16 = point(p14.x, (p14.y + h) );

drawline(p13, p14);
drawline(p15, p16);
drawline(p13, p15);
drawline(p14, p16);


% material Labels 
upper_label = (p13 + p14 + p15 + p16)/4;
mi_addblocklabel(upper_label.x, upper_label.y);

lower_label = (p9 + p10 + p4 + p5)/4;
mi_addblocklabel(lower_label.x, lower_label.y);

% paper
positive_paper_label = (p17 + p4 + p19 + p9)/4;
mi_addblocklabel(positive_paper_label.x, positive_paper_label.y);

negative_paper_label = (p5 + p18 + p10 + p20)/4;
mi_addblocklabel(negative_paper_label.x, negative_paper_label.y);

% circuit
positive_circuit_label = (p21 + p17 + p23 + p19)/4;
mi_addblocklabel(positive_circuit_label.x, positive_circuit_label.y);

negative_circuit_label = (p18 + p22 + p20 + p24)/4;
mi_addblocklabel(negative_circuit_label.x, negative_circuit_label.y);

% air
air_label = point((p1.x - 0.5), ((p7.y + p13.y)/2));
mi_addblocklabel(air_label.x, air_label.y);

% adicionando materiais
mi_getmaterial("Air");
mi_getmaterial("FeSi");
mi_getmaterial("18 AWG");

% criando circuito

mi_addcircprop("enrolamentos", I, 1);

% atribuindo materiais e propriedades

input("Crie um materal FeSi");

mi_selectlabel(upper_label.x, upper_label.y);
mi_selectlabel(lower_label.x, lower_label.y);
mi_setblockprop("FeSi", 0, 0, 0, 0, 3, 0); % all blocks belong to group 3
mi_clearselected;

mi_selectlabel(positive_circuit_label.x, positive_circuit_label.y);
mi_setblockprop("18 AWG", 0, 0, "enrolamentos", 0, 3, N);
mi_clearselected;

mi_selectlabel(negative_circuit_label.x, negative_circuit_label.y);
mi_setblockprop("18 AWG", 0, 0, "enrolamentos", 0, 3, -N);
mi_clearselected;

mi_selectlabel(air_label.x, air_label.y);
mi_setblockprop("Air", 0, 0, 0, 0, 3, 0);
mi_clearselected;

mi_selectlabel(negative_paper_label.x, negative_paper_label.y);
mi_setblockprop("Air", 0, 0, 0, 0, 3, 0);
mi_clearselected;

mi_selectlabel(positive_circuit_label.x, positive_circuit_label.y);
mi_setblockprop("Air", 0, 0, 0, 0, 3, 0);
mi_clearselected;

%% criando condições de contorno
%
%input("Crie condicao de contorno em interface grafica: os resultados sao mais confiaveis")
%
%% nesse momento é necessário salvar o arquivo - isso não é possível via
%% máquina virtual e deve ser feito na mão.
%
%input("Salve o arquivo por meio do FEMM grafico e de ENTER para prosseguir.")
%
%inductances = zeros(1, 6);
%
%for i = 0:5
%
%    mi_analyze;
%    mi_loadsolution;
%
%    inductance = mo_getcircuitproperties("enrolamentos")(3);
%    inductances(i+1) = inductance;
%
%    mi_selectgroup(1);
%    mi_selectgroup(3);
%    mi_movetranslate(0, 1); % sobre 10 mm
%    mi_clearselected;
%
%end
