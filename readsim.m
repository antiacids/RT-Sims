function simtable = readsim(angle,mass,dir)
%     file = strcat(dir, 's%ga%gm%gn%g.csv'); % For two stage
      file = strcat(dir, 'a%gm%g.csv');
      simtable = readtable(sprintf(file,angle,mass));
end