function [subpopinten]=Decodebin(subpop)
%将pop中的每一位二进制0或者1改成十进制的数字然后相加求出十进制数字；
%pop2为返回的十进制数字
py=size(subpop,2);
pop1=subpop;
for i=1:py
    pop1(:,i,:)=2^(py-i).*subpop(:,i,:);
end
subpopinten=sum(pop1,2);
end