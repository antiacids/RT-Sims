function simtable = readsim(angle,mass,thrust,dir)
%     file = strcat(dir, 's%ga%gm%gn%g.csv'); % For two stage
      file = strcat(dir, 'a%gm%gt%g.CSV');
      simtable = readtable(sprintf(file,angle,mass,thrust));
end