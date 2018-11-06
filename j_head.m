% computation of gradient terms for Jacobian matrix Jn
function out = j_head(Q,H,n,h_diff,pipe_matrix)
    out = zeros(length(H),length(H));
    for i = 1 : length(H)
        for j = 1:length(H)
           if i == j % diagonal terms of matrix
             index = getPipeAtNode(pipe_matrix,i);
             q = Q(index);
             h = h_diff(index);
             out(i,j) = sum(q./(n.*h));
           end
           if i ~= j % off-diagonal terms of matrix
              top_index = (pipe_matrix(i,:).*(pipe_matrix(j,:)==1));
              q = Q(find(top_index==1));
              h = abs(H(i)-H(j));
              out(i,j) = -sum((q/(n.*h)));        
           end
        end
    end
end