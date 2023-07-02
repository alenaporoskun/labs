% HW 6 blur filter

disp(' ');
disp(' - - - - - - - - - - - - ');
disp(' ');

filename = 'Manhwa'; 
image = imread(filename, 'jpg');
figure;
imshow(image)

[row, col] = size(image);
for i = 1:row
    for j = 1:col
        %if (i-2 <= 0 && j-2 <= 0)
        %    continue;
        %elseif(i+2 <= row && j+2 <= col)
        im = image(i-2:i+2, j-2:j+2);
        %number_im = length(im(:));
        %image(i,j,:) = sum(im(:)) / number_im;
        image(i,j) = sum(im(:))/25;
        %end
    end
end

figure;
imshow(image)