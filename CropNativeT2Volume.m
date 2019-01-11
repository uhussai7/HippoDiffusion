T2_crop_nii=Cropper(min_xyz,max_xyz,U_nii,T2_nii);
save_nii(T2_crop_nii,sprintf('..\\sourcedata\\%s\\anat\\T2_crop_%s.nii.gz',subject,LR));