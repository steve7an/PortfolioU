format short
% name Trade.m 遗传算法 期货交易策略优化主程序
%% 数据输入段
% price为训练数据，pricesel为最优值选择数据， pricetest为测试数据
% 每组数据开始时间提前500天的数据作为计算辅助，时间段从201开始
% initialprice作为一个基础变量必须首先加载，两列数据，第一列是数字格式的时间，第二列是石油价格；
RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));
initialprice=price1;
starttime=751;
step=250;
trivaltimes=15;
rulenumber=10;
everytrail_obj_test=zeros(trivaltimes,2);%保存每次实验最优策略以及最优策略的测试收益率；
everytrail_bestrules=zeros(rulenumber,5,trivaltimes);
everytrial_difholding=zeros(250,trivaltimes);
trainlength=250;
sellength=250;
testlength=250;
%% 初始条件设定
generation=50;
popsize=20;

%length不能修改
chromlength=18;
%交叉和变异概率
pc=0.7;
pm=0.05;
%交易成本率和无风险收益率
cost=18;%相当于0.1%
risk_free_return=0.02; %无风险年利率2%
capitals=1000000;
margin=0.15;
%% 进行循环实验，进行trivaltimes次实验，得到同等数量的最有策略进行测试。
for thisrepet=1:20
for trivalcycle=1:17%trivaltimes
   % 给定三个样本区间
    steppoint=(trivalcycle-1)*step;
    price=initialprice((steppoint+starttime-500):(steppoint+starttime+trainlength+250-1),:);
    pricesel=initialprice((steppoint+starttime+trainlength-500):(steppoint+starttime+trainlength+sellength-1),:);
    pricetest=initialprice((steppoint+starttime+trainlength+sellength-500):(steppoint+starttime+trainlength+sellength+testlength-1),:);
%if部分 隶属函数的历史数据
    lastprice=initialprice((steppoint+starttime-500-step):(steppoint+starttime+trainlength+250-step-1),:);
    lastpricesel=initialprice((steppoint+starttime+trainlength-500-step):(steppoint+starttime+trainlength+sellength-step-1),:);
    lastpricetest=initialprice((steppoint+starttime+trainlength+sellength-500-step):(steppoint+starttime+trainlength+sellength+testlength-step-1),:);
    
    
    

every_gen_result=zeros(generation,5);
bestreturn=[0 -5];%初始矩阵，记录每代种群的最有选择值的收益率，通过sel数据测试的
% bestindividual=zeros(rulenumber,chromlength,trivaltimes);
pop=Init_trade_strategy(rulenumber,chromlength,popsize);

%% 单次实验的进化过程
for i=1:generation
    i
   [obj_all]=Cal_All_Futureobj(pop,price,lastprice,cost,capitals,margin,risk_free_return);
     %由目标函数值计算适应度函数；
     %第二列是回报值
     fitn_all=ranking(-obj_all(:,2),[2 1]);
    [bestfitness,bestindex]=max(fitn_all);
    % 测试选择出来的最优个体的选择
     [obj_best_sel]=Cal_All_Futureobj(pop(:,:,bestindex),pricesel,lastpricesel,cost,capitals,margin,risk_free_return);
    if(obj_best_sel(1,2)>bestreturn(1,2)-0.05)
        bestreturn=obj_best_sel;
        bestindividual=pop(:,:,bestindex);
    end
   every_gen_result(i,:)=[obj_all(bestindex,:) mean(obj_all(:,2)) bestreturn ]  ;
 
    %产生新的子代
  newpop=Gennewpop(pop,fitn_all,pc,pm,chromlength,rulenumber);
 pop=newpop;
 
end
%% 结果输出以及测试数据

%xlswrite('every_gen_best.xls',every_gen_result,['result' num2str(trivalcycle)]);
%[ m, n, class, stnd ] = Trns_Str( bestindividual );
% [obj_test]=Cal_All_Futureobj(bestindividual,pricetest,cost,risk_free_return);
%%记录每次实验的最优策略测试结果
% everytrail_bestrules(trivalcycle,:)=[m n  class stnd obj_test ];
% trivalcycle
%end
%xlswrite('everytril.xls',everytrail_bestrules);
 %% 结果输出以及测试数据

xlswrite([num2str(thisrepet) 'every_gen_best.xlsx'],every_gen_result,['result' num2str(trivalcycle)]);
[ class,m, n, level, score ] = Trns_Str( bestindividual );
[obj_test,holding]=Cal_All_Futureobj(bestindividual,pricetest,lastpricetest,cost,capitals,margin,risk_free_return);
%%记录每次实验的最优策略测试结果
 everytrail_bestrules(:,:,trivalcycle)=cat(2,m,n,class,level,score);
 everytrail_obj_test(trivalcycle,:)=obj_test;
 everytrial_difholding(:,trivalcycle)=holding;
 thisrepet
 trivalcycle
end
for i=1:trivaltimes
xlswrite([num2str(thisrepet) 'everytril.xlsx'],everytrail_bestrules(:,:,i),i);
end
xlswrite([num2str(thisrepet) 'everytril_objtest.xlsx'],everytrail_obj_test);
xlswrite([num2str(thisrepet) 'everytril_difholding.xlsx'],everytrial_difholding);
end
    
   
