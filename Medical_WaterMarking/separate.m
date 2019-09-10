function [MSBP,LSBP] = separate(Image)
%SEPARATE Summary of this function goes here
%   Detailed explanation goes here


msb=224;%128+64+32
lsb=31;%16+8+4+2+1

for p=1:512
    for q=1:512
        LSB(p,q)=bitand(Image(p,q),lsb);
    end
end
for p=1:512
    for q=1:512
        MSB(p,q)=bitand(Image(p,q),msb);
    end
end


LSBP = LSB;
MSBP = MSB;

end

