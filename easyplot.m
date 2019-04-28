function [] = easyplot()
templateObj = Template()
x=linspace(0,2,5);
y=2.*x;
figure(1);
plot(x,y);
export_fig simple.pdf;
append_pdfs('test.pdf', 'simple.pdf');
append_pdfs('test.pdf', 'simple.pdf');
end