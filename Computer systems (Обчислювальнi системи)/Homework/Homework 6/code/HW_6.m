% Пороскун Олени ПМ-81 
% Homework 6

menu()
M = input('Select a number and enter it: ');
i=0;
while (i == 0)
    switch M
        case 1
            disp('You choose 1 - new image');
            filename = input('Enter name of file: ', 's'); 
            image = imread(filename, 'jpg');
        case 2
            disp('You choose 2 - original');
            figure;   imshow(image);
        case 3
            disp('You choose 3 - negative filter');
            negative(image);
        case 4
            disp('You choose 4 - sharpen filter');
            sharpen(image);
        case 5
            disp('You choose 5 - posterize filter');
            posterize(image);
        case 6
            disp('You choose 6 - blur filter');
            blur(image);
        case 7
            disp('You choose 7 - mirror filter'); 
            mirror(image)
        case 0 
            break;
        otherwise
            disp(' ');
            disp('invalid selection');
    end
    disp(' ');
    menu();
    M = input('Select a number and enter it: ');
end

function menu()
disp('A menu of choices:');
disp('1. new image');
disp('2. original');
disp('3. negative');
disp('4. sharpen');
disp('5. posterize');
disp('6. blur');
disp('7. mirror');
disp('Enter 0 to quit.');
end

function negative(image)
image = 255 - image;
figure;  imshow(image)
end

function sharpen(image)
size_image = size(image);
rows = size_image(1);
columns = size_image(2);

for i = 1:rows  
    for j = 1:columns
        if (image(i,j) < 128)
            image(i,j,:) = image(i,j, :) - 16;
        else  
            image(i,j,:) = image(i,j, :) + 16;
        end
    end
end
figure;  imshow(image)
end

function posterize(image)
size_image = size(image);
for i = 1:size_image(1)     
    for j = 1:size_image(2) 
        if (image(i,j) >= 0  && image(i,j) <= 71) 
            image(i,j,:) = 0;
        end
        if (image(i,j) >= 72 && image(i,j) <= 127)
            image(i,j,:) = 72;
        end
        if (image(i,j) >= 128 && image(i,j) <= 183)
            image(i,j,:) = 183;
        end
        if (image(i,j) >= 184 && image(i,j) <= 255)
            image(i,j,:) = 255;
        end
    end
end
figure;  imshow(image)
end

function blur(image)
[row, col] = size(image);
for i = 1+2:row-2
    for j = 1+2:col-2
        im = image(i-2:i+2, j-2:j+2);
        image(i,j) = sum(im(:))/25;
    end
end
figure;  imshow(image)
end

function mirror(image)
size_image = size(image);
rows = size_image(1);
columns = size_image(2);

med_c = ceil(columns/2);
for i = 1:rows     
    for j = 1:med_c 
        key = image(i, j, :);
        image(i, j,:) = image(i, columns-j+1, :);
        image(i, columns-j+1, :) = key;
    end
end
figure;  imshow(image)

med_r = ceil(rows/2);
for i = 1:med_r    
    for j = 1:columns 
        key = image(i, j, :);
        image(i, j,:) = image(rows-i+1, j, :);
        image(rows-i+1, j, :) = key;
    end
end
figure;  imshow(image)
end