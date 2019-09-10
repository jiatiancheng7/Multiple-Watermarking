clc
clear all
close all

pict=imread("pepper.bmp");
pict=rgb2gray(pict)
[M,N]=size(pict)



msb1=248;%128+64+32+16+8
lg_mtx=[]
torus_mtx=[]
K=13
x=0.15;
u=3.8;
N=64
for i=1:164
    x=u*x*(1-x)
    lg_mtx(i)=x
    
end

lg64=lg_mtx(101:164)
[a,b]=sort(lg64)
bh=(reshape(b,[8,8]))'

for i=1:64
    torus_mtx(i)=mod((K*b(i)),N)+1
end

[msbp,lsbp]= separate(pict)

imshow(lsbp)

for row=1:128
    for col=1:128
        BLOCK_1=pict((row-1)*2+1:row*2,(col-1)*2+1:col*2);
        for p=1:2
            for q=1:2
                
                MB=bitand(BLOCK_1(p,q),msb1);
                bg=bitget(MB,1:8)
                
                
                sum=sum(bg)
                if(mod(sum,2)==0)
                    p=0
                else
                    p=1
                end
                    
            end
        end
        avg(row,col) = bitand(BLOCK_1,msb1);
        BLOCk_avg=floor(mean(mean(BLOCK_1)));
        avg(row,col) = bitand(BLOCk_avg,msb1);
    end
end

