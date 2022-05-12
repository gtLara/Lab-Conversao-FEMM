curve = load("NO30-16-HP.mat").HB;

write_file = fopen('curve.txt','w');
fprintf(write_file,'%f %f\n',curve');
