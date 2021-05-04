close all
clear all
pkg load image

im = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Imagens_carteiras/num.jpg');
im = im(5:size(im,1),1:size(im,2),:);

imZeros = zeros(size(im,1),size(im,2));
imZeros(im<120) = 1;
imshow(imZeros);
 

imbw = im2bw(imZeros)
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
     numeros(cont) = stats(i);
     cont = cont + 1
  endif
endfor


for i =1:size(numeros,2)
  figure(i+1);
  imshow(numeros(i).Image);
end;

a = numeros(1).Image

imresize (a, [65 35]);
figure, imshow(a)




b(1).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/1.jpeg');
b(2).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/2.jpeg');
b(3).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/3.jpeg');
b(4).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/4.jpeg');
b(5).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/5.jpeg');
b(6).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/6.jpeg');
b(7).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/7.jpeg');
b(8).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/8.jpeg');
b(9).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/9.jpeg');
b(10).Image = imread('I:/UFRN/Projeto PDI/Carteira_ConvenioPDI/Descritores/0.jpeg');



for i=1:size(b,2)
 bin(i).Image = zeros(size(b(i).Image,1),size(b(i).Image,2));
 bin(i).Image(b(i).Image<120) = 1;
 figure,imshow(bin(i).Image);
 
end

%b = bin(1).Image

%c = a - b
%d = b - a

%figure, imshow(c)
%figure, imshow(d)

