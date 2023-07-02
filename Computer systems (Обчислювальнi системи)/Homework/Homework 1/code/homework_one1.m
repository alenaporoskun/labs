%  Пороскун Олена ПМ-81  
%      Homework 1       

% 1. Scalar variables.
a = 10
b = 2.5*10^23
c = 2 + 3*i
d = exp(j*2*pi/3)

% 2. Vector variables. 
aVec = [3.14 15 9 26]
bVec = [2.71; 8; 28; 182]
cVec = 5:-0.2:-5
dVec = logspace(0,1,100)
eVec = "Hello"

% 3. Matrix variables. 
aMat = 2*ones(9,9)
v = [1 2 3 4 5 4 3 2 1]
bMat = diag(v)
mas_c = 1:100;
cMat = reshape(mas_c, 10, 10)
dMat = nan (3,4)
eMat = [13, -1, 5;  -22, 10,-87]
fMat = randi([-3 3], 5, 3)

% 4. Scalar equations. 
x = 1/(1+exp(-(a-15)/6))
y = (sqrt(a)+ nthroot(b, 21))^pi
z = (log(real((c+d)*(c-d))*sin(a*pi/3)))/(c* conj(c))

% 5. Matrix equations. 
xMat = (aVec * bVec)*((aMat).^2)
yMat = (bVec * aVec)
zMat = (det(cMat))*(aMat * bMat)
zMat = det(cMat)

% 6. Common functions and indexing. 

cSum = sum(cMat)

eMean = mean(eMat')
eMean'

eMat(1, :) = 1

cMat
cSub = cMat(2:9, 2:9)

lin = 1:20
lin(mod(lin, 2) == 0) = (-1)*lin(mod(lin, 2) == 0)

r = rand(1,5)
r(find(r<0.5)) = 0

% 7. Plotting multiple lines and colors.

% 8. Manipulating variables.




