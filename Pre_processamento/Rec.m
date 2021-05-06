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
  %figure(i+1);
  %imshow(numeros(i).Image);
end;




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
 bw(i).Image = im2bw(b(i).Image)
 %figure,imshow(bw(i).Image);
end

for i=1:size(b,2)
 bw2(i).Image = !bw(i).Image;
 status(i) = regionprops(bw2(i).Image,'Image','Area');
 %figure, imshow(status(i).Image);
end

for i=1:size(b,2)
  %figure('Image',i)
  %imshow(status(i).Image);
  status(i).("Valor") = i;
  if i = 10
    status(10).("Valor") = 0; 
  end
end

%52 x 30 = 1560
for k=1:size(numeros,2) %inicio for carteira
  armazena_val = 1560;
  for l =1:size(b,2) %inicio for banco
    %Iniciando comparacao
    analise = imresize( double(numeros(k).Image), [52 30]);
    banco = imresize( double(status(l).Image),[52 30]);
    comparacao =  analise - banco;
    comparacaoBW = im2bw(comparacao);
    %figure, imshow(comparacaoBW);
    
    %Contando as quantidadades de pixes brancos
    qntUm = sum(sum(comparacaoBW));
    
  %se a quantidadade de Um's for menor que a armazenada
    if (qntUm < armazena_val)
      armazena_val = qntUm ;   %substitui a menor
      valor = int2str(status(l).Valor)
      imagem_numero = status(l).Image 
      %figure, imshow(comparacaoBW);
    end
  end
  saida(k).("Valor") =  valor;
end

disp("---------- RESULTADOS: ----------");
disp("                                 ");
for s=1:size(saida,2);
  disp(strcat("Valor Numero_", num2str(s)," = ",num2str(saida(s).Valor) ))
end;

    %for i=1:size(comparacaoBW,1)
    %  for j=1:size(comparacaoBW,2)
    %    if (comparacaoBW(i,j) = 1)
    %      qntUm = qntUm + 1;
    %    end
    %  end
    %end