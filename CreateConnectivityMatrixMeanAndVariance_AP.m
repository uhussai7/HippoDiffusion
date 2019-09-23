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
        CreateReparamAPConnectivityMatrix
        SaveConnectivityData
        Mmaster{iii,jjj}=Msub;
        clearvars -except iii jjj subjects LRs p Mmaster
    end
end




%compute mean
mean=zeros(30,30)
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
variance=zeros(30,30)
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
    
%save(sprintf('..\\ProbtrackxNative\\data_mean_variance'));



figure;

axis equal
axis tight

subplot(1,2,1);imagesc(Mmaster_mean_parity);
subplot(1,2,2);imagesc( sqrt(Mmaster_variance_parity));


for q=2:6
    figure;


    imagesc(Mmaster_mean_parity(5*(q-1)+1:5*(q-1)+1+4,5*(q-1)+1:5*(q-1)+1+4));
    axis tight;
    axis equal;
    
    

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
end

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


%extract the relevant entries for a AP plot
diag_mean=zeros(5,6);
diagp1_mean=zeros(5,6);
diag_variance=zeros(5,6);
diagp1_variance=zeros(5,6);

for t=1:6
    for r=1:5
        diag_mean(r,t)=Mmaster_mean_parity(5*(t-1)+r,5*(t-1)+r);
        diag_variance(r,t)=Mmaster_variance_parity(5*(t-1)+r,5*(t-1)+r);
        if(5*(t-1)+r+1<5*t)
            diagp1_mean(r,t)=Mmaster_mean_parity(5*(t-1)+r,5*(t-1)+r+1);
            diagp1_variance(r,t)=Mmaster_variance_parity(5*(t-1)+r,5*(t-1)+r+1);
        else
            diagp1_mean(r,t)=Mmaster_mean_parity(5*(t-1)+r,5*(t-1)+r-1);
            diagp1_variance(r,t)=Mmaster_variance_parity(5*(t-1)+r,5*(t-1)+r-1);
        end
    end
end


figure;
c=['r','g','b','m','k']
for r=1:5
    %plot(diag_mean(r,:))
    hold on
    %plot(diag_mean(r,:),c(r),'LineWidth',2);
    errorbar(1:5,diag_mean(r,2:6),sqrt(diag_variance(r,2:6))/sqrt(8),c(r),'LineWidth',2);
end
legend('CA4','CA3','CA2','CA1','SUB');
xlim([0.5,5.5])
xticks(1:1:5)
title('Mean intra-connectivity vs. AP bins')
xlabel('AP Bins (posterior to anterior')


figure;
c=['r','g','b','m']
for r=1:4
    %plot(diag_mean(r,:))
    hold on
    %plot(diag_mean(r,:),c(r),'LineWidth',2);
    errorbar(1:5,diagp1_mean(r,2:6),sqrt(diagp1_variance(r,2:6))/sqrt(8),c(r),'LineWidth',2);
end
legend('CA4-CA3','CA3-CA2','CA2-CA1','CA1-SUB');
xlim([0.5,5.5])
xticks(1:1:5)
title('Mean inter-connectivity with adjacent subfield vs. AP bins')
xlabel('AP Bins (posterior to anterior)')