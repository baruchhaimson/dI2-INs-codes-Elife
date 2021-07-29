temp = imread('TemplateBrachialNew.tif');
Temp = temp(:,:,1:3);

Lamina = cell(1,9);
for i = 1: 9
    figure
    imshow(Temp);
    handel = drawpolygon('FaceAlpha',0);
    Lamina{i} = createMask(handel);
    mask = repmat(Lamina{i}, 1,1,3);
    Temp(mask) = 0;
    imshow(Temp);
    close
end


save('LaminaBrachial', 'Lamina');
%%
[FileName, pathname] = uigetfile({'*.xlsx';'*.xls';},'Select your points file'); 
if isequal(FileName,0) %For case the user presses 'cancel'
    return
else                      
    path(char(pathname),path);  %Adds the path name to the search path of matlab       
    F = xlsread(char(FileName)); 
end

L = zeros(1,9);
for k = 1:9
    poly = mask2poly(Lamina{k});
%     [r,c]=find(imclose(edge(Lamina{k}),strel('line,));
%     figure
%     edge(Lamina{k})
%     hold on
%     scatter(F(:,1),F(:,2))
    L(k) = mean(inpolygon(F(:,1),F(:,2),poly.X,poly.Y));
    clear r c
end
L1 = L./sum(L);

Name = fullfile(pathname,inputdlg('Insert name:'));
xlswrite([Name{:},'_Brachial.xlsx'],L1);