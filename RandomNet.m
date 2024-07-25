function Net_rand=RandomNet(Net_link)
% Construct surrogate networks
% This function only randomly reconnects connections between excitatory neurons
% Net_link: adjacent matrix of excitatory connections

K=size(Net_link,1);
Net_rand=zeros(K);
degree=sum(Net_link,2);

for i=1:K-1
    d=sum(Net_rand(i,:));
    if d<degree(i)
        s=Net_rand(i,:);
        s(1:i)=1; 
        
        ss_d=degree-sum(Net_rand,2);
        ss_dd=find(ss_d==0);
        s(ss_dd)=1;
        
        ss=find(s==0);
        ss_L=min(length(ss),degree(i)-d);
        ss_r=ss(randperm(numel(ss),ss_L));
        s(ss_r)=1;
        
        s(ss_dd)=0;
        Net_rand(i,i+1:K)=s(i+1:K);
        Net_rand(:,i)=Net_rand(i,:)';
    end
end
clear d s ss_d ss_dd ss ss_L ss_r


d=degree-sum(Net_rand,2);
s=find(d>1);

% Disconnect an edge and connect it separately to the point where the degree constraint is not satisfied
for i=1:length(s)
    for j=1:floor(d(s(i))./2)
        ss=find(Net_rand(s(i),:)==0);
        ss_A=Net_rand(ss,ss);
        A=find(ss_A==1);
        ss_r=A(randperm(numel(A),1));
        A_i=mod(ss_r,length(ss));
        A_j=ceil(ss_r./length(ss));
        A_i=ss(A_i);
        A_j=ss(A_j);
        Net_rand(A_i,A_j)=0;Net_rand(A_j,A_i)=0;
        Net_rand(A_i,s(i))=1;Net_rand(s(i),A_i)=1;
        Net_rand(s(i),A_j)=1;Net_rand(A_j,s(i))=1;
    end
end


d=degree-sum(Net_rand,2);
s=find(d>0);
for i=1:length(s)/2
    A_i=s((i-1)*2+1);
    A_j=s(i*2);

    if Net_rand(A_i,A_j)==0
       Net_rand(A_i,A_j)=1;Net_rand(A_j,A_i)=1;
    else
      Net_rand(A_i,A_j)=0;Net_rand(A_j,A_i)=0;  
      
      ss=find(Net_rand(A_i,:)==0);
      ss_A=Net_rand(ss,ss);
      A=find(ss_A==1);
      ss_r=A(randperm(numel(A),1));
      A_ii=mod(ss_r,length(ss));
      A_jj=ceil(ss_r./length(ss));
      A_ii=ss(A_ii);
      A_jj=ss(A_jj); 
      Net_rand(A_ii,A_jj)=0;Net_rand(A_jj,A_ii)=0;
      Net_rand(A_ii,A_i)=1;Net_rand(A_i,A_ii)=1;
      Net_rand(A_i,A_jj)=1;Net_rand(A_jj,A_i)=1;
      
      ss=find(Net_rand(A_j,:)==0);
      ss_A=Net_rand(ss,ss);
      A=find(ss_A==1);
      ss_r=A(randperm(numel(A),1));
      A_ii=mod(ss_r,length(ss));
      A_jj=ceil(ss_r./length(ss));
      A_ii=ss(A_ii);
      A_jj=ss(A_jj); 
      Net_rand(A_ii,A_jj)=0;Net_rand(A_jj,A_ii)=0;
      Net_rand(A_ii,A_j)=1;Net_rand(A_j,A_ii)=1;
      Net_rand(A_j,A_jj)=1;Net_rand(A_jj,A_j)=1;
    end     
end
    




        
        

    

        