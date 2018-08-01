% 读取原图
Img = imread('原图.png');
[M, N, Z] = size(Img);
Img = double(Img);
ImgR2 = Img(:,:,1);
ImgG2 = Img(:,:,2);
ImgB2 = Img(:,:,3);

% 读取待隐藏的图
Imgmark = imread('待隐藏的图.png');
% 转为灰度图
Imgmark = rgb2gray(Imgmark);
% 转为二值图
Imgmark = im2bw(Imgmark);
figure;imshow(Imgmark,[]);title('待隐藏的图')

for i = 1 : M
    for j = 1 : N
        if mod(ImgR2(i,j), 2) == 1
            ImgR2(i,j) = ImgR2(i,j) - 1;
        end
        if mod(ImgG2(i,j), 2) == 1
            ImgG2(i,j) = ImgG2(i,j) - 1;
        end
        if mod(ImgB2(i,j), 2) == 1
            ImgB2(i,j) = ImgB2(i,j) - 1;
        end
        ImgR2(i,j) = ImgR2(i,j) + Imgmark(i, j);
        ImgG2(i,j) = ImgG2(i,j) + Imgmark(i, j);
        ImgB2(i,j) = ImgB2(i,j) + Imgmark(i, j);
    end
end

ImgNew = zeros(M, N, Z);
ImgNew(:,:,1) = ImgR2;
ImgNew(:,:,2) = ImgG2;
ImgNew(:,:,3) = ImgB2;

% figure;imshow(uint8(ImgNew),[]);title('合并后的RGB图');
imwrite(uint8(ImgNew), '合并后的RGB图.png'); % 保存图片
