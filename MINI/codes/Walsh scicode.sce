clc
clear all
close all
H=[0 0;0 1];
 disp('enter the length of the code word');
L=input('');
L1=log2(L);
 for i=2:L1
     H=repmat(H,[2,2]);
     [m,n]=size(H);
     for i=(m/2)+1:m
         for j=(n/2)+1:n
             H(i,j)=~H(i,j);
         end
     end
 end
 disp('the code words are')
   for i=1:m
     disp(H(i,:));
   end
   
   
    H1=H;
 H1(find(H1==0))=-1;
 ortho_=ones(m,n);
 //Verification of orthogonality between various code words
 //computation of correlation matrix
 for i=0:m-1
     for j=0:n-1
         ortho_(i+1,j+1)= sum(H1(i+1,:).*H1(j+1,:))/n;
     end
 end
 disp(ortho_, 'The correlation matrix of the code is');


 //Verification of correlation property
 //p indicates the number of the code word of the code word.
 disp('enter a number between 1 and L')

 p=input('');
 
 C=H1(p,:);
 R1=zeros(length(C),length(C));
 k=C(1);
 R1(1,1:length(C)-1)=C(2:length(C));
 R1(1,length(C))=k;
 for i=2:length(C)
     k=R1(i-1,1);
     R1(i,1:length(C)-1)=R1(i-1,2:length(C));
     R1(i,length(C))=k;
 end
 R2=zeros(length(C),length(C));
 k=C(length(C));
 R2(1,2:length(C))=C(1:length(C)-1);
 R2(1,1)=k;
 for i=2:length(C)
     k=R2(i-1,length(C));
     R2(i,2:length(C))=R2(i-1,1:length(C)-1);
     R2(i,1)=k;
 end
 R=[R2;R1];
 R(find(R==0))=-1;
 C1=C;
 C1(find(C1==0))=-1;
 cor=zeros(1,2*length(C));
 for i=1:length(cor)
     cor(i)=(sum(C1.*R(i,:)))/length(C);
 end
 disp('the correlation of the code word ',p, 'of the code for different lags is ', cor);




