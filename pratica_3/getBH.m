curva = load("CurvaBH.mat");

B = transpose(curva.B_rob);
H = transpose(curva.H_rob);
data = [B H] ;

fileWrite = fopen('textfile.txt','w');
fprintf(fileWrite,'%f %f\n',data');
