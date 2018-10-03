function [ output ] =  periodTMA( priceseries,length)
 
m=size(priceseries,1);
days=m-500;
output=zeros(days,1);
output(1,1)=mean(priceseries((501-length):500,2));
for i=2 : days
    output(i,1)=TMA(priceseries, 500+i,length);
end  
end

