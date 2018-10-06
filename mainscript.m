subject="sub-102311";
LR='L';

CreateDarkBandExtension

InitializeUnfoldingWithDarkband

CreateInterpolants

MakeDomains

MakeReparamDiffusionVolume

MakeReparamGradDev

save_nii(grad_dev_phi_utvtwt_nii,'grad_dev_phi_utvtwt.nii.gz')
