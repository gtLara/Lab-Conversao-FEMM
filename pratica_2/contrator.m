openfemm;
newdocument(0);

% definindo problema

% definindo geometria

% desenhando pontos

% adicionando rótulos de materiais

% criando materiais

% atribuindo materiais e propriedades

% criando condições de contorno

input("Crie condição de contorno em interface gráfica: os resultados são mais confiáveis")

% nesse momento é necessário salvar o arquivo - isso não é possível via
% máquina virtual e deve ser feito na mão.

input("Salve o arquivo por meio do FEMM gráfico e dê ENTER para prosseguir.")

mi_analyze;
mi_loadsolution;

mo_groupselectblock(1) % grupo parte superior do atrator
mo_groupselectblock(2) % grupo parte inferior do atrator

%etc

energy = mo_blockintegral(2); % magnetic field energy
inductance = (2*energy)/(I^2);
display(inductance);

% move parte inferior, repete cálculo
