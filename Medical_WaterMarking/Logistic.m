clc
clear all
close all


pict=imread("pepper.bmp");
pict=rgb2gray(pict)
[M,N]=size(pict)
x=0.1;
u=4;

for i=1:500
    x=u*x*(1-x)
end


A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
    A(i+1)=u*A(i)*(1-A(i));
end

B=uint8(255*A)

mapping=reshape(B,M,N)
subplot(2,2,1)
imshow(mapping)
out=bitxor(pict,mapping)
v=out
subplot(2,2,2)
imshow(pict)

x=0.1;
u=4;

for i=1:500
    x=u*x*(1-x)
end

A=zeros(1,M*N);
A(1)=x;
for i=1:M*N-1
    A(i+1)=u*A(i)*(1-A(i));
end

B=uint8(255*A)

mapping2=reshape(B,M,N)




jiemi=bitxor(out,mapping2)
subplot(2,2,3)
imshow(v)
subplot(2,2,4)
imshow(jiemi)

