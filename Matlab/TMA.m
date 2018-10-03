function [ output ] = TMA( priceseries,start,length )
%S6 三角型移动平均线 TMA
%   
s=0;
for i=1:length
 s=s+SMA(priceseries,start-i+1,length);
end
output=s/length;
end

