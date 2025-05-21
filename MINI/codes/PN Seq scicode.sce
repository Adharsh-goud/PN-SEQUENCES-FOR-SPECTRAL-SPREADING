//Generation of PN sequences
k=input('Length of the Memory')
seed=input('enter the seed')
shi_ft=zeros((2^k)-1,k);
shi_ft(1,:)=seed;
for i=2:(2^k)-1
    d=bitxor(shi_ft(i-1,2),shi_ft(i-1,3));
    shi_ft(i,3)=shi_ft(i-1,2);
    shi_ft(i,2)=shi_ft(i-1,1);
    shi_ft(i,1)=d;
end
shi_ft1=shi_ft';
PN=shi_ft1(k,:);
disp(PN, 'The PN sequence is')
//Verification of Balance Property of PN sequences
O=length(find(PN==1))//No.opf ones in the PN sequence
Z=length(find(PN==0))//No.of zeros in the PN sequence
if O-Z==1 
    disp('and hence the balance property of PN sequence is verified', 1, 'The number of ones and number of zeros in the PN sequence differ by')
    else
    disp('The balance property of PN sequence is not verified')
end
//verification of Run Property of PN sequences
R=zeros(1,length(PN))
i=1
j=i+1
k=1
p=1
while j<=length(R)
if  PN(j)==PN(i)
    j=j+1
else
   R(k)=j-i;
   k=k+1;
   i=j;
   j=i+1; 
end
end
if j>length(PN)
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
//Verification of Auto correlation Property
R1=zeros(length(PN),length(PN))
k=PN(1)
R1(1,1:length(PN)-1)=PN(2:length(PN))
R1(1,length(PN))=k;
for i=2:length(PN)
   k=R1(i-1,1);
   R1(i,1:length(PN)-1)=R1(i-1,2:length(PN))
   R1(i,length(PN))=k;
end
R2=zeros(length(PN),length(PN))
k=PN(length(PN));
R2(1,2:length(PN))=PN(1:length(PN)-1)
R2(1,1)=k;
for i=2:length(PN)
   k=R2(i-1,length(PN));
   R2(i,2:length(PN))=R2(i-1,1:length(PN)-1)
   R2(i,1)=k;
end
  R=[R2;R1];
  R(find(R==0))=-1;
  PN1=PN;
  PN1(find(PN1==0))=-1;
  cor=zeros(1,2*length(PN));
  for i=1:length(cor)
      cor(i)=(sum(PN1.*R(i,:)))/length(PN)
  end
  //To check the periodicity of the correlation function, we are plotting two cycles
    cor=[cor cor];
    lag=-(length(PN)-1):length(cor)-length(PN);
  plot(lag,cor)
  xtitle("","time","amplitude")
  legend("Correlation of PN Sequence")

