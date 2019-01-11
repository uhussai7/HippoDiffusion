sz=size(X_uvw_nii.img);
T2_uvw_nii=NaN(sz);
temp_nii=Ipqr(T2_crop_nii,X_uvw_nii,Y_uvw_nii,Z_uvw_nii,0,'linear','none');
T2_uvw_nii(:,:,:)=temp_nii.img;


T2_uvw_nii=make_nii(T2_uvw_nii);
T2_uvw_nii.hdr=temp_nii.hdr;
save_nii(T2_uvw_nii,sprintf('..\\sourcedata\\%s\\anat\\T2_uvw_%s.nii.gz',subject,LR));
