function output  = getPipeAcross(pipe_matrix,pipe)
    if nargin < 2
        error('incomplete arguments');
    end

    output = find(pipe_matrix(:,pipe)==1);
    output = output';
end