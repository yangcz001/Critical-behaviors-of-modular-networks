function A=Modular(C_num,C_size,p_in,p_inter)
% construct a modular network
% C_num:number of modules
% C_size: size of modules
% p_in: the probability of random connections of neurons within the module
% p_inter: the probability of random connections of excitatory neurons from
% different modules
% Parameter setting recommendation:C_num=10,C_size=100;p_in=0.2;p_inter=0.005;

N=C_num*C_size;
A=zeros(N);
B=rand(N);
B=B-tril(B);
C=zeros(N);
for i=1:C_num-1
    B_in=B(1+(i-1)*C_size:i*C_size,1+(i-1)*C_size:i*C_size);
    C_in=zeros(C_size);
    C_in(B_in>=1-p_in)=1;
    B_out=B(1+(i-1)*C_size:i*C_size,1+i*C_size:end);
    C_out=zeros(size(B_out));
    C_out(B_out>1-p_inter)=1;
    
    D_out=ones(size(B_out));
    d=size(B_out,2)/C_size;
    D_out(1+4*C_size/5:C_size,:)=0;
    for j=1:d
        D_out(:,1+j*C_size-C_size/5:j*C_size)=0;
    end
    C_out=double(C_out&D_out);
    
    C(1+(i-1)*C_size:i*C_size,1+(i-1)*C_size:i*C_size)=C_in;
    C(1+(i-1)*C_size:i*C_size,1+i*C_size:end)=C_out;
end
i=C_num;
B_in=B(1+(i-1)*C_size:i*C_size,1+(i-1)*C_size:i*C_size);
C_in=zeros(C_size);
C_in(B_in>=1-p_in)=1;  
C(1+(i-1)*C_size:i*C_size,1+(i-1)*C_size:i*C_size)=C_in;
C=C+C';

A=double(A|C);
for i=1:N
    A(i,i)=0;
end

image(A,'CDataMapping','scaled');



