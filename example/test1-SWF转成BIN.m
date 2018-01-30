clc; 
clear all;
fid=fopen('d:\test9.bin','wb');
fd=fopen('d:\abc.swf','rb');
A=fread(fd,'double');
fwrite(fid,A,'double');
fclose(fid);
fclose(fd);