clc;
clear;
%% User Defined Inputs
% parameters for the pipe network analysis
node_matrix = xlsread(uigetfile('*.xlsx','Select the file for node matrix'));
pipe_matrix = xlsread(uigetfile('*.xlsx','Select the file for pipe matrix'));
%%
n_nodes = length(node_matrix);
n_pipes = size(pipe_matrix,2);


% required pipe network parameters

H = zeros(1,n_nodes);
K = zeros(1,n_pipes);
F_n = zeros(1,n_nodes);
q = zeros(1,n_nodes);
Q = zeros(1,n_pipes);
h_diff = zeros(1,n_pipes);

% collecting data for initially assumed heads, H
for i = 1:n_nodes
    fprintf('Input assumed head(H) for node %g:',i);
    H(i) = input(''); 
end


% collecting data for flow coeffiecint(K) for each pipe
for i = 1:n_pipes
    fprintf('Input flow coeffiecint(K) for pipe %g:',i);  
    K(i)=input('');
end

% collecting data for flow demand/supply(q) at each node
for i = 1:n_nodes
    fprintf('Input flow demand/supply(q) for node %g:',i);
    q(i)=input('');
end

% collecting data for flow equation index (n=2 for D-W equation; n=1.85 for H-W equation)
fprintf('Input the value of flow equation index(n):');
n = input('');
%% 
tol = 0.05;
while tol == 0.05   
    
% calculating Flow, Q
    for i = 1:n_pipes
        k_index = getNodeAtPipe(pipe_matrix,i);
        
        Q(i)= (abs(H(k_index(1))-H(k_index(2)))/K(i))^(1/n);
    end
    
    
    % calculating nodal balances, F_n
    for i = 1:n_pipes
        h_index = getNodeAtPipe(pipe_matrix,i);
        h_diff(i) = abs(H(h_index(1))-H(h_index(2)));
    end
    for i = 1: n_nodes
        h_index = getPipeAtNode(pipe_matrix,i); 
        k_index = getNode(node_matrix,i);
%       F_n(i)= sum(Q(h_index));
        for j = 1:numel(h_index)
            if (H(k_index(j))-H(i)) < 0 % negative flow
                F_n(i) = F_n(i) - Q(h_index(j));
            end
            if (H(k_index(j))-H(i)) > 0 % positive flow
                F_n(i) = F_n(i) + Q(h_index(j)); 
            end
        end    
        F_n(i)= F_n(i)-q(i);
%         disp(Q)
    end
    %% 
        J_n = j_head(Q,H,n,h_diff,pipe_matrix);
        delta_h = inv(J_n)*(-F_n)'; %J_n\(-F_n)'; %inv(J_n)*(-F_n'); %linsolve(J_n,(-F_n)');
        H = H - delta_h';
        %disp(H)
        disp(delta_h)
        tol = max(delta_h);
        disp(tol)
        
end