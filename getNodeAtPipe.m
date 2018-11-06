% To get the end nodes of a specific pipe.
function output  = getNodeAtPipe(pipe_matrix,node)
    if nargin < 2
        error('incomplete arguments');
    end
%     dimension = size(pipe_matrix);
%     if dimension(1)>dimension(2)
%         error('The pipes are not completely represented.Computation can not be made');
%     end
    output = find(pipe_matrix(:,node)==1);
    output = output';
end
