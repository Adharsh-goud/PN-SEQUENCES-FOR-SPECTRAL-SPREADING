clc
clear all
k=input('Length of the Memory')
seed=input('enter the seed')
shi_ft=zeros((2^k)-1,k);
shi_ft1=shi_ft;
shi_ft(1,:)=seed;
shi_ft1(1,:)=seed;
for i=2:(2^k)-1
    d1=bitxor(shi_ft(i-1,2),shi_ft(i-1,3));
    d2=bitxor(shi_ft1(i-1,1),shi_ft1(i-1,3));
    shi_ft(i,3)=shi_ft(i-1,2);
    shi_ft1(i,3)=shi_ft1(i-1,2);
    shi_ft(i,2)=shi_ft(i-1,1);
    shi_ft1(i,2)=shi_ft1(i-1,1);
    shi_ft(i,1)=d1;
    shi_ft1(i,1)=d2;  
end
shi_ft11=shi_ft';
shi_ft21=shi_ft1';
gold1=shi_ft11(k,:);
gold2=shi_ft21(k,:);
gold=bitxor(gold1,gold2);
disp('Gold sequence  is',gold)


k1=input('Length of the Memory1')
seed1=input('enter the seed1')
shi_ftt=zeros((2^k1)-1,k1);
shi_ft12=shi_ft;
shi_ftt(1,:)=seed1;
shi_ft12(1,:)=seed1;
for j=2:(2^k1)-1
    d11=bitxor(shi_ftt(j-1,1),shi_ftt(j-1,2));
    d22=bitxor(shi_ft12(j-1,2),shi_ft12(j-1,3));
    shi_ftt(j,3)=shi_ftt(j-1,2);
    shi_ft12(j,3)=shi_ft12(j-1,2);
    shi_ftt(j,2)=shi_ftt(j-1,1);
    shi_ft12(j,2)=shi_ft12(j-1,1);
    shi_ftt(j,1)=d11;
    shi_ft12(j,1)=d22;  
end
shi_ft111=shi_ftt';
shi_ft211=shi_ft12';
gold11=shi_ft111(k1,:);
gold22=shi_ft211(k1,:);
goldy=bitxor(gold11,gold22);
disp('Gold sequence  is',goldy)

xcorr(gold,goldy)

R=zeros(1,length(gold))
i=1
j=i+1
k=1
p=1
while j<=length(R)
if  gold(j)==gold(i)
    j=j+1
else
   R(k)=j-i;
   k=k+1;
   i=j;
   j=i+1; 
end
end
if j>length(gold)
    R(k)=j-i;
end
R(find(R==0))=[];
C=zeros(1,max(R));
for i=1:length(R)
    C(R(i))=C(R(i))+1
end
for i=1:length(C)
    disp(C(i),'is',i,'The number of runs of length')
end


R1=zeros(length(gold),length(gold))
k=gold(1)
R1(1,1:length(gold)-1)=gold(2:length(gold))
R1(1,length(gold))=k;
for i=2:length(gold)
   k=R1(i-1,1);
   R1(i,1:length(gold)-1)=R1(i-1,2:length(gold))
   R1(i,length(gold))=k;
end
R2=zeros(length(gold),length(gold))
k=gold(length(gold));
R2(1,2:length(gold))=gold(1:length(gold)-1)
R2(1,1)=k;
for i=2:length(gold)
   k=R2(i-1,length(gold));
   R2(i,2:length(gold))=R2(i-1,1:length(gold)-1)
   R2(i,1)=k;
end
  R=[R2;R1];
  R(find(R==0))=-1;
  gold1=gold;
  gold1(find(gold1==0))=-1;
  cor=zeros(1,2*length(gold));
  for i=1:length(cor)
      cor(i)=(sum(gold1.*R(i,:)))/length(gold)
  end
  cor=[cor cor];
    lag=-(length(gold)-1):length(cor)-length(gold);
  plot(lag,cor)
  xtitle("","time","amplitude")
  legend("Correlation of Gold Code Sequence")











