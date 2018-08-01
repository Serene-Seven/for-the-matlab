% 各通道肉眼可接受位差
yr = 4;
yg = 5;
yb = 3;

% 读取合并后的RGB图
Img = imread('合并后的RGB图.png');
[M, N, Z] = size(Img);
Img = double(Img);
ImgR2 = Img(:,:,1);
ImgG2 = Img(:,:,2);
ImgB2 = Img(:,:,3);

% 提取嵌入图像
flag = 0;
Imgmark_extractlinebin = zeros(M*N*8, 1);
extractNumsed = 0; % 已提取个数

% R通道
ImgRline2 = ImgR2(:); % 转换为一列
for ii = 1 : M*N
    if flag == 1; % 跳出外层循环
       break;
    end
    
    [y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)] = Find8bits(ImgRline2(ii));   
    posNzreo = FindNotZero(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));
    embedNums = posNzreo - yr; % 已嵌入的个数
    if  embedNums > 0 % 符合嵌入条件
        for jj = 1 : embedNums
            
            extractNumsed = extractNumsed + 1; % 已提取个数
            if extractNumsed > M*N*8 % 提取完成
               flag = 1; % 设置标识，使外层循环也跳出
               break;
            end 
            
           Imgmark_extractlinebin(extractNumsed) = y(jj); % 提取
        end  
    end  
end

% G通道
ImgGline2 = ImgG2(:); % 转换为一列
for ii = 1 : M*N
    if flag == 1; % 跳出外层循环
       break;
    end
    
    [y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)] = Find8bits(ImgGline2(ii));   
    posNzreo = FindNotZero(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));
    embedNums = posNzreo - yg; % 已嵌入的个数
    if embedNums > 0 % 符合嵌入条件
        for jj = 1:embedNums
            
            extractNumsed = extractNumsed + 1; % 已提取个数
            if extractNumsed > M*N*8 % 提取完成
               flag = 1; % 设置标识，使外层循环也跳出
               break;
            end
            
           Imgmark_extractlinebin(extractNumsed) = y(jj);% 提取
        end
    end
end

%  G通道
ImgBline2 = ImgB2(:); % 转换为一列
for ii = 1:M*N
    if flag == 1; % 跳出外层循环
       break;
    end
    
    [y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1)] = Find8bits(ImgBline2(ii));   
    posNzreo = FindNotZero(y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1));
    embedNums = posNzreo - yb; % 已嵌入的个数
    if embedNums > 0 % 符合嵌入条件
        for jj = 1 : embedNums
            
            extractNumsed = extractNumsed + 1; % 已提取个数
            if extractNumsed > M*N*8 % 提取完成
               flag = 1; % 设置标识，使外层循环也跳出
               break;
            end
            
           Imgmark_extractlinebin(extractNumsed) = y(jj); % 提取
        end
    end
end

% 二进制转十进制
Imgmarklinedec = zeros(M*N, 1); % 转化为十进制
for ii = 1 : M*N
    Imgmarklinedec(ii) = bin2dec_trans(Imgmark_extractlinebin(8*ii-7), Imgmark_extractlinebin(8*ii-6), Imgmark_extractlinebin(8*ii-5), Imgmark_extractlinebin(8*ii-4),...
                                     Imgmark_extractlinebin(8*ii-3), Imgmark_extractlinebin(8*ii-2), Imgmark_extractlinebin(8*ii-1), Imgmark_extractlinebin(8*ii));
end
Imgmarkextract = reshape(Imgmarklinedec, [M, N]);
% figure;imshow(Imgmarkextract,[]);title('提取出的隐藏图');
imwrite(uint8(Imgmarkextract), '提取出的隐藏图.png'); % 保存图片
