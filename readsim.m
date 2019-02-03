function simtable = readsim(angle,mass,thrust,dir)
%     file = strcat(dir, 's%ga%gm%gn%g.csv'); % For two stage
      file = strcat(dir, 'a%gm%gt%g.CSV');
      simtable = readtable(sprintf(file,angle,mass,thrust));
      %simtable=simtable1(1:900,:);
      %simtable=simtable1(1:6760,:);
end