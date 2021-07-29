% E= xlsread('LandingAnglesKnee_Finger_Ex.xlsx');
% C= xlsread('LandingAnglesKnee_Finger_ControlElectroporared.xlsx');
% C2 = xlsread('LandingAnglesKnee_Finger_Control3_4.xlsx');

E= xlsread('LandingAnglesKnee_TMP_Ex.xlsx');
C= xlsread('LandingAnglesKnee_TMP_ControlElectroporared.xlsx');
C2 = xlsread('LandingAnglesKnee_TMP_Control3_4.xlsx');


E_data = load('LandingAngleData');
C_data = load('Control_data');
C2_data = load('Control3_4_Data');

load('Starts');
load('Starts2');
% for k = 1:2
%     [FileNames_e, pathname_e] = uigetfile({'*.xlsx';'*.xls';},'Select your Ends file','MultiSelect','on');
%     path(char(pathname_e),path);
%     Starts2{k} = xlsread(char(FileNames_e));
% end
% 


for c = 1:2
    k = find(~cellfun(@isempty,C2_data.D(c,:)));
    for s = 1 :numel(k)
        Knee = C2_data.D{c,s}(:,1:2);
        g = [C2_data.D{c,s}(1,5:end);C2_data.D{c,s}(end,5:end)];
        Sta_2{c,s} = Starts2{c}(s,~isnan(Starts2{c}(s,:)));
        En_2{c,s} = C2_data.Ends{1,c}(s,~isnan(C2_data.Ends{1,c}(s,:)));
        denominator = sqrt((g(2,1) - g(1,1)) ^ 2 + (g(2,2) - g(1,2)) ^ 2);
        % distance of a point from a line
        numerator = abs((g(2,1) - g(1,1)) .* (g(1,2) - Knee(:,2)) - (g(1,1) - Knee(:,1)) .* (g(2,2) - g(1,2)));	
        distance2{c,s} = numerator ./ denominator;
        clear Knee g denominator
    end
end

% find average height per trial
for c = 1:2
    k = find(~cellfun(@isempty,C2_data.D(c,:)));
    for s = 1 :numel(k)
        for step = 1:numel(Sta_2{c,s})
        kneeH_b{c,s,step} = mean(distance2{c,s}(Sta_2{c,s}));
        kneeH_e{c,s,step} = mean(distance2{c,s}(En_2{c,s}));
        Averaged_kneeH{c,s,step} = mean([kneeH_b{c,s,step},kneeH_e{c,s,step}]);  
        if sum(distance2{c,s}(Sta_2{c,s}(step):En_2{c,s}(step)) < 0.85*Averaged_kneeH{c,s,step}) > 0
            Fall_C_2(c,s,step) = 1;
        else
            Fall_C_2(c,s,step) = 0;
        end
        end
    end
end


for c = 1:2
    k = find(~cellfun(@isempty,C_data.D(c,:)));
    for s = 1 :numel(k)
        Knee = C_data.D{c,s}(:,1:2);
        g = [C_data.D{c,s}(1,5:end);C_data.D{c,s}(end,5:end)];
        Sta{c,s} = Starts{c+2}(s,~isnan(Starts{c+2}(s,:)));
        En{c,s} = C_data.Ends{1,c}(s,~isnan(C_data.Ends{1,c}(s,:)));
        denominator = sqrt((g(2,1) - g(1,1)) ^ 2 + (g(2,2) - g(1,2)) ^ 2);
        % distance of a point from a line
        numerator = abs((g(2,1) - g(1,1)) .* (g(1,2) - Knee(:,2)) - (g(1,1) - Knee(:,1)) .* (g(2,2) - g(1,2)));	
        distance{c,s} = numerator ./ denominator;
        clear Knee g denominator
    end
end

% find average height per trial
for c = 1:2
    k = find(~cellfun(@isempty,C_data.D(c,:)));
    for s = 1 :numel(k)
        for step = 1:numel(Sta{c,s})
        kneeH_b{c,s,step} = mean(distance{c,s}(Sta{c,s}));
        kneeH_e{c,s,step} = mean(distance{c,s}(En{c,s}));
        Averaged_kneeH{c,s,step} = mean([kneeH_b{c,s,step},kneeH_e{c,s,step}]);  
        if sum(distance{c,s}(Sta{c,s}(step):En{c,s}(step)) < 0.85*Averaged_kneeH{c,s,step}) > 0
            Fall_C(c,s,step) = 1;
        else
            Fall_C(c,s,step) = 0;
        end
        end
    end
