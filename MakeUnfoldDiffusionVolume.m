%% make sure you define subject and L or R before executing this

%load the diffusion volume
%subject='sub-102311';
%LR='L';
%diff_nii=load_untouch_nii(sprintf('..\\Diffusion\\%s\\anat\\Native\\data.nii.gz',subject));
%diff_crop_nii=Cropper(min_xyz,max_xyz,U_nii,diff_nii);

%native diffusion volume should be loaded (and cropped) in main



%% build the diffusion volume in uvw space
sz=size(X_uvw_nii.img);
sz(4)=size(diff_crop_nii.img,4);
diff_uvw_nii=NaN(sz);
for vol=1:size(diff_crop_nii.img,4)
    vol
    temp_nii=Ipqr(diff_crop_nii,X_uvw_nii,Y_uvw_nii,Z_uvw_nii,vol,'linear','linear');
    diff_uvw_nii(:,:,:,vol)=temp_nii.img;
end
diff_uvw_nii=make_nii(diff_uvw_nii);
diff_uvw_nii.hdr=temp_nii.hdr;
save_nii(diff_uvw_nii,sprintf('..\\Diffusion\\%s\\anat\\Unfold\\%s\\data.nii.gz',subject,LR));


