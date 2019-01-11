subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']


%select some subject and hand for now
subject=subjects(1);
LR=LRs(2);

%load a coordinate field to generate min max
InitializeUnfoldingWithDarkband

%load the diffusion volume for reference
diff_hdr=load_untouch_header_only(sprintf('..\\Diffusion\\%s\\anat\\Native\\data.nii.gz',subject));

%load cropped native mask
croppedmask_nii=load_nii(sprintf('..\\Diffusion\\%s\\anat\\Native\\Crop\\%s\\nodif_brain_mask.nii.gz',subject,LR));

%test out the function
diff_nii.hdr=diff_hdr;
uncoppedmask_nii=UnCropper(min_xyz,max_xyz,U_nii,croppedmask_nii,diff_nii);

save_nii(uncoppedmask_nii, sprintf('test_%s.nii.gz',subject));

croppedmask_nii.hdr.hist.sform_code=1;
croppedmask_nii.img(isnan(croppedmask_nii.img)==1)=0;
save_nii(croppedmask_nii, sprintf('testagainst_%s.nii.gz',subject));