end

Starts{9}(7,4:6) = NaN;
E_data.Ends{1,5}(7,4:6) = NaN;

for c = 1:5
    k = find(~cellfun(@isempty,E_data.D(c,:)));
    for s = 1 :numel(k)
        Knee = E_data.D{c,s}(:,1:2);
        g = [E_data.D{c,s}(1,5:end);E_data.D{c,s}(end,5:end)];
        Sta_E{c,s} = Starts{c+4}(s,~isnan(Starts{c+4}(s,:)));
        En_E{c,s} = E_data.Ends{1,c}(s,~isnan(E_data.Ends{1,c}(s,:)));
        denominator = sqrt((g(2,1) - g(1,1)) ^ 2 + (g(2,2) - g(1,2)) ^ 2);
        % distance of a point from a line
        numerator = abs((g(2,1) - g(1,1)) .* (g(1,2) - Knee(:,2)) - (g(1,1) - Knee(:,1)) .* (g(2,2) - g(1,2)));	
        distance_E{c,s} = numerator ./ denominator;
        clear Knee g denominator
    end
end

% find average height per trial
for c = 1:5
    k = find(~cellfun(@isempty,E_data.D(c,:)));
    for s = 1 :numel(k)
        for step = 1:numel(Sta_E{c,s})
        kneeH_b_E{c,s,step} = mean(distance_E{c,s}(Sta_E{c,s}));
        kneeH_e_E{c,s,step} = mean(distance_E{c,s}(En_E{c,s}));
        Averaged_kneeH_E{c,s,step} = mean([kneeH_b_E{c,s,step},kneeH_e_E{c,s,step}]);  
        if sum(distance_E{c,s}(Sta_E{c,s}(step):En_E{c,s}(step)) < 0.85*Averaged_kneeH_E{c,s,step}) > 0
            Fall_E(c,s,step) = 1;
        else
            Fall_E(c,s,step) = 0;
        end
        end
    end
end
% Fall_E(5,1,:)

% save('Falls');


