function [ output ] =  AMA( price,daytodecice,length,lastvalue)
%S4 AMA
er=abs(price(daytodecice-1,1)-price(daytodecice-length,1))/ AMA_noise(price,daytodecice,length);
ssc=er*(2/3-2/31)+2/31;
output=price(daytodecice,1)*ssc^2+lastvalue*(1-ssc^2);
end

