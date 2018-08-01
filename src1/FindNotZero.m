%找出第一个不为零的数位 从最高位(第八位)开始
function posNzreo=FindNotZero(y7,y6,y5,y4,y3,y2,y1,y0)
if y7~=0      posNzreo=8;
elseif y6~=0  posNzreo=7;
elseif y5~=0  posNzreo=6;
elseif y4~=0  posNzreo=5;
elseif y3~=0  posNzreo=4;
elseif y2~=0  posNzreo=3;
elseif y1~=0  posNzreo=2;
else          posNzreo=1;
end
end
