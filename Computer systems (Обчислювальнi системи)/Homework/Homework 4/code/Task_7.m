% Пороскун Олени ПМ-81
% Homework 4
% 7. Image processing. 

im = displayRGB('M1.jpg');

function im = displayRGB(filename)

[PATHSTR,NAME,EXT] = fileparts(filename);
if (EXT == '.jpg')                                                         % функція має працювати тільки для зображень *.jpg
    myImage = imread(filename);                                            % imread - читання зображення з файлу
    myImageSize = size(myImage);
    myImage = double(myImage);                                             % double - представлення елементів масиву у форматі double
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
   
        for i = 1:3                                                        % ZI = interp2(X,Y,Z,XI,YI,method) - повертає матрицю ZI, що містить     
            newImage(:,:,i) = interp2(X,Y,myImage(:,:,i),Xn,Yn,'cubic');   % значення функції в точках, заданих аргументами XI і YI, отримані   
        end                                                                % шляхом інтерполяції двовимірної залежності, заданої матрицями X,Y і Z.
    
    else
        newImage = myImage;
    end
       
    myImage = uint8(myImage);                   % B = uint8(A) - функція uint8 використовується для перетворення елементів масиву
    newImage = uint8(newImage);                 % A в цілі невід'ємні числа в діапазоні [0, 255] і поміщає їх в новий масив В.
 
    imageRed = newImage;                        % створюємо зображенння в червоному кольорі замінюючи значення в палітрі RGB
    imageRed(:,:,2) = 0;                        % зеленого та блакитного на 0 
    imageRed(:,:,3) = 0;                                              
    imageGreen = newImage;                      % створюємо зображенння в зеленому кольорі замінюючи значення в палітрі RGB
    imageGreen(:,:,1) = 0;                      % червоного та блакитного на 0
    imageGreen(:,:,3) = 0;
    imageBlue = newImage;                       % створюємо зображенння в блакитному кольорі замінюючи значення в палітрі RGB
    imageBlue(:,:,1) = 0;                       % червоного та зеленого на 0
    imageBlue(:,:,2) = 0;                                              
    imageDecomposition = [newImage,imageRed; imageGreen,imageBlue];        % створюємо матрицю з 4 уже заданих раніше  зображень

    figure;                                 
    im = imageDecomposition;                    % im повинен бути кінцевим зображенням, що повертається у вигляді матриці
    image(im);                                  % image - відображення растрових зображень у графічному вікні
    title('Task 7  HW 4');
    axis tight                                  % axis tight - встановлює діапазони координат по осях відповідно до діапазонів зміни даних.
else
    disp('The file received is not jpg.');
    im = 0;
end
end                                                                        
