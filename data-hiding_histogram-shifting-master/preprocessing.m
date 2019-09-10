img = imread('shuiyin123.jpg');
for i = 1:size(img,1)
    for j = 1:size(img,2)
        if img(i,j) == 0
            img(i,j) = 0;
        else
            img(i,j) = 255;
        end
    end
end


img = dicomread(filepath);%读取图片         
img=double(img); %将灰度级映射到0~255        
low=min(min(img));        
high=max(max(img));        
maxgray=high-low;%计算窗宽        
rate=256/maxgray;        
img=img*rate;        
img=img+abs(min(min(img)));%加窗        
img=uint8(img);%转化为8位的位图数据格        
imwrite(img,filepath_save);

