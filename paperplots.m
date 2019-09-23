nativeIndirectPath='..\\PaperResults\\Native\\Data\\ConnectivityMatrix\\Indirect'
nativeDirectPath='..\\PaperResults\\Native\\Data\\ConnectivityMatrix\\Direct'
reparamIndirectPath='..\\PaperResults\\Reparam\\Data\\ConnectivityMatrix\\Indirect'
reparamDirectPath='..\\PaperResults\\Reparam\\Data\\ConnectivityMatrix\\Direct'
reparamDirectApPath='..\\PaperResults\\Reparam\\Data\\ConnectivityMatrix\\AnteriorPosterior\\Direct'


%% Args for CollapseConnectivity function 
%NR=0 Native, NR=1 Reparam
%DI=0 Indirect, DI=1, Direct 
%AP=1/0 Anterior Posterior ON/OFF


%% Native space connectivity (indirect)

figure;
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4    
    iii
    for jjj=1:2
        Msub=CollapseConnectivity(subjects(iii),LRs(jjj),0,0,0);
        subplot(2,4,4*(jjj-1)+iii);
        imagesc((Msub));
        title(sprintf('%s %s',subjects(iii),LRs(jjj)));
        axis equal;
        axis tight;
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
        cb = colorbar();
        set(gca,'ColorScale','log')
        %cb.Ruler.Scale = 'log';
    end
end


for iii=1:4    
    iii
    for jjj=1:2
        subplot(2,4,4*(jjj-1)+iii);
        title(sprintf('%s %s',subjects(iii),LRs(jjj)));
    end
end

%% Native space connectivity (direct)



%% Reparam space connectivity (indirect)


%% Reparam space connectivity (direct)


%% Reparam space connectivity (anterior posterior direct)


%%
%% Native space indirect (mean & std)
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4    
    iii
    for jjj=1:2
        Mmaster{iii,jjj}=CollapseConnectivity(subjects(iii),LRs(jjj),0,0,0);
    end
end

%compute mean
mean=zeros(5,5);
for jjj=1:2
    for iii=1:4
        mean=mean+Mmaster{iii,jjj};
    end
end
Mmaster_mean=mean/8;


%compute variance
variance=zeros(5,5);
for jjj=1:2
    for iii=1:4
        variance=variance+(Mmaster{iii,jjj}-Mmaster_mean).*(Mmaster{iii,jjj}-Mmaster_mean);
    end
end
Mmaster_std=sqrt(variance/8);


figure;
subplot(1,2,1);imagesc(Mmaster_mean);
subplot(1,2,2);imagesc(Mmaster_std);
mean_std=["Mean", "Std. Dev."];
for i=1:2
    subplot(1,2,i)
    title(sprintf('%s',mean_std(i)));
    axis equal;
    axis tight;
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
    cb = colorbar();
    set(gca,'ColorScale','log')
end



%% Native space direct (mean & std)

%% Reparam space indirect (mean & std)

%% Reparam space direct (mean & std)

%%
%% AP connectivity gradient graph (direct)


% Native space indirect (mean & std)
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4    
    iii
    for jjj=1:2
        Mmaster{iii,jjj}=CollapseConnectivity(subjects(iii),LRs(jjj),1,1,1);
    end
end




%compute mean
mean=zeros(6,5,5);
for jjj=1:2
    for iii=1:4
        mean=mean+Mmaster{iii,jjj};
    end
end
Mmaster_mean=mean/8;
Mmaster_mean

%compute variance
variance=zeros(6,5,5);
for jjj=1:2
    for iii=1:4
        variance=variance+(Mmaster{iii,jjj}-Mmaster_mean).*(Mmaster{iii,jjj}-Mmaster_mean);
    end
end
Mmaster_std=sqrt(variance/8);

%calculate mean of the diagnals vs. AP
mean_diagnals=zeros(6,5);
err_diagnals=zeros(6,5);
for ap=1:6
    for d=1:5
        mean_diagnals(ap,d)=Mmaster_mean(ap,d,d);
        err_diagnals(ap,d)=Mmaster_std(ap,d,d)/sqrt(8);
    end
