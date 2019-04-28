% Create a document TitleAuthor that uses the template mytemplate.
rpt = Document('TitleAuthor',type,'mytemplate');
open(rpt);

% Create a loop to cycle through the holes. 
% Append content to each hole.
while(~strcmp(rpt.CurrentHoleId,'#end#'))
    switch(rpt.CurrentHoleId)
        case 'TITLE'
            append(rpt,Paragraph('This Is My Title'));
        case 'AUTHOR'
            append(rpt,'My Name');
    end
    
    moveToNextHole(rpt);
end

% Generate and view the report.
close(rpt);
rptview(rpt.OutputPath)