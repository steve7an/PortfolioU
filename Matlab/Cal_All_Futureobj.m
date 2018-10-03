function [ obj_all, holding ] = Cal_All_Futureobj(pop ,price,lastprice,cost,capitals,margin,risk_free_return)
%返回值是n行两列的矩阵，第一列为超收益，第二列为交易的次数
%   Detailed explanation goes here
% n=size(pop,1);
% obj_All=zeros(n,2);
a=size(price,1);
b=size(pop,3);
c=a-500;
effprice=price(a-c+1:a,2);
  %把策略翻译成可识别的数据组合
    [class,m, n,level,score]=Trns_Str(pop);
    %计算每组的推荐值
    [rating] = Cal_ifpart( class,m, n,level,score,price,lastprice );
    sumholding =capitals./effprice/margin;
    difholding=zeros(c,b);
    holding=round(repmat(sumholding,1,b).*rating/1000)*1000;
    holding(c,:)=0;
    difholding(1,:)=holding(1,:);
    difholding(2:c,:)=diff(holding);
    in_out_pay=repmat(effprice,1,b).*difholding+abs(difholding)/1000*cost;
    costfreereturn=(capitals-repmat(effprice,1,b).*(abs(holding))*margin)*risk_free_return/250;
   rateofreturn=(sum(costfreereturn,1)-sum(in_out_pay,1))/capitals;
  obj_all(:,2)=rateofreturn';
   obj_all(:,1)=(1:1:b);    
%    %计算需要的平均值们
%    for i=1:size(pop,1)
%      nowcalprice=mainf(price,m(i),n(i),class(i),stnd(i),501);
%   %决定每天的投资策略
%     nowcalprice=Decide_Long_Short(nowcalprice,stnd(i));
%     %第二列是适应只，第一列是交易的次数
%     [ obj_All(i,1),obj_All(i,2) ]=Calc_Future_Return( nowcalprice, cost, risk_free_return );
%    end
  
end

