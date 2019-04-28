import mlreportgen.dom.*;

type = 'docx';

% Create a template object
t = Template('mytemplate',type);

% Add a title hole to the template and apply the Title style
hole = append(t,TemplateHole('TITLE'));
hole.Description = ('Title Description');
hole.DefaultHoleStyleName = 'Title';

% Add a paragraph with boilerplate text and apply the Subtitle format
% Position the paragraph and preserve white space in the text 
p = Paragraph('Author: ');
p.StyleName = 'Subtitle';
p.Style = {OuterMargin('0','0','1in','1in')};
p.WhiteSpace = 'preserve';

% Append an inline hole to paragraph  
hole = append(p,TemplateHole('AUTHOR'));
append(t,p);

close(t);