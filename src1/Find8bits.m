function [y7,y6,y5,y4,y3,y2,y1,y0]=Find8bits(Data)
y0=mod(Data,2);
y7=fix(Data/128);Data=Data-y7*128;
y6=fix(Data/64); Data=Data-y6*64;
y5=fix(Data/32); Data=Data-y5*32;
y4=fix(Data/16); Data=Data-y4*16;
y3=fix(Data/8);  Data=Data-y3*8;
y2=fix(Data/4);  Data=Data-y2*4;
y1=fix(Data/2);  Data=Data-y1*2;
end
