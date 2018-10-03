function [ output] =  AMA_noise( price,daydecide,n )
%此函数求AMA 中ER（效率比率）的噪声值
% n为周期数
output=0;
for i=1:n
output=output+abs(price(daydecide-i,1)-price(daydecide-i-1,1));
end
end

