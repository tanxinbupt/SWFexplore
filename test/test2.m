clc;
clear all;
fid=fopen('test9.bin','rb');
%���úø�ʽ�����Ҷ�����
data1=double(fread(fid,'uint8'));
data2=dec2hex(data1);
fclose(fid);
disp(data2);