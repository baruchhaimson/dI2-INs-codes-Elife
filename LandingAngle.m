Names = {'Blue1','Blue2','Red1','Red2','Red32'};
Names = {'Control3','Control4'};
for k = 1:numel(Names)
    [FileNames, pathname] = uigetfile({'*.xlsx';'*.xls';},['Select your' , Names{k} ,'file'],'MultiSelect','on'); 
    if isequal(FileNames,0) %For case the user presses 'cancel'
        return
    else                      
        path(char(pathname),path);  %Adds the path name to the search path of matlab 
        FileNames = cellstr(FileNames);  % for the case of one file 
        FileNumber = length(FileNames); %Gets the number of files
        for n=1:FileNumber                  
            Data{k,n}=xlsread(char(FileNames{n}));
        end
    end
    for n = 1:FileNumber 
        D{k,n} = Data{k,n}(:,[1,2,7,8,13,14]);
    end
    % 
    % [FileNames_s, pathname_s] = uigetfile({'*.xlsx';'*.xls';},'Select your file','MultiSelect','on');
    % path(char(pathname_s),path); 
    % Starts=xlsread(char(FileNames_s));

    [FileNames_e, pathname_e] = uigetfile({'*.xlsx';'*.xls';},'Select your Ends file','MultiSelect','on');
    path(char(pathname_e),path);
    Ends{k} = xlsread(char(FileNames_e));
end

% Ends{5}(7,4:6) = NaN;

j = 3;
figure
scatter(D{1,j}(:,1),D{1,j}(:,2))
hold on
scatter(D{1,j}(:,3),D{1,j}(:,4))
hold on
scatter(D{1,j}(:,5),D{1,j}(:,6))


for k = 1:numel(Names)
    for n=1:size(Ends{k},1)
        ground{k,n} = [D{k,n}(1,5:end);D{k,n}(end,5:end)];
        Knee{k,n} = D{k,n}(Ends{k}(n,~isnan(Ends{k}(n,:))),1:2);
        TMP{k,n} = D{k,n}(Ends{k}(n,~isnan(Ends{k}(n,:))),3:4);
    end
end
for k = 1:numel(Names)
    for n=1:size(Ends{k},1)
        a = [];
        g = ground{k,n}(2,:) - ground{k,n}(1,:);
        if g(1) < 0  
            for i = 1:sum(~isnan(Ends{k}(n,:)))
                v =  Knee{k,n}(i,:) - TMP{k,n}(i,:);
                if v(1) > 0
                    a = [a, 180-abs(atan2d(g(1)*v(2)-g(2)*v(1),g(1)*v(1)+g(2)*v(2)))];
                else
                    a = [a, abs(atan2d(g(1)*v(2)-g(2)*v(1),g(1)*v(1)+g(2)*v(2)))];
                end
            end
        else
            for i = 1:sum(~isnan(Ends{k}(n,:)))
                v =  Knee{k,n}(i,:) - TMP{k,n}(i,:);
                if v(1) > 0
                    a = [a, atan2d(g(1)*v(2)-g(2)*v(1),g(1)*v(1)+g(2)*v(2))];
                else
                    a = [a, 180-atan2d(g(1)*v(2)-g(2)*v(1),g(1)*v(1)+g(2)*v(2))];
                end
            end
        end
        angle{k,n} = a;
    end
end
j = 12;
st = 1;
figure
g2 = ground{1,j}(2,:);
g1 = ground{1,j}(1,:);
Knee_h = Knee{1,j}(st,:);
TMP_h = TMP{1,j}(st,:);
plot([Knee_h(1) TMP_h(1)],[Knee_h(2) TMP_h(2)])
hold on
plot([g1(1) g2(1)],[g1(2) g2(2)])
legend('l','g');

for k = 1:numel(Names)
    Angle{k} = cat(2,angle{k,:})';
    sum(Angle{k}<70)
end

for k = 1:numel(Names)
    figure
    histogram(Angle{k});
end

for k = 1:numel(Names)
    xlswrite('LandingAnglesKnee_Finger_Control3_4.xlsx',Angle{k},[char(64+k),'1:',char(64+k),num2str(numel(Angle{k}))]);
end

clearvars -except Names AngleData
% end
