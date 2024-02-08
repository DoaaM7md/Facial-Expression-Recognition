function [ gray ] = rgbtogray( rgb ,option )
[H W L]=size(rgb);
gray=zeros(H, W );
gray=double(gray);
for i=1:H
    for j=1:W
        if option==1
        gray(i,j)=(rgb(i,j,1)+rgb(i,j,2)+rgb(i,j,3))/3;
        end
         if option==2
        gray(i,j)=rgb(i,j,1)*0.4+rgb(i,j,2)*0.3+rgb(i,j,3)*0.3;
         end
         if option==3
        gray(i,j)=rgb(i,j,1);
         end 
         if option==4
        gray(i,j)=rgb(i,j,2);
         end
         if option==5
        gray(i,j)=rgb(i,j,3);
         end 
    end
end       
gray=uint8(gray);
end