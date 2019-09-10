function outputArg1 = Logistic(pict)
%LOGISTIC 此处显示有关此函数的摘要
%   此处显示详细说明

[M,N]=size(pict)
x=0.334;
u=3.89;

for i=1:2000
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


outputArg1 = out;

end

