clear
clc
addpath(genpath('JPEG_Toolbox'));

Data = round(rand(1,1000000)*1);%随机产生01比特，作为嵌入的数据
water = imread('shuiyintuxiang.jpg');
water = rgb2gray(water);




payload =1000000;
I = imread('zaitituxiang2.jpg');
imwrite(I,'zaiti4.jpg','jpeg','quality',100);%生成质量因子为70的JPEG图像
imwrite(I,'Ori_zaiti4.jpg','jpeg','quality',100);%生成质量因子为70的JPEG图像
%% 解析JPEG文件
jpeg_info = jpeg_read('zaiti4.jpg');%解析JPEG图像
ori_jpeg_80 = imread('zaiti4.jpg');%读取原始jpeg图像
quant_tables = jpeg_info.quant_tables{1,1};%获取量化表
dct_coef = jpeg_info.coef_arrays{1,1};%获取dct系数
[num1,num_1] = jpeg_hist(dct_coef);%绘制非零ac系数直方图
%% 数据嵌入
[emdData,numData,jpeg_info_stego] = jpeg_emdding(Data,dct_coef,jpeg_info,payload);
jpeg_write(jpeg_info_stego,'stego_zaiti4.jpg');%保存载密jpeg图像
stego_jpeg_80 = imread('stego_zaiti4.jpg');%读取载密jpeg图像
%% 分块提取hash值
for row=1:64
    for col=1:64
        BLOCK_1=stego_jpeg_80((row-1)*8+1:row*8,(col-1)*8+1:col*8);
        hash=sha256(BLOCK_1);
        dechash=reshape(hex2dec(reshape(dec2hex(hash),[64,1])),[8,8]);
        shahash((row-1)*8+1:row*8,(col-1)*8+1:col*8)=dechash;
    end
end

%% 载密图像分层
msb=224;
lsb=31;
for p=1:512
    for q=1:512
        LSB(p,q)=bitand(stego_jpeg_80(p,q),lsb);
    end
end
for p=1:512
    for q=1:512
        MSB(p,q)=bitand(stego_jpeg_80(p,q),msb);
    end
end
subplot(1,2,1)
imshow(LSB)
title('LSB  plane')
subplot(1,2,2)
imshow(MSB)
title('MSB plane')
imwrite(LSB,'LSB_plane.jpg')
imwrite(MSB,'MSB_plane.jpg')
%% 图像信息嵌入
shahash = uint8(shahash)
MSB_stego = MSB+shahash;

imshow(MSB_stego)
title('MSB Stego')
imwrite(MSB_stego,'MSB_stego.jpg')

%% 混沌加密
Log_MSB=Logistic(MSB_stego);



imshow(Log_MSB)
title('MSB加密后图像')
Log_LSB=Logistic(LSB);

%% 数据提取
stego_jpeg_info = jpeg_read('stego_zaiti4.jpg');%解析JPEG图像
[numData2,stego_jpeg_info,extData] = jpeg_extract(stego_jpeg_info,payload);
jpeg_write(stego_jpeg_info,'re_zaiti4.jpg');%保存恢复jpeg图像
re_jpeg_80 = imread('re_zaiti4.jpg');%读取恢复jpeg图像
%% 显示
figure;
subplot(221);imshow(I);title('tiff原始图像');%显示原始图像
subplot(222);imshow(ori_jpeg_80);title('原始图像');%显示JPEG压缩图像
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
ori_filesize = imfinfo('stego_zaiti4.jpg');