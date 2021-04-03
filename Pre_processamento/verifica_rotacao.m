close all
clear all
pkg load image

%Abre open file para selecionar a imagem%
[fileName, pathName] = uigetfile({'*.jpeg'});
path_img = strcat(pathName, fileName);
im = imread(path_img);

figure('Name','Imagem Lida');
imshow(im);


%Saber se ta ao contrario ou nao%
altura_metade = size(im,1)/2
for i=1:altura_metade
  for j=1:size(im,2) 
    im_cort(i,j,:) = im(i,j,:);
  end
end;

  %figure('Name','Imagem cortada');
  %imshow(im_cort)

soma = sum(sum (im_cort))/(size(im_cort,1)*size(im_cort,2));

%se a media de verde for menor ou igual que 120 ele roda a imagem%
if soma(:,:,2) <= 120
   im_final = imrotate(im,180);
   figure('Name','Imagem rodada');
   imshow(im_final)
else
   im_final = im;
end

%Deixa mais escuro a imagem para facilitar a proxima etapa%
for i=1:size(im_final,1)
  for j=1:size(im_final,2) 
    if ((im_final(i,j,1) < 60) && (im_final(i,j,2) < 100) && (im_final(i,j,3) < 60)) %pixel verde
      im_final(i,j,:) = 0;
    else
      im_final(i,j,:) = im_final(i,j,:);
      
    end
  end
end;

figure('Name','Imagem final');
imshow(im_final);

%Fase de segmentação%

##for i=1:size(im_final,1)
##  for j=1:size(im_final,2) 
##    if (((im_final(i,j,1) > 155) && (im_final(i,j,1) < 165)) 
##        && ((im_final(i,j,2) > 170) && (im_final(i,j,2) < 185)) 
##        && ((im_final(i,j,3) > 165) && (im_final(i,j,3) < 170))) %encontrar o branco
##      linha = im_final(i);
##    end
##  end
##end;

linha     = round(size(im_final)*0.35);
linha_fim = linha + 250;

im_seg_fin = im_final(linha:linha_fim,1:size(im_final,2),:)

figure('Name','Imagem segmentada final');
imshow(im_seg_fin);

%transformando a imagem para b&w
img_gray = rgb2gray(im_seg_fin);

%limiarizando
LIMIAR = 100;
B = img_gray;
B(B<=LIMIAR) = 0;
B(B>LIMIAR) = 255;
figure, imshow(B);

num_cart = B(1:115,1:1000,:);
nome_cart = B(200:size(B,1),1:1000,:);

figure, imshow(num_cart);
figure, imshow(nome_cart);