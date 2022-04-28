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

N = 7838

% corrente da simulação

I = 1 % A

% definindo geometria

%      LEGENDA DE MEDIDAS
%
%        a      c      b
%       ___  f ___  f ___         N3
%  e { |   |__|   |__|   | } d    N2
%    { |                 |
%    { |_________________|        N1

% geometria de armardura inferior

a_i = 8.6;
b_i = a_i;
c_i = 10.4;
d_i = 4.6;
e_i = 15.8;
f_i = a_i;

% definindo pontos e ligando pontos por Nível

% N1

p1 = point(1, 1);

y_N1 = p1.y;

p2 = point(p1.x+5*f_i, y_N1);
mi_drawline(p1.x, p1.y, p2.x, p2.y);

% N2

y_N2 = p1.y + d_i;

p3 = point(p1.x+f_i, y_N2);
p4 = point(p3.x+f_i, y_N2);
p5 = point(p4.x+f_i, y_N2);
p6 = point(p5.x+f_i, y_N2);

drawline(p3, p4);
drawline(p5, p6);

% N3

y_N3 = p1.y + e_i;

p7 = point(p1.x, y_N3);
p8 = point(p7.x+f_i, y_N3);
p9 = point(p8.x+f_i, y_N3);
p10 = point(p9.x+f_i, y_N3);
p11 = point(p10.x+f_i, y_N3);
p12 = point(p11.x+f_i, y_N3);

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

% distancia entre armaduras

d_max = 7;

% geometria armadura superior

a_s = 8.1;
b_s = a_s;
c_s = 9.41;
d_s = 5.0;
e_s = 18.1;
f_s = a_s;

% definindo pontos e ligando pontos por Nível

% N1

p23 = point(p1.x+1.25, p1.y+e_i+e_s+d_max);

y_N1 = p23.y;

p24 = point(p23.x+5*f_s, y_N1);
drawline(p23, p24);

% N2

y_N2 = p23.y - d_s;

p19 = point(p23.x+f_s, y_N2);
p20 = point(p19.x+f_s, y_N2);
p21 = point(p20.x+f_s, y_N2);
p22 = point(p21.x+f_s, y_N2);

drawline(p19, p20);
drawline(p21, p22);

% N3

y_N3 = p23.y - e_s;

p13 = point(p23.x, y_N3);
p14 = point(p13.x+f_s, y_N3);
p15 = point(p14.x+f_s, y_N3);
p16 = point(p15.x+f_s, y_N3);
p17 = point(p16.x+f_s, y_N3);
p18 = point(p17.x+f_s, y_N3);

drawline(p13, p14);
drawline(p13, p23);
drawline(p14, p19);
drawline(p15, p16);
drawline(p15, p20);
drawline(p16, p21);
drawline(p17, p18);
drawline(p17, p22);
drawline(p18, p24);

% definindo grupos de arestas de armadura superior

selectnode(p13);
selectnode(p14);
selectnode(p15);
selectnode(p16);
selectnode(p17);
selectnode(p18);
selectnode(p19);
selectnode(p20);
selectnode(p21);
selectnode(p22);
selectnode(p23);
selectnode(p24);

mi_setnodeprop("armadura_superior", 2);
mi_clearselected;

% definindo seção de enrolamentos

drawline(p14, p8)
drawline(p15, p9)
drawline(p16, p10)
drawline(p17, p11)

% adicionando rótulos de materiais

upper_label = (p20 + p21 + p15 + p16)/4;
mi_addblocklabel(upper_label.x, upper_label.y);

lower_label = (p9 + p10 + p4 + p5)/4;
mi_addblocklabel(lower_label.x, lower_label.y);

positive_circuit_label = (p14 + p8 + p9 + p15)/4;
mi_addblocklabel(positive_circuit_label.x, positive_circuit_label.y);

negative_circuit_label = (p16 + p10 + p11 + p17)/4;
mi_addblocklabel(negative_circuit_label.x, negative_circuit_label.y);

air_labels = {(p7+p8+p13+p14)/4, (p9+p10+p15+p16)/4, (p11+p12+p17+p18)/4}

for i = 1:size(air_labels)(2)-1
    label = air_labels{i};
    mi_addblocklabel(label.x, label.y);
end

% adicionando materiais

mi_getmaterial("Air");
mi_getmaterial("M-15 Steel");
mi_getmaterial("16 AWG");

% criando circuito

mi_addcircprop("enrolamentos", I, 1);

% atribuindo materiais e propriedades

mi_selectlabel(upper_label.x, upper_label.y);
mi_selectlabel(lower_label.x, lower_label.y);
mi_setblockprop("M-15 Steel", 0, 0, 0, 0, 1, 0); % all blocks belong to group 1
mi_clearselected;

mi_selectlabel(positive_circuit_label.x, positive_circuit_label.y);
mi_setblockprop("16 AWG", 0, 0, "enrolamentos", 0, 1, N);
mi_clearselected;

mi_selectlabel(negative_circuit_label.x, negative_circuit_label.y);
mi_setblockprop("16 AWG", 0, 0, "enrolamentos", 0, 1, -N);
mi_clearselected;

for i = 1:size(air_labels)(2)-1
    label = air_labels{i};
    mi_selectlabel(label.x, label.y);
end
mi_setblockprop("Air", 0, 0, 0, 0, 1, 0); % all blocks belong to group 1
mi_clearselected;

% criando condições de contorno

input("Crie condicao de contorno em interface grafica: os resultados sao mais confiaveis")

% nesse momento é necessário salvar o arquivo - isso não é possível via
% máquina virtual e deve ser feito na mão.

input("Salve o arquivo por meio do FEMM grafico e de ENTER para prosseguir.")

inductances = zeros(1, 6);
mi_selectgroup(1);
mi_movetranslate(0, 1); % sobre 10 mm

mi_analyze;
mi_loadsolution;

for i = 0:5

    i=0;
    mi_analyze;
    mi_loadsolution;

    mo_groupselectblock(1);

    energy = mo_blockintegral(2); % magnetic field energy
    inductance = (2*energy)/(I^2);
    inductances(i+1) = inductance

    mi_selectgroup(1);
    mi_movetranslate(0, 1); % sobre 10 mm

end
