function [hist] = Histogram(I)
[W H] =size(I)
hist =zeros(256,1)
for i=1:W
    for j=1:H
        hist(I(i,j)+1)= hist(I(i,j)+1)+1;
    end
end
bar(hist)
figure,imshow(hist);
end