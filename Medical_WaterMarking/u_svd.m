clc
clear all
close all


pict=imread("pepper.bmp");
pict=rgb2gray(pict)
img = double(pict)
figure(1);
subplot(331);imshow(img,[]);title('original');
[m,n]=size(img)
[U,S,V]=svd(img)
val=svd(img)

decomp_1 = U(:,:)*S(:,1)*V(:,1)'
subplot(332);imshow(decomp_1,[]);title('decomp_1');

decomp_5 = U(:,:)*S(:,1:5)*V(:,1:5)'
subplot(333);imshow(decomp_5,[]);title('decomp_5');

decomp_10 = U(:,:)*S(:,1:10)*V(:,1:10)'
subplot(334);imshow(decomp_10,[]);title('decomp_10');


decomp_50 = U(:,:)*S(:,1:50)*V(:,1:50)'
subplot(335);imshow(decomp_5,[]);title('decomp_50');

decomp_80 = U(:,:)*S(:,1:80)*V(:,1:80)'
subplot(336);imshow(decomp_80,[]);title('decomp_80');



decomp_150 = U(:,:)*S(:,1:150)*V(:,1:150)'
subplot(337);imshow(decomp_150,[]);title('decomp_150');


decomp_250 = U(:,:)*S(:,1:250)*V(:,1:250)'
subplot(338);imshow(decomp_250,[]);title('decomp_250');

decomp_512 = U(:,:)*S(:,1:512)*V(:,1:512)'
subplot(338);imshow(decomp_512,[]);title('decomp_512');