end

%calculate mean of the super-diagnals vs. AP
mean_super_diagnals=zeros(6,4);
err_super_diagnals=zeros(6,4);
for ap=1:6
    for d=1:4
        mean_super_diagnals(ap,d)=Mmaster_mean(ap,d,d+1);
        err_super_diagnals(ap,d)=Mmaster_std(ap,d,d+1)/sqrt(8);
    end
end


figure;
c=['r','g','b','m','k']
for r=1:5
    %plot(diag_mean(r,:))
    hold on
    %plot(diag_mean(r,:),c(r),'LineWidth',2);
    errorbar(1:5,mean_diagnals(2:6,r),err_diagnals(2:6,r),c(r),'LineWidth',2);
end
legend('CA4','CA3','CA2','CA1','SUB');
xlim([0.5,5.5])
xticks(1:1:5)
title('Mean intra-connectivity vs. AP bins')
xlabel('AP Bins (posterior to anterior)')


figure;
c=['r','g','b','m']
for r=1:4
    %plot(diag_mean(r,:))
    hold on
    %plot(diag_mean(r,:),c(r),'LineWidth',2);
    errorbar(1:5,mean_super_diagnals(2:6,r),err_super_diagnals(2:6,r),c(r),'LineWidth',2);
end
legend('CA4-CA3','CA3-CA2','CA2-CA1','CA1-SUB');
xlim([0.5,5.5])
xticks(1:1:5)
title('Mean inter-connectivity with adjacent subfield vs. AP bins')
xlabel('AP Bins (posterior to anterior)')

%% AP connectivity gradient graph (indirect)


% Native space indirect (mean & std)
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4    
    iii
    for jjj=1:2
        Mmaster{iii,jjj}=CollapseConnectivity(subjects(iii),LRs(jjj),0,0,1);
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
Mmaster_mean=Mmaster_mean_parity;

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
Mmaster_std=sqrt(Mmaster_variance_parity);
    



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
xlabel('AP Bins (posterior to anterior)')


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
%% False connection rate

%four cases, native (direct/indirect) reparam (direct/indirect)


cases=zeros(4,2);
cases(1,1)=0; cases(1,2)=0;
cases(2,1)=0; cases(2,2)=1;
cases(3,1)=1; cases(3,2)=0;
cases(4,1)=1; cases(4,2)=1;

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for c=1:4 %compute all four cases
    for iii=1:4    
        iii
        for jjj=1:2
            Mmaster{c,iii,jjj}=CollapseConnectivity(subjects(iii),LRs(jjj),cases(c,1),cases(c,2),0);
        end
    end
end

%compute mean
for c=1:4
    mean=zeros(5,5);
    for jjj=1:2
        for iii=1:4
            mean=mean+Mmaster{c,iii,jjj};
        end
    end
    Mmaster_mean{c}=mean/8;
 

    %compute variance
    variance=zeros(5,5);
    for jjj=1:2
        for iii=1:4
            variance=variance+(Mmaster{c,iii,jjj}-Mmaster_mean{c}).*(Mmaster{c,iii,jjj}-Mmaster_mean{c});
        end
    end
    Mmaster_std{c}=sqrt(variance/8);
end

%check to make sure correct matrices
for c=1:4 
    subplot(2,2,c)
    imagesc(Mmaster_mean{c})
    axis equal
    axis tight
end


%compute something that is like false,implausible connection rate
%take the ratio of the super diagonal and the remaining upper triangular
%entries

for c=1:4
    super{c}=0;
    upper{c}=0;
    for r=1:4
        rp=r+1;
        super{c}=super{c}+Mmaster_mean{c}(r,rp);
        if(rp<5)
            upper{c}=upper{c}+sum(Mmaster_mean{c}(r,rp+1:5));
        end
    end
    ratio{c}=super{c}/upper{c};
end



for r=1:4
    A(r,r+1)=1;
    A(r+1,r)=1;
    if(r<4)
        for q=r+2:5
            A(r,q)=2;
            A(q,r)=2;
        end
    end
end