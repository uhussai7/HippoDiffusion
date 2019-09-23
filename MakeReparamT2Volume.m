sz=size(X_utvtwt_nii.img);
T2_utvtwt_nii=NaN(sz);
temp_nii=Ipqr(T2_crop_nii,X_utvtwt_nii,Y_utvtwt_nii,Z_utvtwt_nii,0,'linear','linear');
T2_utvtwt_nii(:,:,:)=temp_nii.img;


T2_utvtwt_nii=make_nii(T2_utvtwt_nii);
T2_utvtwt_nii.hdr=temp_nii.hdr;
save_nii(T2_utvtwt_nii,sprintf('..\\sourcedata\\%s\\anat\\T2_utvtwt_%s.nii.gz',subject,LR));