for c = 1:2
    k = find(~cellfun(@isempty,C_data.D(c,:)));
    t = 1;
    for s = 1 :numel(k)
        Ang = C(t : t + numel(En{c,s})-1,c);
        ind = find(squeeze(Fall_C(c,s,:))');
        if ismember(1,ind)
            ind(ind == 1) = [];
        end
        p = setdiff(1:numel(En{c,s}),ind);
        if ismember(1,p)
            p(p == 1) = [];
        end
        Falling_angles_C{c,s} = Ang(ind-1);
        Not_Falling_angles_C{c,s} = Ang(p-1);
        t = t + numel(En{c,s});
        Ang = [];
    end
end

for c = 1:2
    k = find(~cellfun(@isempty,C2_data.D(c,:)));
    t = 1;
    for s = 1 :numel(k)
        Ang = C2(t : t + numel(En_2{c,s})-1,c);
        ind = find(squeeze(Fall_C_2(c,s,:))');
        if ismember(1,ind)
            ind(ind == 1) = [];
        end
        p = setdiff(1:numel(En_2{c,s}),ind);
        if ismember(1,p)
            p(p == 1) = [];
        end
        Falling_angles_C_2{c,s} = Ang(ind-1);
        Not_Falling_angles_C_2{c,s} = Ang(p-1);
        t = t + numel(En_2{c,s});
        Ang = [];
    end
end


for c = 1:5
    k = find(~cellfun(@isempty,E_data.D(c,:)));
    t = 1;
    for s = 1 :numel(k)
        Ang = E(t : t + numel(En_E{c,s})-1,c);
        ind = find(squeeze(Fall_E(c,s,:))');
        if ismember(1,ind)
            ind(ind == 1) = [];
        end
        p = setdiff(1:numel(En_E{c,s}),ind);
        if ismember(1,p)
            p(p == 1) = [];
        end
        Falling_angles_E{c,s} = Ang(ind-1);
        Not_Falling_angles_E{c,s} = Ang(p-1);
        t = t + numel(En_E{c,s});
        Ang = [];
    end   
end
Falling_angles_C(:,1:15) = [Falling_angles_C,cell(2,7)];
Not_Falling_angles_C(:,1:15) = [Not_Falling_angles_C,cell(2,7)];

Falling_angles_C_all = [Falling_angles_C;Falling_angles_C_2];
Not_Falling_angles_C_all = [Not_Falling_angles_C;Not_Falling_angles_C_2];
C(end+1:end+24,:) = NaN;
C_all = [C2,C];        
% Not_Falling_angles_E{5,1}(1)=[];
% Falling_angles_E{5,1}=[E(1,5);Falling_angles_E{5,1}];

% for i = 1:2
%     Fall_num_C(i) = sum(Fall_C_2(i,:,:),'all')./sum(~isnan(Starts{i}),'all');     
% end

for i = 1:2
    Fall_num_C(i) = mean(Fall_C_2(i,:,:),'all');     
end
for i = 3:4
    Fall_num_C(i) = mean(Fall_C(i-2,:,:),'all');     
end

% for i = 3:4
%     Fall_num_C(i) = sum(Fall_C(i-2,:,:),'all')./sum(~isnan(Starts{i}),'all');     
% end

nanmean(cat(1,Falling_angles_E{4,:}))
nanmean(cat(1,Not_Falling_angles_E{5,:}))

[h,pv]=ttest2(E(~isnan(E(:,2)),2),C(~isnan(C(:,1)),1))


for i = 1:5
    Below45_E(i) = sum(E(:,i)<45)./numel(cat(2,En_E{i,:}));
    Avg_fall_E(i) = nanmean(E(:,i));
%     Fall_num_E(i) = sum(Fall_E(i,:,:),'all')./numel(cat(2,En_E{i,:}));
    Fall_num_E(i) = mean(Fall_E(i,:,:),'all'); 
end

for i = 1:4
    Below45_C(i) = sum(C_all(:,i)<45)./sum(~isnan(Starts{i}),'all');
    Avg_fall_C(i) = nanmean(C_all(:,i));
end

for i = 1:5
    for j = 1:5
        [h_E(i,j),pv_E(i,j)]=ttest2(E(~isnan(E(:,i)),i),E(~isnan(E(:,j)),j));
    end
end

for i = 1:4
    for j = 1:4
        [h_C(i,j),pv_C(i,j)]=ttest2(C_all(~isnan(C_all(:,i)),i),C_all(~isnan(C_all(:,j)),j));
    end
end

AngleFall_two_C = [C(:,1);C(:,2)];

Fall_num = [Fall_num_C,Fall_num_E];
Below45= [Below45_C,Below45_E];
Avg_fall= [Avg_fall_C,Avg_fall_E];


% mean(Below50_E)
colors = zeros(9,3);
colors(1:4,2) = 1;
colors(5:9,1) = 1;

figure
scatter(Fall_num,Below45,40,colors,'filled')
[R,pv] = corrcoef(Fall_num([1:6,8:9]),Below45([1:6,8:9]));

figure
scatter(Fall_num,Avg_fall,40,colors,'filled')
[R,pv] = corrcoef(Fall_num,Avg_fall);

figure
for i = 1:5
    histogram(E(:,i),10,'FaceColor','b','FaceAlpha',0.2)
    hold on
end
for i = 1:4
    histogram(C_all(:,i),10,'FaceColor','r','FaceAlpha',0.2)
    hold on
end



for i = 1:5
    SEM_E(i) = nanstd(E(:,i))/sqrt(sum(~isnan(E(:,i))));
end

for i = 1:2
    SEM_C(i) = nanstd(C_all(:,i))/sqrt(sum(~isnan(C_all(:,i))));
end
% 
% for i = 1:5
%     Below45(i) = nanmean(E(:,i)<50);
% end
F = [];
for i = 1:5
    for j = 1:21
        f = Falling_angles_E{i,j};
        F = [F,f'];
    end
end

NF = [];
for i = 1:5
    for j = 1:21
        Nf = Not_Falling_angles_E{i,j};
        NF = [NF,Nf'];
    end
end

[h,p] = ttest2(F,NF);

E_all = E(:);
E_all = E_all(~isnan(E_all));

C_All = C_all(:);
C_All = C_All(~isnan(C_All));

[h,p] = ttest2(E_all,C_All);
% xlswrite('NotFallingAngles_C.xlsx',Not_Falling_angles_C_all);
xlswrite('NotFallingAngles_E.xlsx',NF);
% xlswrite('FallingAngles_C.xlsx',Falling_angles_C_all);
xlswrite('FallingAngles_E.xlsx',F);
% 
% for i = 1:2
%     Below45_c(i) = nanmean(C(:,i)<50);
% end

