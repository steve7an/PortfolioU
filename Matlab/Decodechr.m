function pop2=Decodechr(pop,spoint,length)
% 对需要二进制转换成十进制的部分做处理
%返回计算部分的十进制串
pop1=pop(:,spoint:spoint+length-1,:);
pop2=Decodebin(pop1);
end