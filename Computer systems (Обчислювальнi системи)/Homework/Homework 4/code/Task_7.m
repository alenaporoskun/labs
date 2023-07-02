% �������� ����� ��-81
% Homework 4
% 7. Image processing. 

im = displayRGB('M1.jpg');

function im = displayRGB(filename)

[PATHSTR,NAME,EXT] = fileparts(filename);
if (EXT == '.jpg')                                                         % ������� �� ��������� ����� ��� ��������� *.jpg
    myImage = imread(filename);                                            % imread - ������� ���������� � �����
    myImageSize = size(myImage);
    myImage = double(myImage);                                             % double - ������������� �������� ������ � ������ double
    newLength = 800;

    if (max(myImageSize) ~= newLength)    
        myImageSize = size(myImage);
        x = 1:myImageSize(2);  
        y = 1:myImageSize(1);
        [X,Y] = meshgrid(x,y); 
    
        newSize = floor(myImageSize / max(myImageSize)*newLength);   
        xn = linspace(1, myImageSize(2), newSize(2));   
        yn = linspace(1, myImageSize(1), newSize(1)); 
        [Xn,Yn] = meshgrid(xn,yn);
   
        for i = 1:3                                                        % ZI = interp2(X,Y,Z,XI,YI,method) - ������� ������� ZI, �� ������     
            newImage(:,:,i) = interp2(X,Y,myImage(:,:,i),Xn,Yn,'cubic');   % �������� ������� � ������, ������� ����������� XI � YI, �������   
        end                                                                % ������ ������������ ��������� ���������, ������ ��������� X,Y � Z.
    
    else
        newImage = myImage;
    end
       
    myImage = uint8(myImage);                   % B = uint8(A) - ������� uint8 ��������������� ��� ������������ �������� ������
    newImage = uint8(newImage);                 % A � ��� ����'��� ����� � ������� [0, 255] � ����� �� � ����� ����� �.
 
    imageRed = newImage;                        % ��������� ����������� � ��������� ������ �������� �������� � ����� RGB
    imageRed(:,:,2) = 0;                        % �������� �� ���������� �� 0 
    imageRed(:,:,3) = 0;                                              
    imageGreen = newImage;                      % ��������� ����������� � �������� ������ �������� �������� � ����� RGB
    imageGreen(:,:,1) = 0;                      % ��������� �� ���������� �� 0
    imageGreen(:,:,3) = 0;
    imageBlue = newImage;                       % ��������� ����������� � ���������� ������ �������� �������� � ����� RGB
    imageBlue(:,:,1) = 0;                       % ��������� �� �������� �� 0
    imageBlue(:,:,2) = 0;                                              
    imageDecomposition = [newImage,imageRed; imageGreen,imageBlue];        % ��������� ������� � 4 ��� ������� �����  ���������

    figure;                                 
    im = imageDecomposition;                    % im ������� ���� ������� �����������, �� ����������� � ������ �������
    image(im);                                  % image - ����������� ��������� ��������� � ���������� ���
    title('Task 7  HW 4');
    axis tight                                  % axis tight - ���������� �������� ��������� �� ���� �������� �� �������� ���� �����.
else
    disp('The file received is not jpg.');
    im = 0;
end
end                                                                        
