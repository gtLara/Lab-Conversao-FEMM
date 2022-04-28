% adicionando caminho para classe point
addpath("../classes") % se essa pasta não contiver point.m o script não funciona.
addpath("../functions") % se essa pasta não contiver drawline.m o script não funciona.
openfemm;
newdocument(0);

% definindo problema

mi_probdef(0, "millimeters", "planar", 1e-8, 0, 30);

% definindo geometria

%      LEGENDA DE MEDIDAS
%
%        a      c      b
%       ___  f ___  f ___         N3
%  e { |   |__|   |__|   | } d    N2
%    { |                 |
%    { |_________________|        N1

% geometria de armardura inferior

a_i = 86;
b_i = a_i;
c_i = 104;
d_i = 46;
e_i = 158;
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

% distancia entre armaduras

d_max = 70;

% geometria armadura superior

a_s = 81;
b_s = a_s;
c_s = 941;
d_s = 50;
e_s = 181;
f_s = a_s;

% definindo pontos e ligando pontos por Nível

% N1

p23 = point(p1.x+12.5, p1.y+e_i+e_s+d_max);

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

% definindo grupos de arestas de armadura inferior

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

% adicionando rótulos de materiais

upper_label = (p20 + p21 + p15 + p16)/4;
mi_addblocklabel(upper_label.x, upper_label.y);

lower_label = (p9 + p10 + p4 + p5)/4;
mi_addblocklabel(lower_label.x, lower_label.y);

air_labels = {(p7+p8+p13+p14)/4, (p9+p10+p15+p16)/4, (p11+p12+p17+p18)/4}
for i = 1:size(air_labels)(1)
    label = air_labels{i};
    mi_addblocklabel(label.x, label.y);
end

% criando materiais

% atribuindo materiais e propriedades

% criando condições de contorno

%input("Crie condição de contorno em interface gráfica: os resultados são mais confiáveis")

%% nesse momento é necessário salvar o arquivo - isso não é possível via
%% máquina virtual e deve ser feito na mão.

%input("Salve o arquivo por meio do FEMM gráfico e dê ENTER para prosseguir.")

%mi_analyze;
%mi_loadsolution;

%mo_groupselectblock(1) % grupo parte superior do atrator
%mo_groupselectblock(2) % grupo parte inferior do atrator

%%etc

%energy = mo_blockintegral(2); % magnetic field energy
%inductance = (2*energy)/(I^2);
%display(inductance);

% move parte inferior, repete cálculo
