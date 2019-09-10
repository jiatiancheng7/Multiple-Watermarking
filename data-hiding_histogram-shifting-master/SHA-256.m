string = 'some string'; 
sha256hasher = System.Security.Cryptography.SHA256Managed;
sha256 = uint8(sha256hasher.ComputeHash(uint8(string))); %consider the string as 8-bit characters
%display as hex:
abc = dec2hex(sha256)

sha1hasher = System.Security.Cryptography.SHA1Managed;
sha1= uint8(sha1hasher.ComputeHash(uint8(string))); %consider the string as 8-bit characters
%display as hex:
dec2hex(sha1)



for p=1:512
    for q=1:512
        LSB(p,q)=string(I(p,q));
    end
end