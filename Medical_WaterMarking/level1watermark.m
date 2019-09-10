function [level1wm,outputArg2] = level1watermark(sub_block)
%LEVEL1WATERMARK Summary of this function goes here
%   Detailed explanation goes here
msb1=248;
for p=1:2
    for q=1:2

        MB=bitand(sub_block(p,q),msb1);
        bg=bitget(MB,1:8)


        sum=sum(bg)
        if(mod(sum,2)==0)
            p=0
        else
            p=1
        end

    end
end



end

