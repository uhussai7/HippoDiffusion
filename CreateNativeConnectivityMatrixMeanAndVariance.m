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
        LoadNativeConnectivityData
        CreateConnectivityMatrix
        SaveConnectivityData
        Mmaster{iii,jjj}=Msub;
        clearvars -except iii jjj subjects LRs p Mmaster
    end
end




%compute mean
mean=zeros(5,5);
for jjj=1:2
    for iii=1:4
        mean=mean+Mmaster{iii,jjj};
    end
    %Mmaster_mean_parity{jjj}=mean/4;
    %Mmaster_mean_parity{jjj}
    %mean=zeros(5,5);
end
Mmaster_mean_parity=mean/8;
Mmaster_mean_parity
    %

%compute variance
variance=zeros(5,5);
for jjj=1:2
    for iii=1:4
        %variance=variance+(Mmaster{iii,jjj}-Mmaster_mean_parity{jjj}).*(Mmaster{iii,jjj}-Mmaster_mean_parity{jjj});
        variance=variance+(Mmaster{iii,jjj}-Mmaster_mean_parity).*(Mmaster{iii,jjj}-Mmaster_mean_parity);
    end
    %Mmaster_variance_parity{jjj}=variance/4;
    %Mmaster_variance_parity{jjj}
    %variance=zeros(5,5);
end
Mmaster_variance_parity=variance/8;
Mmaster_variance_parity
    

figure;
subplot(1,2,1);imagesc(Mmaster_mean_parity);
subplot(1,2,2);imagesc(Mmaster_variance_parity);
