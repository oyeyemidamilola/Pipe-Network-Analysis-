% To get other nodes connected to a specific node.
function output = getNode(node_matrix,node)
    if nargin < 2
        error('incomplete arguments');
    end
    dimension = size(node_matrix);
    if dimension(1)~=dimension(2)
        error('Error in node matrix input. Computation can not be made. node matrix must be a square matrix.');
    end
    output = find(node_matrix(node,:)==1);
end