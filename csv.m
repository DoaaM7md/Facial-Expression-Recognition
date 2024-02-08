T = readtable('C:\Users\Doaa\Downloads\FEC_dataset.zip\FEC_dataset\faceexp-comparison-data-test-public.csv');
V = T.Variables;
V = V - min(V(:));
V = V ./ max(V(:)) * 255;
Img = uint8(V);