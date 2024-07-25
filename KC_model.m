function [spiking,module_spiking_E,module_spiking_I]=KC_model(Net_link,Net_p)
% reference:Optimal dynamical range of excitable networks at criticality
% Neuron arrangement: the first 4/5 are excitatory neurons, and the last 1/5 are inhibitory neurons

% Net_p:synaptic weighted matrix

N=size(Net_link,1);
L=20500;
r=2*10^(-4);% Poisson process with constant rate r
n=5;% refractory states:2,3,...,n-1

GE_loc=cell(N,1);
GI_loc=cell(N,1);
for k=1:N
    GE_s=Net_link(k,1:4*N/5);
    GE_loc{k}=find(GE_s==1);
    GI_s=Net_link(k,1+4*N/5:N);
    GI_loc{k}=find(GI_s==1);
    GI_loc{k}=GI_loc{k}+4*N/5;
end

neuron=zeros(N,L);
spiking=zeros(N,L);
for i=1:L-1
    for j=1:N
        if neuron(j,i)==0
            lamda=1-exp(-r);
            neuron_ex=double(rand<lamda);
            E_p=Net_p(j,GE_loc{j})*spiking(GE_loc{j},i);
            I_p=Net_p(j,GI_loc{j})*spiking(GI_loc{j},i);
            neuron_con=double(rand<(E_p+I_p));
            neuron(j,i+1)=double(neuron_ex|neuron_con);
            spiking(j,i+1)=double(neuron(j,i+1)==1);
        else if neuron(j,i)<(n-1)
                neuron(j,i+1)=neuron(j,i)+1;
            else
                neuron(j,i+1)=0;
            end
        end
    end
end
spiking(:,1:500)=[];

module_spiking_E=zeros(10,size(spiking,2));
module_spiking_I=zeros(10,size(spiking,2));
for i=1:10
    module_spiking_E(i,:)=sum(spiking((i-1)*80+1:i*80,:));
    module_spiking_I(i,:)=sum(spiking((i-1)*20+801:i*20+800,:));
end


    





            
            
            


