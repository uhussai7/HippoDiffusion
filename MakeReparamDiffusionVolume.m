%% make sure you define subject and L or R before executing this

%load the diffusion volume
%subject='sub-102311';
%LR='L';
diff_nii=load_untouch_nii(sprintf('..\\Diffusion\\%s\\anat\\Native\\data.nii.gz',subject));
diff_crop_nii=Cropper(min_xyz,max_xyz,U_nii,diff_nii);




%% build the diffusion volume in tilde space
sz=size(X_utvtwt_nii.img);
sz(4)=size(diff_crop_nii.img,4);
diff_utvtwt_nii=NaN(sz);
for vol=1:size(diff_crop_nii.img,4)
    vol
    temp_nii=Ipqr(diff_crop_nii,X_utvtwt_nii,Y_utvtwt_nii,Z_utvtwt_nii,vol,'linear','linear');
    diff_utvtwt_nii(:,:,:,vol)=temp_nii.img;
end
diff_utvtwt_nii=make_nii(diff_utvtwt_nii);
diff_utvtwt_nii.hdr=temp_nii.hdr;
save_nii(diff_utvtwt_nii,sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\data.nii.gz',subject,LR));


