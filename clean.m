%Go to Initial InitializeUnfoldingWithDarkband.m and change the paths for
%U_nii V_nii W_nii

%Go to MakeUnfoldDiffusionVolume.m and in the last line set the path for
%the output of the diffusion volume

%Go to MakeUnfoldGradDev.m and set the paths for
%the output of the graddev file and the brain mask

%Then following is an example of the sequence on which to call the scripts
%make sure subjects and LRs makes sense, these are "global" and each of the
%paths described above rely on it.

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
