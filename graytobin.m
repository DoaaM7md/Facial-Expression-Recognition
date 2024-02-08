function NewI=graytobin(I)
[W H L]=size(I);
for i=1:W
    for j=1:H
       % NewI(i,j)=I(i,j,1)+I(i,j,2)+I(i,j,3)/3;
       %NewI(i,j)=I(i,j,1);
       NewI(i,j)=I(i,j,1)*.2+I(i,j,2)*.1+I(i,j,3)*.2;
    end
end
imshow(NewI);
end