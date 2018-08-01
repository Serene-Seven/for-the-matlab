% 各通道肉眼可接受位差
yr = 4;
yg = 5;
yb = 3;

% 读取原图
Img = imread('原图.png');
% figure;imshow(Img,[]);title('原图');

% 读取待隐藏的图
Imgmark = imread('待隐藏的图.png');
% 转为灰度图
Imgmark = rgb2gray(Imgmark);
Imgmark = double(Imgmark);
% figure;imshow(Imgmark,[]);title('待隐藏的图_gray');
[markm, markn] = size(Imgmark);
% 将灰度图的二维数组转成一列
Imgmarkline = Imgmark(:);

% 这一列再转化为更长的一列，二进制八位表示
Imgmarklinebin = zeros(markm*markn*8,1);
for ii = 1 : markm*markn
    [Imgmarklinebin(8*ii-7), Imgmarklinebin(8*ii-6), Imgmarklinebin(8*ii-5), Imgmarklinebin(8*ii-4), Imgmarklinebin(8*ii-3),...
        Imgmarklinebin(8*ii-2), Imgmarklinebin(8*ii-1), Imgmarklinebin(8*ii)] = Find8bits(Imgmarkline(ii));   
end

%%
% 获得RGB各通道分量图
Img = double(Img);
ImgR = Img(:,:,1);
ImgG = Img(:,:,2);
ImgB = Img(:,:,3);
% 嵌入
% 对于红色通道
embedNumsed = 0; % 已嵌入个数
[M, N, Z] = size(Img);
y = zeros(8, 1);
flag = 0; % 辅助跳出的标志

ImgRline = ImgR(:); % 转换为一列
ImgRlineNew = ImgRline; % 嵌入后
for ii = 1 : M*N
    if flag == 1; % 跳出外层循环
       break;
    end
    
    [y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)] = Find8bits(ImgRline(ii));   
    posNzreo = FindNotZero(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));
    embedNums = posNzreo - yr; % 能嵌入的个数
    if  embedNums > 0 %符合嵌入条件
        for jj = 1 : embedNums
            embedNumsed = embedNumsed + 1; % 已嵌入个数
            if embedNumsed > markm*markn*8 % 嵌入完成
               flag = 1; % 设置标识，使外层循环也跳出
               break;
            end
            
            y(jj) = Imgmarklinebin(embedNumsed);% 嵌入
        end
    end
    ImgRlineNew(ii) = bin2dec_trans(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));% 嵌入后的  
end
ImgR2 = reshape(ImgRlineNew, [M, N]);


% 对于G通道
ImgGline = ImgG(:); % 转换为一列
ImgGlineNew = ImgGline; % 嵌入后
for ii = 1 : M*N
    if flag == 1; % 跳出外层循环
       break;
    end
    
    [y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)] = Find8bits(ImgGline(ii));   
    posNzreo = FindNotZero(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));
    embedNums = posNzreo-yg; % 能嵌入的个数
    if  embedNums > 0 % 符合嵌入条件
        for jj = 1 : embedNums
            embedNumsed = embedNumsed + 1; % 已嵌入个数
            if embedNumsed > markm*markn*8 % 嵌入完成
               flag = 1; % 设置标识，使外层循环也跳出
               break;
            end
            
            y(jj) = Imgmarklinebin(embedNumsed); % 嵌入 
        end
    end
    ImgGlineNew(ii) = bin2dec_trans(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)); % 嵌入后的  
end
ImgG2 = reshape(ImgGlineNew, [M, N]);

% 对于B通道
ImgBline = ImgB(:); % 转换为一列
ImgBlineNew = ImgBline; % 嵌入后
for ii = 1 : M*N
    if flag == 1; % 跳出外层循环
       break;
    end
    
    [y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)] = Find8bits(ImgBline(ii));   
    posNzreo = FindNotZero(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));
    embedNums = posNzreo - yb; % 能嵌入的个数
    if  embedNums > 0 % 符合嵌入条件
        for jj = 1 : embedNums
            embedNumsed = embedNumsed + 1; % 已嵌入个数
            if embedNumsed > markm*markn*8 % 嵌入完成
               flag = 1; % 设置标识，使外层循环也跳出
               break;
            end
            
            y(jj) = Imgmarklinebin(embedNumsed); % 嵌入 
        end
    end
    ImgBlineNew(ii) = bin2dec_trans(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)); % 嵌入后的  
end
ImgB2 = reshape(ImgBlineNew, [M, N]);

ImgNew = zeros(M, N, Z);
ImgNew(:,:,1) = ImgR2;
ImgNew(:,:,2) = ImgG2;
ImgNew(:,:,3) = ImgB2;

% figure;imshow(uint8(ImgNew),[]);title('合并后的RGB图');
imwrite(uint8(ImgNew), '合并后的RGB图.png'); % 保存图片
