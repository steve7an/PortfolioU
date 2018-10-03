function [ output ] = SMA( price,start,length )
%S1 策略1 SMA 简单移动平均
%price矩阵第一列为时间，第二列为价格
%start 所计算当天下标
%length 为计算的长度
output=mean(price(start-length:start-1,2));
end

