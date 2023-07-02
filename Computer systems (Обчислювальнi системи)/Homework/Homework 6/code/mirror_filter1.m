% HW 6 mirror filter

disp(' ');
disp(' - - - - - - - - - - - - ');
disp(' ');

filename = 'Manhwa'; 
image = imread(filename, 'jpg');
figure;
imshow(image)

size_image = size(image)
rows = size_image(1)
columns = size_image(2)
columns/2
med_c = ceil(columns/2)
key = 0;
for i = 1:rows     
    for j = 1:med_c 
        key = image(i, j, :);
        image(i, j,:) = image(i, 705-j+1, :);
        image(i, 705-j+1, :) = key;
    end
end

figure;
imshow(image)

rows/2
med_r = ceil(rows/2)
key = 0;
for i = 1:med_r    
    for j = 1:columns 
        key = image(i, j, :);
        image(i, j,:) = image(rows-i+1, j, :);
        image(rows-i+1, j, :) = key;
    end
end

figure;
imshow(image)
