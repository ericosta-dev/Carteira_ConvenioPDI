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

%figure('Name','Imagem final');
%imshow(im_final);

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

%figure('Name','Imagem segmentada final');
%imshow(im_seg_fin);

%transformando a imagem para b&w
img_gray = rgb2gray(im_seg_fin);

%limiarizando
LIMIAR = 100;
B = img_gray;
B(B<=LIMIAR) = 0;
B(B>LIMIAR) = 255;
%figure, imshow(B);

num_cart = B(1:115,1:1000,:);
nome_cart = B(200:size(B,1),1:1000,:);

%figure, imshow(num_cart);
%figure, imshow(nome_cart);

#################################TIRANDO OS RUIDOS PRETOS#######################################
%binarizando%
im2 = zeros(size(nome_cart,1),size(nome_cart,2));
im2(nome_cart>120) = 1;
%figure('Name','Imagem Binarizada')
%imshow(im2, [0 1])

EE = [0 0 0; 0 0 0; 0 0 0]; % O EE, dentro da forma escolhida (quadrado), possui valores iguais aos valores de frente da imagem
imErode2 = im2;
for i=2:size(im2,1)-1
  for j=2:size(im2,2)-1
    if(im2(i,j)==0) %se o pixel central da vizinhança de im2 for de frente (foreground preto - 0), deve ser analizado
      % se nem todos os pixels são iguais entre a vizinhança de im2 e EE
      if !(im2(i-1,j-1)==EE(1,1) && im2(i-1,j)==EE(1,2) && im2(i-1,j+1)==EE(1,3) ...
        && im2(i,j-1)==EE(2,1) && im2(i,j)==EE(2,2) && im2(i,j+1)==EE(2,3) ...
        && im2(i+1,j-1)==EE(3,1)   && im2(i+1,j)==EE(3,2)   && im2(i+1,j+1)==EE(3,3) )
         imErode2(i,j)=1; % erode o pixel (passa a ser pixel de fundo - background branco - 1)
      end    
    end
  end
end

figure('Name','Imagem Erodida Geometrico - SEM RUÍDOS PRETOS')
imshow(imErode2)

im3 = zeros(size(num_cart,1),size(num_cart,2));
im3(num_cart>120) = 1;
%figure('Name','Imagem Binarizada')
%imshow(im3, [0 1])

EE = [0 0 0; 0 0 0; 0 0 0];
imErode = im3;
for i=2:size(im3,1)-1
  for j=2:size(im3,2)-1
    if(im3(i,j)==0)
      if !(im3(i-1,j-1)==EE(1,1) && im3(i-1,j)==EE(1,2) && im3(i-1,j+1)==EE(1,3) ...
        && im3(i,j-1)==EE(2,1) && im3(i,j)==EE(2,2) && im3(i,j+1)==EE(2,3) ...
        && im3(i+1,j-1)==EE(3,1)   && im3(i+1,j)==EE(3,2)   && im3(i+1,j+1)==EE(3,3) )
         imErode(i,j)=1;
      end    
    end
  end
end

figure('Name','Imagem Erodida - SEM RUÍDOS PRETOS')
imshow(imErode)

% comparar recortes subtraindo as imagens
% Atribuir o caractere a imagem subtraida

text(0,0,strcat('\color{blue}',"0 062 003001201748 8"))

figure('Name', 'Imagem Final Nome')
imshow(imErode2)
text(0,0,strcat('\color{blue}',"ERIC FELIPE TARGINO DA COSTA"))
