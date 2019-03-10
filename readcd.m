function [cdtable] = readcd()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
selectedFiles = uigetfile('*.txt', 'Multiselect', 'on')
fileID = fopen(selectedFiles,'r+');
formatSpec = '%d %f';
sizeA = [Inf 12];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
end

