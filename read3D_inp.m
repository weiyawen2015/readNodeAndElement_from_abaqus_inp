clear
clc
close all

filename='3Dsquare.inp';
newname = [filename(1:end-4),'.txt'];
newnameInp = [filename(1:end-4),'_txt',filename(end-3:end)];
 if exist(newnameInp) >0
   delete(newnameInp)
 end  
  if exist(newname) >0
   delete(newname)
 end  
copyfile(filename,newnameInp);% �����ļ�
%% �޸�inp��׺����txt 
eval(['!rename' 32 newnameInp 32 newname]);
%% ��ȡ�ڵ�͵�Ԫ�Ŀ�ʼ�к�
 fileID = fopen(newname);
 C = textscan(fileID,'%s %s %s %s','Delimiter',',');
lineone = C{1};
i = 1;
while(i<=length(lineone))
    if strcmp(lineone{i},'*Node')
          hang_Node = i-1;
    end
    if strcmp(lineone{i},'*Element')
          hang_Element = i-1;
    end
    i = i+1;
end
fclose( fileID);
%% ��ȡ�ڵ���Ϣ
fileID = fopen(newname);
Node0= textscan(fileID,'%d %f %f %f','Delimiter',',','Headerlines',hang_Node); % ����5�У��������20��
fclose( fileID);
hao = Node0{1};
Node = [Node0{2} Node0{3} Node0{4}];
%% ��ȡ��Ԫ��Ϣ
 fileID = fopen(newname);
Element0 = textscan(fileID,'%d %f %f %f %f %f %f %f %f','Delimiter',',','Headerlines', hang_Element); % ����5�У��������20��
fclose( fileID);
hao = Element0{1};
Element2.node = [Element0{2}];
for i = 3:size(Element0,2)
    Element2.node = [Element2.node Element0{i}];
end
%% �Խ�polymat
for i = 1:size(Element2.node,1)
    Element{i,1} = [Element2.node(i,:)];
end
%% ��ʾ
figure(1)
plot3(Node(:,1),Node(:,2),Node(:,3),'b.')
axis equal
figure(2)
plot_voxel(Node,Element)