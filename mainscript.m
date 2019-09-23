subject="sub-100610";
LR='L';


subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4
    for jjj=1:2
        subject=subjects(iii)
        LR=LRs(jjj)
        CreateDarkBandExtension
        clearvars -except iii jjj subjects LRs 
    end
end

InitializeUnfolding

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4
    for jjj=1:2
        subject=subjects(iii)
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband
        CreateInterpolants
        MakeDomains
        MakeReparamDiffusionVolume
        MakeReparamGradDev
        MakeReparamGradDevAndDistortion
        clearvars -except iii jjj subjects LRs 
    end
end

%% forgot to make nodiffbrainmask

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:4
    for jjj=1:2
        subject=subjects(iii)
        LR=LRs(jjj);
        grad_dev_nii=load_untouch_nii(sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\grad_dev.nii.gz',subject,LR));
        mask=isnan(grad_dev_nii.img)==0;
        mask=double(mask);
        mask=make_nii(mask);
        mask.hdr=grad_dev_nii.hdr;
        mask.hdr.dime.dim(1)=3;
        mask.hdr.dime.dim(5)=1;
        save_nii(mask,sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\nodif_brain_mask.nii.gz',subject,LR));
    end
end


%% make diffusion volumes for unfolded space
%changes made: 
%Loading diffusion volume separately
%nodif_brain_mask is created in MakeUnfoldGradDev (Do this for Reparam)

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:1
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for jjj=1:1
        subject=subjects(iii);
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband 
        %InitializeUnfolding
        %CropNativeDiffusionVolume
        CreateInterpolants
        MakeDomains
        %MakeUnfoldDiffusionVolume
        MakeUnfoldGradDev
        clearvars -except iii jjj subjects LRs diff_nii
    end
    clear diff_nii
end


%% make folder structure

for iii=1:4
    subject=subjects(iii);
    mkdir(subject);
    for jjj=1:2
        LR=LRs(jjj);
        mkdir(sprintf('%s\\%s',subject,LR));
    end
end


%% make the seeds
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:4
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband 
        %InitializeUnfolding
        %CropNativeDiffusionVolume
        CreateInterpolants
        MakeDomains
        %MakeUnfoldDiffusionVolume
        nodif_brain_mask_nii=load_untouch_nii(sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\nodif_brain_mask.nii.gz',subject,LR));
        MakeSubfieldSeeds
        clearvars -except iii jjj subjects LRs diff_nii
    end
    clear diff_nii
end


%% Create the connectivity matrices
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=1
jjj=1
for iii=1:4
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        LoadConnectivityData
        CreateConnectivityMatrix
        SaveConnectivityData
        clearvars -except iii jjj subjects LRs
    end
end

%% create the connectivity matrices and plot them all as subplots

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=1
jjj=1
p=1;
for jjj=1:2
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for iii=1:4
        subplot(2,4,p);
        p=p+1;
        subject=subjects(iii);
        LR=LRs(jjj);
        LoadReparamConnectivityData
        CreateConnectivityMatrix
        title(sprintf("%s %s",subject,LR));
        SaveConnectivityData
        clearvars -except iii jjj subjects LRs p
    end
end

%% Create 3 layers
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:4
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        Create3LayersOfSeeds
        clearvars -except iii jjj subjects LRs
    end
end


%% FA distribution in each subfield
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
FARs=NaN(4,5);
for iii=1:4
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for jjj=1:1
        subject=subjects(iii);
        LR=LRs(jjj);
        LoadFaSubfield;
        FARs(iii,:)=FaInSubfield(sub1_nii,sub2_nii,sub3_nii,sub4_nii,sub5_nii, FA_nii);
        clearvars -except iii jjj subjects LRs FAs FARs allFa g
    end
end


FARLR=NaN(8,5);
for meas=1:4
    FARLR(2*meas-1,:)=FAs(meas,:);
    FARLR(2*meas,:)=FARs(meas,:);
end

allFa=FAs(:)
s=1
for i=1:5
    g(s:s+3)=i
    s=s+4
end



allFa=FARs(:)
s=1
for i=1:5
    g(s:s+3)=6-i
    s=s+4
end

[p,tgb1,stats]=anova1(allFa,g)

%[p,tgb1,stats]=anova2(FARLR,2)
xticklabels({'SUB', 'CA1','CA2','CA3','CA4',})
ylabel('FA')
ylim([0.08 0.2])
multcompare(stats)

FaDistributionInEachSubfdield




%% Need to run diffusion on cropped native volumes,
%create the neccessary inputs
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:4
    subject=subjects(iii);
    LoadNativeDiffusionVolume
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband 
        CropNativeDiffusionVolume
        CreateNativeCropHippoMaskForDiffusion
        SaveCroppedNativeDiffusionVolume
        clearvars -except iii jjj subjects LRs diff_nii
    end
    clear diff_nii
end

%% Create the subfields for native diffusion space
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:4
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband 
        CreateInterpolants
        MoveSubfieldsToDiffusionResolutionNativeSpace
        clearvars -except iii jjj subjects LRs 
    end
end


%% Create hippocampus masks for full diffusion resolution
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

for iii=1:4
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband 
        CreateNativeHippoMaskWithDiffusionResolution
        figure;plot(large_hippo_alpha);
    end
end

%% Create subfields for full diffusion resolution
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']


for iii=1:4
    for jjj=1:2
        subject=subjects(iii);
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband 
        CreateInterpolants
        MoveSubfieldsToDiffusionResolutionNativeSpaceFull
        clearvars -except iii jjj subjects LRs 
    end
end


%% make reparam t2 volume
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4
    for jjj=1:2
        subject=subjects(iii)
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband
        CreateInterpolants
        LoadNativeT2Volume
        CropNativeT2Volume
        MakeDomains
        MakeReparamT2Volume
        clearvars -except iii jjj subjects LRs 
    end
end     



%% create the connectivity matrices and plot them all as subplots

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=3
jjj=1
p=1;
for iii=1:4
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for jjj=1:2
        subplot(2,4,p);
        p=p+1;
        subject=subjects(iii);
        LR=LRs(jjj);
        LoadReparamConnectivityCurvDist
        CreateConnectivityMatrix
        SaveConnectivityData
        clearvars -except iii jjj subjects LRs p
    end
end



%% create the connectivity matrices and plot them all as subplots

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=1
jjj=1
p=1;
for jjj=1:2
    subject=subjects(iii);
    %LoadNativeDiffusionVolume
    for iii=1:4
        subplot(2,4,p);
        p=p+1;
        subject=subjects(iii);
        LR=LRs(jjj);
        %LoadReparamConnectivityData
        CreateReparamConnectivityMatrix_keep_avoid
        title(sprintf("%s %s",subject,LR));
        %SaveConnectivityData
        clearvars -except iii jjj subjects LRs p
    end
end

%% create the AP subfields seeds for all subjects
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=1
jjj=1
p=1;
for jjj=1:2
    for iii=1:4
        subject=subjects(iii);
        LR=LRs(jjj);
        APConnectivityMasks
    end
    clearvars -except iii jjj subjects LRs p
end



%% Create X_utvtwt Y_utvtwt Z_utvtwt as nifti images

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
for iii=1:4
    for jjj=1:2
        subject=subjects(iii)
        LR=LRs(jjj);
        InitializeUnfoldingWithDarkband
        CreateInterpolants
        MakeDomains
        save_nii(X_utvtwt_nii, sprintf('..\\%s_%s_X_utvtwt.nii.gz',subject,LR));
        save_nii(Y_utvtwt_nii, sprintf('..\\%s_%s_Y_utvtwt.nii.gz',subject,LR));
        save_nii(Z_utvtwt_nii, sprintf('..\\%s_%s_Z_utvtwt.nii.gz',subject,LR));
        clearvars -except iii jjj subjects LRs 
    end
end



%% make subfield masks again and again and again


subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
ress=["0625","125"]
for rrr=1:2
    %res=ress(rrr);
    for iii=1:4
        subject=subjects(iii);
        for jjj=1:2
            subject=subjects(iii);
            LR=LRs(jjj);
            InitializeUnfoldingWithDarkband 
            CreateInterpolants
            MakeDomains
            nodif_brain_mask_nii=load_untouch_nii(sprintf('..\\hipposubjects_reparam_%smm\\%s_%s\\dwi\\multishell\\nodif_brain_mask.nii.gz',ress(rrr),subject,LR));
            MakeSubfieldsAgainWithAFunction
            clearvars -except iii jjj rrr ress subjects LRs diff_nii
        end
    end
end




%% Create the subfields for native diffusion space at different resolution
subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
ress=["0625","125"]
resw=["hiRes", "lowRes"]

for rrr=1:2
    for iii=1:4
        for jjj=1:2
            subject=subjects(iii);
            LR=LRs(jjj);
            InitializeUnfoldingWithDarkband 
            CreateInterpolants
            MoveSubfieldsToManyDiffusionResolutionNativeSpace
            clearvars -except iii jjj rrr subjects LRs ress resw
        end
    end
end
