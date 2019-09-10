clc
clear all
close all


pict=imread("pepper.bmp");
pict=rgb2gray(pict)
img = double(pict)
figure(1);
subplot(331);imshow(img,[]);title('original');
[m,n]=size(img)

[LL2,LH2,HL2,HH2]=haart2(img)
dct_1=dct2(img)