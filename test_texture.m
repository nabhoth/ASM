function [result] = test_texture(inimsub, comand)

text = strsplit(' ', comand);
if strcmp(text(1),'Texture')
    [~,~,tmap] = detTG(inimsub);
    text_k =zeros(1,64);
    for i=1:64
        text_k(1,i) = numel(tmap(tmap == i));
    end
    t_num = uint8(str2double(text(2)));
    result = text_k(1,t_num);
end