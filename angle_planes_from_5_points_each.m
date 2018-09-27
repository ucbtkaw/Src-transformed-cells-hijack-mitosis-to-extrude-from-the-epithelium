%Calculate angle between two planes defined by 5 points

%INPUTS:
    %
    %X: a N by 3 matrix where each line is a sample point
%OUTPUTS:
    %
    %n : a unit (column) vector normal to the plane
    %V : a 3 by 2 matrix. The columns of V form an orthonormal basis of the
    %plane
    %p : a point belonging to the plane
    
XT=[GX GY GZ];
YT=[RX RY RZ];
angle=[]

for j=0:37 %number of time points%
    X=XT((1+5*j):(5+5*j),:);
    Y=YT((1+5*j):(5+5*j),:);
        
%Create the first plane parameters    
p1 = mean(X,1);
R1 = bsxfun(@minus,X,p1);
[V1,D1] = eig(R1'*R1);
n1 = V1(:,1);
V1 = V1(:,2:end);

%Create the second plane parameters    
p2 = mean(Y,1);
R2 = bsxfun(@minus,Y,p2);
[V2,D2] = eig(R2'*R2);
n2 = V2(:,1);
V2 = V2(:,2:end);

%Calculate the angle between the planes
angle = [angle,acosd(dot(n1,n2))];
if angle>90
    angle = 180-angle;
end
end

%Edit time variables to match angles
RTime1=[];
for j=0:37
RTime1=[RTime1,RTime((1+5*j):(5+5*j),:)];
end
RTime2=RTime1(1,:);

%Plot angle change against time
plot(RTime2,angle)