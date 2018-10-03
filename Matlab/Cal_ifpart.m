function [ rating,degree] = Cal_ifpart( class,m, n,level,score,price,lastprice )
%计算if部分符不符合，及符合程度。隶属函数
%
kk=size(class,3);
aa=size(class,1);
numb=size(price,1)-500;
rating=zeros(numb,kk);
degree=zeros(numb,aa);

 %这个地方的20和30需要修改
for k=1:kk
for i=1:aa
switch class(i,1,k)
    case 1
        historybac=sort(periodSMA(lastprice,n(i,1,k))-periodSMA(lastprice,m(i,1,k)));
        difmaprice=periodSMA(price,n(i,1,k))-periodSMA(price,m(i,1,k));
    case 2
        historybac=sort(periodAMA(lastprice,n(i,1,k))-periodAMA(lastprice,m(i,1,k)));
        difmaprice=periodAMA(price,n(i,1,k))-periodAMA(price,m(i,1,k));
    case 3
        historybac=sort(periodTPMA(lastprice,n(i,1,k))-periodTPMA(lastprice,m(i,1,k)));
        difmaprice=periodTPMA(price,n(i,1,k))-periodTPMA(price,m(i,1,k));
    case 4
        historybac=sort(periodTMA(lastprice,n(i,1,k))-periodTMA(lastprice,m(i,1,k)));
        difmaprice=periodTMA(price,n(i,1,k))-periodTMA(price,m(i,1,k));
end

% point1=historybac(1);
% point2=historybac(round(numb/6));
% point3=historybac(round(numb/6*2));
% point4=historybac(round(numb/6*3));
% point5=historybac(round(numb/6*4));
% point6=historybac(round(numb/6*5));
% point7=historybac(numb);


if historybac(8)>=0
    point1=0;
    point2=0;
    point3=0;
    point4=historybac(1);
    point5=historybac(round(numb/3));
    point6=historybac(round(numb/3*2));
    point7=historybac(round(numb/3*3));
else
    if historybac(numb-7)<=0
    point1=historybac(1);
    point2=historybac(round(numb/3));
    point3=historybac(round(numb/3*2));
    point4=historybac(round(numb/3*3));
    point5=0;
    point6=0;
    point7=0;
else 
    for nn=1:numb
        temp=historybac(nn)*historybac(nn+1);
        
        if temp<=0
            break
        end
    end
    point1=historybac(1);
    point2=historybac(round(nn/3+1));
    point3=historybac(round(nn/3*2+1));
    point4=historybac(round(nn));
    point5=historybac(round((numb-nn)/3+nn));
    point6=historybac(round((numb-nn)/3*2+nn));
    point7=historybac(numb);
    end
end

switch level(i,:,k)
    case 1
        degree1= difmaprice<=point1;
        degree1=double(degree1);
        degree2= difmaprice>=point1 & difmaprice<=point2;
        degree2=(-1/(point2-point1)^2*(difmaprice-point1).^2+1).*degree2;
%         degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
        degree(:,i)=degree1+degree2;      
        degree(isnan(degree))=0;
    case 2
        degree1= (difmaprice>=point1) & (difmaprice<=point2);
        degree1=(-1/(point1-point2)^2*(difmaprice-point2).^2+1).*degree1;
        degree2=(difmaprice>=point2)&(difmaprice<=point3);
        degree2=(-1/(point3-point2)^2*(difmaprice-point2).^2+1).*degree2;
%         degree1=double(degree1);
%         degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
        degree(:,i)=degree1+degree2;
        degree(isnan(degree))=0;
    case 3
        degree1=(difmaprice>=point2) & (difmaprice<=point3);
        degree1=(-1/(point2-point3)^2*(difmaprice-point3).^2+1).*degree1;
        degree2=(difmaprice>=point3)&(difmaprice<=point4);
        degree2=(-1/(point4-point3)^2*(difmaprice-point3).^2+1).*degree2;
%         degree1=double(degree1);
%         degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
        degree(:,i)=degree1+degree2;
        degree(isnan(degree))=0;
    case 4
        degree1=(difmaprice>=point3) & (difmaprice<=point4);
        degree1=(-1/(point3-point4)^2*(difmaprice-point4).^2+1).*degree1;
        degree2=(difmaprice>=point4)&(difmaprice<=point5);
        degree2=(-1/(point5-point4)^2*(difmaprice-point4).^2+1).*degree2;
%         degree1=double(degree1);
%         degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
        degree(:,i)=degree1+degree2;       
        degree(isnan(degree))=0;
   case 5
        degree1=(difmaprice>=point4) & (difmaprice<=point5);
        degree1=(-1/(point4-point5)^2*(difmaprice-point5).^2+1).*degree1;
        degree2=(difmaprice>=point5)&(difmaprice<=point6);
        degree2=(-1/(point6-point5)^2*(difmaprice-point5).^2+1).*degree2;
%         degree1=double(degree1);
%         degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
        degree(:,i)=degree1+degree2;
degree(isnan(degree))=0; 
    case 6
        degree1=(difmaprice>=point5) & (difmaprice<=point6);
        degree1=(-1/(point5-point6)^2*(difmaprice-point6).^2+1).*degree1;
        degree2=(difmaprice>=point6)&(difmaprice<=point7);
        degree2=(-1/(point7-point6)^2*(difmaprice-point6).^2+1).*degree2;
%         degree1=double(degree1);
%         degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
        degree(:,i)=degree1+degree2;
        degree(isnan(degree))=0;
    case 7
       degree1= difmaprice>=point7;
       degree1=double(degree1);
       degree2=(difmaprice>=point6) & (difmaprice<point7);
       degree2=(-1/(point6-point7)^2*(difmaprice-point7).^2+1).*degree2;
%        degree2=double(degree2);
%degree1(isnan(degree1))=0;
%degree2(isnan(degree2))=0;
      degree(:,i)=degree1+degree2;   
      degree(isnan(degree))=0;
end
end
s=score(:,:,k);
 ss=degree*s;
 sss=zeros(numb,1);
%  degree01=degree~=0;
 
 
 for d=1:numb
I=length(find(degree(d,:)~=0));
if I==0
    sss(d)=0;
else
 sss(d)=ss(d)/I;
end
 end

for b=1:numb
 rating(b,k)=sss(b);
end
end

end

