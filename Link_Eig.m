function [Net_p,Eig_EI]=Link_Eig(Net_p,GE,GI,Ai,r_E,r_I)
% The variations in network state resulting from local excitation-inhibition imbalance
% GE¡¢GI:equivalent to GE_loc¡¢GI_loc in KC_model.m
% Ai: selected excitatory neurons whose excitation is manipulated
% r_E: The multiplier of excitatory connections
% r_I: The multiplier of inhibitory connections

K=size(Net_p,1);
Node_EI=zeros(K,2);
for i=1:K
    Node_EI(i,1)=length(GE{i});
    Node_EI(i,2)=length(GI{i});
end

% the excitation of neurons Ai is manipulated
Ai_n=length(Ai);
A_E=Ai;
for i=1:Ai_n
    Aj=[GE{Ai(i)}];
    A_E=[A_E Aj];
    Net_p(Aj,Ai(i))=Net_p(Aj,Ai(i))*r_E;
end
A_E=unique(A_E);

% inhibitory connections to neurons Ai change accordingly
A_E_n=length(A_E);
for i=1:A_E_n
    linki_I=GI{A_E(i)};
    Net_p(A_E(i),linki_I)=Net_p(A_E(i),linki_I)*r_I;
end

[a,b]=eig(Net_p);
d=real(diag(b));Eig_EI(1,1)=max(d);
clear a b d 









