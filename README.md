# HippoDiffusion
Create a reparametrized space diffusion volume for the hippocampus for both and left hippocampii for different subjects

<Edit to learn github - here is an edit>

Current folder structure for data:

Analysis
│   ├── CreateDarkBandExtension.asv
│   ├── CreateDarkBandExtension.m
│   ├── CreateInterpolants.m
│   ├── CreateSmoothDistanceMaps.m
│   ├── Cropper.m
│   ├── darkbandNN.m
│   ├── FinalizeGradDev.m
│   ├── graddev2jacobian.m
│   ├── grad_dev_phit_utvtwt.nii.gz
│   ├── grad_dev_phit_uvw.nii.gz
│   ├── grad_dev_phi_utvtwt.nii.gz
│   ├── grad_dev_phi_uvw.nii.gz
│   ├── grad_dev_xyz.nii.gz
│   ├── grad_nonan.m
│   ├── InitializeUnfoldingWithDarkband.m
│   ├── InvertSpacesSI.m
│   ├── Ipqr.m
│   ├── jacobian2graddev.m
│   ├── mainscript.asv
│   ├── mainscript.m
│   ├── MakeCoordinateField.m
│   ├── MakeDomain.m
│   ├── MakeDomains.m
│   ├── MakeGradDev.m
│   ├── MakeReparamDiffusionVolume.asv
│   ├── MakeReparamDiffusionVolume.m
│   ├── MakeReparamGradDev.m
│   ├── PushField.m
│   ├── smoo3_db.m
│   ├── sub-102311
│   ├── untitled.m
│   ├── WorldI.m
│   └── World.m
├── Diffusion
│   ├── sub-102311
│   │   └── anat
│   │       ├── Native
│   │       ├── Reparam
│   │       └── Unfold
│   └── sub-111312
│       └── anat
│           ├── bvals
│           ├── bvecs
│           ├── data.nii.gz
│           ├── grad_dev.nii.gz
│           └── nodif_brain_mask.nii.gz
├── format4laplace.sh
├── HippUnfold
│   ├── sub-100610
│   │   └── anat
│   │       ├── sub-100610_hemi-L_label-HippUnfold_AP.nii.gz
│   │       ├── sub-100610_hemi-L_label-HippUnfold_IO.nii.gz
│   │       ├── sub-100610_hemi-L_label-HippUnfold_laplace.mat
│   │       ├── sub-100610_hemi-L_label-HippUnfold_morphometry.mat
│   │       ├── sub-100610_hemi-L_label-HippUnfold_PD.nii.gz
│   │       ├── sub-100610_hemi-L_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│   │       ├── sub-100610_hemi-L_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│   │       ├── sub-100610_hemi-L_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│   │       ├── sub-100610_hemi-R_label-HippUnfold_AP.nii.gz
│   │       ├── sub-100610_hemi-R_label-HippUnfold_IO.nii.gz
│   │       ├── sub-100610_hemi-R_label-HippUnfold_laplace.mat
│   │       ├── sub-100610_hemi-R_label-HippUnfold_morphometry.mat
│   │       ├── sub-100610_hemi-R_label-HippUnfold_PD.nii.gz
│   │       ├── sub-100610_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│   │       ├── sub-100610_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│   │       └── sub-100610_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│   ├── sub-102311
│   │   └── anat
│   │       ├── sub-102311_hemi-L_label-HippUnfold_AP_crop_darkband.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_AP_crop.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_AP_darkband.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_AP.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_IO_crop_darkband.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_IO_crop.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_IO_darkband.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_IO.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_laplace.mat
│   │       ├── sub-102311_hemi-L_label-HippUnfold_morphometry.mat
│   │       ├── sub-102311_hemi-L_label-HippUnfold_PD_crop_darkband.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_PD_crop.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_PD_darkband.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_PD.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_AP_crop_darkband.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_AP_crop.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_AP_darkband.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_AP.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_IO_crop_darkband.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_IO_crop.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_IO_darkband.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_IO.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_laplace.mat
│   │       ├── sub-102311_hemi-R_label-HippUnfold_morphometry.mat
│   │       ├── sub-102311_hemi-R_label-HippUnfold_PD_crop_darkband.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_PD_crop.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_PD_darkband.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_PD.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│   │       └── sub-102311_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│   ├── sub-111312
│   │   └── anat
│   │       ├── sub-111312_hemi-L_label-HippUnfold_AP.nii.gz
│   │       ├── sub-111312_hemi-L_label-HippUnfold_IO.nii.gz
│   │       ├── sub-111312_hemi-L_label-HippUnfold_laplace.mat
│   │       ├── sub-111312_hemi-L_label-HippUnfold_morphometry.mat
│   │       ├── sub-111312_hemi-L_label-HippUnfold_PD.nii.gz
│   │       ├── sub-111312_hemi-L_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│   │       ├── sub-111312_hemi-L_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│   │       ├── sub-111312_hemi-L_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│   │       ├── sub-111312_hemi-R_label-HippUnfold_AP.nii.gz
│   │       ├── sub-111312_hemi-R_label-HippUnfold_IO.nii.gz
│   │       ├── sub-111312_hemi-R_label-HippUnfold_laplace.mat
│   │       ├── sub-111312_hemi-R_label-HippUnfold_morphometry.mat
│   │       ├── sub-111312_hemi-R_label-HippUnfold_PD.nii.gz
│   │       ├── sub-111312_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│   │       ├── sub-111312_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│   │       └── sub-111312_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│   └── sub-111514
│       └── anat
│           ├── sub-111514_hemi-L_label-HippUnfold_AP.nii.gz
│           ├── sub-111514_hemi-L_label-HippUnfold_IO.nii.gz
│           ├── sub-111514_hemi-L_label-HippUnfold_laplace.mat
│           ├── sub-111514_hemi-L_label-HippUnfold_morphometry.mat
│           ├── sub-111514_hemi-L_label-HippUnfold_PD.nii.gz
│           ├── sub-111514_hemi-L_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│           ├── sub-111514_hemi-L_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│           ├── sub-111514_hemi-L_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
│           ├── sub-111514_hemi-R_label-HippUnfold_AP.nii.gz
│           ├── sub-111514_hemi-R_label-HippUnfold_IO.nii.gz
│           ├── sub-111514_hemi-R_label-HippUnfold_laplace.mat
│           ├── sub-111514_hemi-R_label-HippUnfold_morphometry.mat
│           ├── sub-111514_hemi-R_label-HippUnfold_PD.nii.gz
│           ├── sub-111514_hemi-R_label-HippUnfold_srcsnk-AP_PhiMap.nii.gz
│           ├── sub-111514_hemi-R_label-HippUnfold_srcsnk-IO_PhiMap.nii.gz
│           └── sub-111514_hemi-R_label-HippUnfold_srcsnk-PD_PhiMap.nii.gz
├── laplace2nifti.asv
├── laplace2nifti.m
├── manual_masks
│   ├── sub-100610
│   │   └── anat
│   │       ├── sub-100610_hemi-L_label-HippUnfold.nii.gz
│   │       └── sub-100610_hemi-R_label-HippUnfold.nii.gz
│   ├── sub-102311
│   │   └── anat
│   │       ├── sub-102311_hemi-L_label-HippUnfold_crop.nii.gz
│   │       ├── sub-102311_hemi-L_label-HippUnfold.nii.gz
│   │       ├── sub-102311_hemi-R_label-HippUnfold_crop.nii.gz
│   │       └── sub-102311_hemi-R_label-HippUnfold.nii.gz
│   ├── sub-111312
│   │   └── anat
│   │       ├── sub-111312_hemi-L_label-HippUnfold.nii.gz
│   │       └── sub-111312_hemi-R_label-HippUnfold.nii.gz
│   └── sub-111514
│       └── anat
│           ├── sub-111514_hemi-L_label-HippUnfold.nii.gz
│           └── sub-111514_hemi-R_label-HippUnfold.nii.gz
├── matlab
│   ├── CreateInterpolants.m
│   ├── CreateSmoothDistanceMaps.m
│   ├── Cropper.m
│   ├── darkband.m
│   ├── darkbandNN.m
│   ├── darkbandnnscript.m
│   ├── darkbandscript.m
│   ├── FinalizeGradDev.m
│   ├── graddev2jacobian.m
│   ├── grad_nonan.m
│   ├── ims.m
│   ├── Initialize_phi_phiI.m
│   ├── InvertSpacesSI.m
│   ├── Ipqr.m
│   ├── jacobian2graddev.m
│   ├── MakeCoordinateField.m
│   ├── MakeDomain.m
│   ├── MakeGradDev.m
│   ├── playingwithdarkband.m
│   ├── PushField.m
│   ├── smoo3_db.m
│   ├── subfields.m
│   ├── testingscript4.m
│   ├── testingscript5.m
│   ├── WorldI.m
│   └── World.m
├── sourcedata
│   ├── sub-100610
│   │   └── anat
│   │       └── T2w_hires.norm_03mm.nii.gz
│   ├── sub-102311
│   │   └── anat
│   │       └── T2w_hires.norm_03mm.nii.gz
│   ├── sub-111312
│   │   └── anat
│   │       └── T2w_hires.norm_03mm.nii.gz
│   └── sub-111514
│       └── anat
│           └── T2w_hires.norm_03mm.nii.gz
└── subjects
