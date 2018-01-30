clc;
clear all;
fid=fopen('test9.bin','rb');
%设置好格式，并且读出来
data1=double(fread(fid,'uint8'));
data2=dec2hex(data1);
fclose(fid);
disp(data2);