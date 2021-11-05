function plot_voxel(Node,Element)
Element2 = cell2mat(Element);
%% patch single material
nodeCoords_ = Node;
iMesh.eNodMat = int32(Element2);
iMesh.numNodes = size(Node,1);
iMesh.elementsOnBoundary = (1:size(Element2,1))';
iMesh.solidNodesMapVec = (1:size(Node,1))';
iMesh.nodesOnBoundary = (1:size(Node,1))';
numElesOnBound = numel(iMesh.elementsOnBoundary);%单元索引
patchIndices = zeros(4,6*numElesOnBound);
mapEle2patch = [4 3 2 1; 5 6 7 8; 1 2 6 5; 8 7 3 4; 5 8 4 1; 2 3 7 6]';
for ii=1:numElesOnBound
    index = (ii-1)*6;
    iEleVtx = iMesh.eNodMat(iMesh.elementsOnBoundary(ii),:)';
    patchIndices(:,index+1:index+6) = iEleVtx(mapEle2patch);
end
allNodes = zeros(iMesh.numNodes,1);
allNodes(iMesh.nodesOnBoundary) = 1;
allNodes = allNodes(patchIndices');
allNodes = sum(allNodes,2);
patchIndices = patchIndices(:,find(4==allNodes)');
tarNodeCoords = nodeCoords_(iMesh.solidNodesMapVec,:);
xPatchs = tarNodeCoords(:,1); xPatchs = xPatchs(patchIndices);
yPatchs = tarNodeCoords(:,2); yPatchs = yPatchs(patchIndices);
zPatchs = tarNodeCoords(:,3); zPatchs = zPatchs(patchIndices);
cPatchs = zeros(size(xPatchs));	

hd = patch(xPatchs, yPatchs, zPatchs, cPatchs);	
	set(hd, 'FaceColor', [65 174 118]/255, 'FaceAlpha', 0.5,'EdgeColor', [1 1 1]*0.8);
    
	axis('on'); axis('equal'); axis('tight');
	view(3); camproj('perspective');
	lighting('gouraud');
	camlight('headlight','infinite');
	camlight('right','infinite');
	camlight('left','infinite');
	material('metal');
	xlabel('X'); ylabel('Y'); zlabel('Z');
	set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
    
    
    
    
%% patch muiti material
% %-------------------------------
% load Color
% load RBM
% fem.NElem = numel(Element);
% fem.Node = Node;
% fem.Element = Element;
% fem.NMat = 3;
% V = zeros(fem.NElem,fem.NMat);
% V(1:200,:) = repmat([1 0 0],200,1);
% V(201:400,:) = repmat([0 1 0],200,1);
% V(401:end,:) = repmat([0 0 1],225,1);
% %-------------------------------
% 
% Tri = zeros(6*fem.NElem,4);
% map = zeros(size(Tri,1),1); index=0;
% face_index = [1 2 3 4
%              5 6 7 8
%              1 2 6 5
%              2 3 7 6
%              3 4 8 7
%              4 1 5 8];%全部逆时针
% for el = 1:fem.NElem
%   for enode = 1:6
%     map(index+1) = el;
%     Tri(index+1,:) = fem.Element{el}(face_index(enode,:));
%     index = index + 1;
%   end
% end
% tic
% z0 = V;
% I=[zeros(fem.NElem,3),ones(size(z0,1),1)];
% for i=1:fem.NMat
%     I(:,1:3) = I(:,1:3) + z0(:,i)*Color(i,1:3);
% end
% IT = RBM*I';
% I = IT';
% handle = patch('Faces',Tri,'Vertices',fem.Node,'FaceVertexCData',...
%                I(map,1:3),'FaceColor','flat','EdgeColor',[1 1 1]*1,'FaceAlpha',0.9);  
% toc
% axis equal; axis off; axis tight; 
% xlabel('X'); ylabel('Y'); zlabel('Z');
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
% view(3); camproj('perspective');



    
    
    
    
    
    
    
    
    
    
    