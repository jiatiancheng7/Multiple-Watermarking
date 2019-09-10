img = dicomread('000003');%读取图片         
img=double(img); %将灰度级映射到0~255        
low=min(min(img));        
high=max(max(img));        
maxgray=high-low;%计算窗宽        
rate=256/maxgray;        
img=img*rate;        
img=img+abs(min(min(img)));%加窗        
img=uint8(img);%转化为8位的位图数据格        
imshow(img)