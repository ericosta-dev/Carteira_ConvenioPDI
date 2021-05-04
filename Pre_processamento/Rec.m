close all
clear all
pkg load image

im = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Imagens_carteiras/num.jpg');

imZeros = zeros(size(im,1),size(im,2));
imZeros(im<120) = 1;
imshow(imZeros);
imCort = imZeros(10:size(imZeros,1),1:size(imZeros,2),:);
imbw = im2bw(imCort)

stats = regionprops(imbw,'Image','Area');

quantidadeObjetos = size(stats,1)
media = 0;
for i=1:quantidadeObjetos
  media = stats(i).Area + media
end
media = media / quantidadeObjetos;

cont=1
for i=1:size(stats,1)
  if(stats(i).Area > media /2)
     regioes_num(cont) = stats(i);
     cont = cont + 1
  endif
endfor


for i =1:size(regioes_num,2)
  figure(i+1);
  imshow(regioes_num(i).Image);
end;

#stats.Image
