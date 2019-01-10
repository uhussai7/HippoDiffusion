%% create grad dev file for reparametrized space
%make graddev forn uvw field in xyz
U_crop_nii=Cropper(min_xyz,max_xyz,U_nii,U_nii);
V_crop_nii=Cropper(min_xyz,max_xyz,U_nii,V_nii);
W_crop_nii=Cropper(min_xyz,max_xyz,U_nii,W_nii);

grad_dev_phi_xyz_nii=MakeGradDev(U_crop_nii,V_crop_nii,W_crop_nii);
%move graddev to uvw space
grad_dev_phi_uvw_nii=PushField(grad_dev_phi_xyz_nii,X_uvw_nii,Y_uvw_nii,Z_uvw_nii,'linear','none');
%make graddev from utvtwt field in uvw
grad_dev_phit_uvw_nii=MakeGradDev(Ut_uvw_nii,Vt_uvw_nii,Wt_uvw_nii);
%push the fields into the reparametrized space
grad_dev_phi_utvtwt_nii=PushField(grad_dev_phi_uvw_nii,U_utvtwt_nii,V_utvtwt_nii,W_utvtwt_nii,'linear','none');
grad_dev_phit_utvtwt_nii=PushField(grad_dev_phit_uvw_nii,U_utvtwt_nii,V_utvtwt_nii,W_utvtwt_nii,'linear','none');
%make the final grad dev file in utvtwt space
grad_dev_phit_phi_utvtwt_final_nii=FinalizeGradDev(grad_dev_phit_utvtwt_nii,grad_dev_phi_utvtwt_nii,0,2);
save_nii(grad_dev_phit_phi_utvtwt_final_nii,sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\grad_dev.nii.gz',subject,LR));
save_nii(grad_dev_phi_utvtwt_nii,sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\grad_dev_phi_utvtwt_notfinal.nii.gz',subject,LR));
save_nii(grad_dev_phit_utvtwt_nii,sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\grad_dev_phit_utvtwt_notfinal.nii.gz',subject,LR));

