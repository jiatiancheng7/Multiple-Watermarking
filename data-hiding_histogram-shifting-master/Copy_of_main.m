clear
clc
addpath(genpath('JPEG_Toolbox'));
Data = round(rand(1,1000000)*1);%随机产生01比特，作为嵌入的数据
payload =1000000;
I = imread('pepper.bmp');
I = rgb2gray(I);
imwrite(I,'pepper.jpg','jpeg','quality',100);%生成质量因子为70的JPEG图像
imwrite(I,'Ori_pepper.jpg','jpeg','quality',100);%生成质量因子为70的JPEG图像
%% 解析JPEG文件
jpeg_info = jpeg_read('pepper.jpg');%解析JPEG图像
ori_jpeg_80 = imread('pepper.jpg');%读取原始jpeg图像
quant_tables = jpeg_info.quant_tables{1,1};%获取量化表
dct_coef = jpeg_info.coef_arrays{1,1};%获取dct系数
[num1,num_1] = jpeg_hist(dct_coef);%绘制非零ac系数直方图
%% 数据嵌入
[emdData,numData,jpeg_info_stego] = jpeg_emdding(Data,dct_coef,jpeg_info,payload);
jpeg_write(jpeg_info_stego,'stego_pepper.jpg');%保存载密jpeg图像
stego_jpeg_80 = imread('stego_pepper.jpg');%读取载密jpeg图像
%% 数据提取
stego_jpeg_info = jpeg_read('stego_pepper.jpg');%解析JPEG图像
[numData2,stego_jpeg_info,extData] = jpeg_extract(stego_jpeg_info,payload);
jpeg_write(stego_jpeg_info,'re_pepper.jpg');%保存恢复jpeg图像
re_jpeg_80 = imread('re_pepper.jpg');%读取恢复jpeg图像
%% 显示
figure;
subplot(221);imshow(I);title('tiff原始图像');%显示原始图像
subplot(222);imshow(ori_jpeg_80);title('jpeg原始图像');%显示JPEG压缩图像
subplot(223);imshow(stego_jpeg_80);title('载密图像');%显示stego_jpeg_80
subplot(224);imshow(re_jpeg_80);title('恢复图像');%显示恢复图像
%% 图像质量比较
psnrvalue1 = psnr(ori_jpeg_80,stego_jpeg_80);
psnrvalue2 = psnr(ori_jpeg_80,re_jpeg_80);
v = isequal(emdData,extData);
if psnrvalue2 == -1
    disp('恢复图像与原始图像完全一致。');
elseif psnrvalue2 ~= -1
    disp('warning！恢复图像与原始图像不一致！');
end
if v == 1
    disp('提取数据与嵌入数据完全一致。');
elseif v ~= 1
    disp('warning！提取数据与嵌入数据不一致');
end
ori_filesize = imfinfo('stego_Lena.jpg');