[X0, Y0, Z0, R1, G1, B1, mask] = xyzmread("hand 4.xyzm");

RGB(:, :, 1) = uint8(R1);
RGB(:, :, 2) = uint8(G1);
RGB(:, :, 3) = uint8(B1);
figure
imshow(RGB)
I = rgb2gray(RGB);
imshow(I);
level = graythresh(I);
BW = imbinarize(I, 0.32);
figure
imshow(BW);

[row, column] = size(BW);

count = 0;

for i = 1:row
    for j = 1:column
        if (BW(i, j) == 1)
            count = count + 1;
        end
    end
end


if count > 40000
    final = imfill(BW,'holes');
else
    
    final = imclose(BW, strel('disk', 10));
end


maskedRgbImage = bsxfun(@times, RGB, cast(final, 'like', RGB));
imshow(maskedRgbImage);
