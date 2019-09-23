% move vectors/dyads from reparam space to native space

%% load unfolded dyads
dyads1_reparam_nii=load_untouch_nii('..\\hipposubjects_reparam\\sub-100610_L\\dwi\\multishell.bedpostX\\dyads1.nii.gz');
dyads2_reparam_nii=load_untouch_nii('..\\hipposubjects_reparam\\sub-100610_L\\dwi\\multishell.bedpostX\\dyads2.nii.gz');

%% have to load correct graddev file 

grad_dev_phit_phi_utvtwt_final_nii=load_untouch_nii('..\\hipposubjects_reparam\\sub-100610_L\\dwi\\multishell\\grad_dev.nii.gz');


%%
sz=size(dyads1_reparam_nii.img);
dyad_temp=[0;0;0];
dyads1_Jinv_nii=NaN(size(dyads1_reparam_nii.img));
dyads2_Jinv_nii=NaN(size(dyads1_reparam_nii.img));

normcheck=zeros(sz(1)*sz(2)*sz(3),1);
n1=1;
for i=1:sz(1)
    i
    for j=1:sz(2)
        for k=1:sz(3)
            gd_temp(:)=grad_dev_phit_phi_utvtwt_final_nii.img(i,j,k,:);
            Jn=graddev2jacobian(gd_temp);
            Jninv=inv(Jn+eye(3));
            dyad_temp(1)=dyads1_reparam_nii.img(i,j,k,1);
            dyad_temp(2)=dyads1_reparam_nii.img(i,j,k,2);
            dyad_temp(3)=dyads1_reparam_nii.img(i,j,k,3);
            dyad_temp=Jninv*dyad_temp;
            dyad_temp=dyad_temp/norm(dyad_temp);
            dyads1_Jinv_nii(i,j,k,:)=dyad_temp(:);
            dyad_temp(1)=dyads2_reparam_nii.img(i,j,k,1);
            dyad_temp(2)=dyads2_reparam_nii.img(i,j,k,2);
            dyad_temp(3)=dyads2_reparam_nii.img(i,j,k,3);
            dyad_temp=Jninv*dyad_temp;
            dyad_temp=dyad_temp/norm(dyad_temp);
            dyads2_Jinv_nii(i,j,k,:)=dyad_temp(:);
        end
    end
end

dyads1_native_fromreparam_nii=make_nii(dyads1_Jinv_nii);
dyads1_native_fromreparam_nii.hdr=dyads1_reparam_nii.hdr;
dyads2_native_fromreparam_nii=make_nii(dyads2_Jinv_nii);
dyads2_native_fromreparam_nii.hdr=dyads2_reparam_nii.hdr;

dyads1_native_fromreparam_xyz_nii=PushField(dyads1_native_fromreparam_nii,Ut_xyz_nii,Vt_xyz_nii,Wt_xyz_nii);
dyads2_native_fromreparam_xyz_nii=PushField(dyads2_native_fromreparam_nii,Ut_xyz_nii,Vt_xyz_nii,Wt_xyz_nii);



dyads1_temp=dyads1_native_fromreparam_nii.img(:,:,:,1);
dyads2_temp=dyads1_native_fromreparam_nii.img(:,:,:,2);
dyads3_temp=dyads1_native_fromreparam_nii.img(:,:,:,3);

ind_sub=find(isnan(dyads1_temp)==0);
[ut_vox vt_vox wt_vox]=ind2sub(size(dyads1_temp),ind_sub);
dy1(:)=dyads1_temp(ind_sub);
dy2(:)=dyads2_temp(ind_sub);
dy3(:)=dyads3_temp(ind_sub);

x_s=NaN(size(ind_sub));
y_s=NaN(size(ind_sub));
z_s=NaN(size(ind_sub));
for p=1:size(ut_vox)
    temp=World(dyads1_native_fromreparam_nii,ut_vox(p),vt_vox(p),wt_vox(p));
    u_s=Fu_utvtwt(temp(1),temp(2),temp(3));
    v_s=Fv_utvtwt(temp(1),temp(2),temp(3));
    w_s=Fw_utvtwt(temp(1),temp(2),temp(3));
    x_s(p)=Fx_uvw(u_s,v_s,w_s);
    y_s(p)=Fy_uvw(u_s,v_s,w_s);
    z_s(p)=Fz_uvw(u_s,v_s,w_s);
end

Fdy1_xyz(x_s,y_s,z_s,dy1,'nearest','none');
Fdy2_xyz(x_s,y_s,z_s,dy2,'nearest','none');
Fdy3_xyz(x_s,y_s,z_s,dy3,'nearest','none');





