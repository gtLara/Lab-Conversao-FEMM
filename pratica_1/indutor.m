openfemm;
newdocument(0);

n = 498;
l = 4.35;
D = 6.248; % cm
I = 1.58; %A

mi_probdef(0, "centimeters", "planar", 1e-8, 0, 30);

% desenhando retângulos

mi_drawrectangle(0, 0, l, l);
mi_drawrectangle(l+D, 0, l+l+D, l);

% adicionando block labels

mi_addblocklabel(l/2, l/2);
mi_addblocklabel(l/2 + l + D, l/2);
mi_addblocklabel((1+D)/2 + l/2, 2*l);;

% adicionando materiais e propriedades

mi_getmaterial("Air");
mi_getmaterial("16 AWG");
mi_addcircprop("enrolamentos", 1.58, 1);

% atribuindo materiais e propriedades

mi_selectlabel(1/2, 1/2);
mi_setblockprop("16 AWG", 0, 0, "enrolamentos", 0, 1, n);
mi_clearselected;

mi_selectlabel(1/2 + D + l, l/2);
mi_setblockprop("16 AWG", 0, 0, "enrolamentos", 0, 1, -n);
mi_clearselected;

mi_selectlabel((1+D)/2 + l/2, 2*l);
mi_setblockprop("Air", 0, 0, 0, 0, 1, 0); % all blocks belong to group 1
mi_clearselected;

% desenhando arco para condições de contorno

mi_drawarc((l + D/2), -3*D + l/2, (l + D/2), 3*D + l/2, 180, 2);
mi_drawarc((l + D/2), 3*D + l/2, (l + D/2), -3*D + l/2, 180, 2);

% criando condição de contorno

mi_addboundprop("U+", 5, 0, 0, 0, 0);
mi_addboundprop("U-", -5, 0, 0, 0, 0);

% atribuindo aos arcos

mi_selectarcsegment(0, 0);
mi_setsegmentprop("U+", 0, 1, 0, 0);
mi_clearselected

mi_selectarcsegment((2*l) + D, 0);;
mi_setsegmentprop("U-", 0, 1, 0, 0);
mi_clearselected

% nesse momento é necessário salvar o arquivo - isso não é possível via
% máquina virtual e deve ser feito na mão.

input("Salve o arquivo por meio do FEMM gráfico e dê ENTER para prosseguir.")

% executando análise

mi_analyze;
mi_loadsolution;

mo_groupselectblock(1)
energy = mo_blockintegral(2); % magnetic field energy
inductance = (2*energy)/(I^2);
display(inductance);
