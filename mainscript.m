subject="sub-100610";
LR='R';


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

