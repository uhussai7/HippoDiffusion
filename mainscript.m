subject="sub-102311";
LR='R';

CreateDarkBandExtension

InitializeUnfoldingWithDarkband

InitializeUnfolding

CreateInterpolants

MakeDomains

MakeReparamDiffusionVolume

MakeReparamGradDev

save_nii(grad_dev_phi_utvtwt_nii,'grad_dev_phi_utvtwt.nii.gz')
