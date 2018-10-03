function [ newpop ] = Gennewpop( pop,fitvalues ,pc,pm,chromlength,rulenumber)
%产生新的种群
%按照适应度选择80%的种群

selectpop=select3d('rws',pop,fitvalues,0.8);
migratepop=select3d('rws',pop,fitvalues,0.1);
%剩余的个体重新生成
newpopsize=size(pop,3)-size(selectpop,3)-size(migratepop,3);
newsubpop=Init_trade_strategy(rulenumber,chromlength,newpopsize);
%产生新的种群
newpop1=cat(3,selectpop,newsubpop);
%进行交叉和变异
newpop1=recombin3d('xovsprs3d',newpop1,pc);
%二进制表示不需要制定变异的边界
[a,b,c]=size(newpop1);
bigpop=permute(newpop1,[2,1,3]);
bigpop=(reshape(bigpop,b,a*c))';
bigpop=recombin('xovsprs',bigpop,pc);
bigpop=mutate('mut',bigpop,NaN,pm);
newpop1=reshape(bigpop',b,a,c);
newpop1=permute(newpop1,[2,1,3]);
newpop=cat(3,newpop1,migratepop);
end

