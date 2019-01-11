%mkdir(sprintf('..\\Diffusion\\%s\\anat\\Native\\Crop\\%s\\',subject,LR));
save_nii(diff_crop_nii,sprintf('..\\Diffusion\\%s\\anat\\Native\\Crop\\%s\\data.nii.gz',subject,LR));
save_nii(mask_nii,sprintf('..\\Diffusion\\%s\\anat\\Native\\Crop\\%s\\nodif_brain_mask.nii.gz',subject,LR));