function [ output ] = TPMA( price,start,length )
%S5 TPMA典型价格移动平均
%  (High + Low + Close) / 3
output=(max(price(start-length:start-1,2))+min(price(start-length:start-1,2))+price(start-1,2))/3.0;
end

