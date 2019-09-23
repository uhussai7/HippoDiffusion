subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=1
jjj=1
p=1;
for iii=1:4
    subject=subjects(iii);
    for jjj=1:2
        p=p+1;
        subject=subjects(iii);
        LR=LRs(jjj);
        LoadReparamConnectivityData
        CreateConnectivityMatrix
        SaveConnectivityData
        Mmaster{iii,jjj}=Msub;
        clearvars -except iii jjj subjects LRs p Mmaster
    end
end




%compute mean
mean=zeros(5,5)
for jjj=1:2
    for iii=1:4
        mean=mean+Mmaster{iii,jjj};
    end
    %mean
    %Mmaster_mean_parity{jjj}=mean/4;
    %mean=zeros(5,5);
end
Mmaster_mean_parity=mean/8;
Mmaster_mean_parity

%compute variance
variance=zeros(5,5)
for jjj=1:2
    for iii=1:4
        %variance=variance+(Mmaster{iii,jjj}-Mmaster_mean_parity{jjj}).*(Mmaster{iii,jjj}-Mmaster_mean_parity{jjj});
        variance=variance+(Mmaster{iii,jjj}-Mmaster_mean_parity).*(Mmaster{iii,jjj}-Mmaster_mean_parity);
    end
    %variance
    %Mmaster_variance_parity{jjj}=variance/4;
    %variance=zeros(5,5);
end
Mmaster_variance_parity=variance/8;
Mmaster_variance_parity
    
save(sprintf('..\\ProbtrackxNative\\data_mean_variance'));



figure;

annotation('rectangle',...
    [0.0318056872037915 0.215878679750223 0.935018957345972 0.528099910793934],...
    'FaceColor',[0 0 0]);
subplot(1,2,1);imagesc(Mmaster_mean_parity);
subplot(1,2,2);imagesc( sqrt(Mmaster_variance_parity));

axis equal
axis tight

set(gca,'xtick',[])
set(gca,'ytick',[])

text(-0.5,1,"CA4")
text(-0.5,2,"CA3")
text(-0.5,3,"CA2")
text(-0.5,4,"CA1")
text(-0.5,5,"SUB")

text(1,5.75,"CA4",'HorizontalAlignment','center','VerticalAlignment','middle');
text(2,5.75,"CA3",'HorizontalAlignment','center','VerticalAlignment','middle');
text(3,5.75,"CA2",'HorizontalAlignment','center','VerticalAlignment','middle');
text(4,5.75,"CA1",'HorizontalAlignment','center','VerticalAlignment','middle');
text(5,5.75,"SUB",'HorizontalAlignment','center','VerticalAlignment','middle');


cmap = colormap(jet(20)) ; %Create Colormap
cbh = colorbar ; %Create Colorbar
cbh.Ticks = linspace(0, 1, 20) ; %Create 8 ticks from zero to 1
cbh.TickLabels = num2cell(1:20) ;    %Replace the labels of these 8 ticks with the numbers 1 to 8

