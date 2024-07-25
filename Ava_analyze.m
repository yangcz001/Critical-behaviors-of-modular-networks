function [ava_spiking,ava_loc]=Ava_analyze(spiking)
% Avalanche analysis

T_bin=1;
spiking_th=2;
L=size(spiking,2);
L_n=floor(L/T_bin);
spiking_count=zeros(1,L_n);

for i=1:L_n
    spiking_count(1,i)=sum(sum(spiking(:,(i-1)*T_bin+1:i*T_bin)));
end


s=find(spiking_count>spiking_th);
s_d=s(2:end)-s(1:end-1);
ss=find(s_d>1);
ava_loc{1}=s(1:ss(1));
 for i=1:length(ss)-1
     ava_loc{i+1}=s(ss(i)+1:ss(i+1));
 end
 ava_loc{length(ss)+1}=s(ss(end)+1:end);
 clear s s_d ss
 
 % The number of neurons involved in each avalanche and the total spiking were counted
 for i=1:length(ava_loc)
     s=ava_loc{i};
     ss=spiking(:,s);
     sss=sum(ss,2);
     sss_loc=find(sss>0);
     ava_neuron{i}=sss_loc;
     ava_spiking(i)=sum(spiking_count(s));
 end
 clear s ss sss sss_loc

end

