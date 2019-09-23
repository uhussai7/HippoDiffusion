FA_native=load_untouch_nii('C:\\Users\\uhussain\\Documents\\ShareVM\\HCP_manual_hippocampal_segs_-_JD\\Diffusion\\sub-100610\\anat\\Native\\Crop\\L\\sub-100610_L-dti_FA.nii.gz');
FA_reparam=load_untouch_nii('C:\\Users\\uhussain\\Documents\\ShareVM\\HCP_manual_hippocampal_segs_-_JD\\hipposubjects_reparam\\sub-100610_L_dtifit_FA.nii.gz');

FA_native.img(FA_native.img==0)=NaN;
hist(FA_native.img(:))


FA_reparam.img(FA_reparam.img==0)=NaN;
histogram(FA_reparam.img(:),'normalization','probability')
hold on;
histogram(FA_native.img(:),'normalization','probability')

title('FA distribution in native space (orange) and unfolded space (blue)')
xlabel('FA');