% To get all the pipes connected to a specific node.
function output  = getPipeAtNode(pipe_matrix,node)
    if nargin < 2
        error('incomplete arguments');
    end
%     dimension = size(pipe_matrix);
%     if dimension(1)~=dimension(2)
%         error('The pipes are not completely represented.Computation can not be made');
%     end
    output = find(pipe_matrix(node,:)==1);
end