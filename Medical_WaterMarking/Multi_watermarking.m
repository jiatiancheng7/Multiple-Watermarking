clc
clear all;% clear all variables from previous sessions
close all;

%covername = input('Enter image file name with extension: ', 's');
%messagename = input('Enter message image file name with extension: ', 's');

covername = imread('stego_zaiti4.jpg');

msb=192;
lsb=63;

for p=1:512
    for q=1:512
        LSB(p,q)=bitand(covername(p,q),lsb);
    end
end
for p=1:512
    for q=1:512
        MSB(p,q)=bitand(covername(p,q),msb);
    end
end
subplot(1,2,1)
imshow(LSB)
subplot(1,2,2)
imshow(MSB)
title('LSB&MSB plane')

water = imread('water')
imshow(water)
title('Water Imgae')
Dwater=double(water)
tempImage=Dwater
for row=1:64
    for col=1:64
        BLOCK_1=covername((row-1)*8+1:row*8,(col-1)*8+1:col*8)
        BLOCK_1=dct2(BLOCK_1)
        BLOCK_1(4,5)=BLOCK_1(4,5)+a*water(rol,col)
        covername((row-1)*8+1:row*8,(col-1)*8+1:col*8)=idct2(BLOCK_1)
    end
end



  