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