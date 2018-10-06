%This script will follow the folder structure and load the existing laplace
%fields and then extend them into the darkband
%OUTPUT:1) Cropped original fields 2) Cropped darkband fields 3) Full
%darkband fields

%Define these in main script
%subject="sub-102311";
%LRp=["L","R"];

for h=1:2
    U_nii=load_untouch_nii(sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_AP.nii.gz',subject,subject,LRp(h)));
    V_nii=load_untouch_nii(sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_PD.nii.gz',subject,subject,LRp(h)));
    W_nii=load_untouch_nii(sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_IO.nii.gz',subject,subject,LRp(h)));
    labelmap_nii=load_untouch_nii(sprintf('..\\manual_masks\\%s\\anat\\%s_hemi-%s_label-HippUnfold.nii.gz',subject,subject,LRp(h)));

    
    inds=find((U_nii.img)>0);
    [i_L,j_L,k_L]=ind2sub(size(U_nii.img),inds);

    min_xyz(1)=min(i_L)-1;
    min_xyz(2)=min(j_L)-1;
    min_xyz(3)=min(k_L)-1;
    max_xyz(1)=max(i_L)+1;
    max_xyz(2)=max(j_L)+1;
    max_xyz(3)=max(k_L)+1;

    U_crop_nii=Cropper(min_xyz,max_xyz,U_nii,U_nii);
    V_crop_nii=Cropper(min_xyz,max_xyz,V_nii,V_nii);
    W_crop_nii=Cropper(min_xyz,max_xyz,W_nii,W_nii);
    labelmap_crop_nii=Cropper(min_xyz,max_xyz,U_nii,labelmap_nii);

    save_nii(U_crop_nii,sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_AP_crop.nii.gz',subject,subject,LRp(h)));
    save_nii(V_crop_nii,sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_PD_crop.nii.gz',subject,subject,LRp(h)));
    save_nii(W_crop_nii,sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_IO_crop.nii.gz',subject,subject,LRp(h)));
    save_nii(labelmap_crop_nii,sprintf('..\\manual_masks\\%s\\anat\\%s_hemi-%s_label-HippUnfold_crop.nii.gz',subject,subject,LRp(h)));
    
    
    [U_db_crop_nii V_db_crop_nii W_db_crop_nii]=darkbandNN(U_crop_nii, V_crop_nii, W_crop_nii,labelmap_crop_nii);

    save_nii(U_db_crop_nii,sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_AP_crop_darkband.nii.gz',subject,subject,LRp(h)));
    save_nii(V_db_crop_nii,sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_PD_crop_darkband.nii.gz',subject,subject,LRp(h)));
    save_nii(W_db_crop_nii,sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_IO_crop_darkband.nii.gz',subject,subject,LRp(h)));

    sz=size(U_nii.img);
    U_db_nii=NaN(sz);
    region=false(sz);
    region(min_xyz(1):max_xyz(1),min_xyz(2):max_xyz(2),min_xyz(3):max_xyz(3))=true;
    U_db_nii(region)=U_db_crop_nii.img(:,:,:);
    U_db_nii=make_nii(U_db_nii);
    U_db_nii.hdr=U_nii.hdr;
    save_nii(U_db_nii,sprintf('..\\..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_AP_darkband.nii.gz',subject,subject,LRp(h)));

    V_db_nii=NaN(sz);
    V_db_nii(region)=V_db_crop_nii.img(:,:,:);
    V_db_nii=make_nii(V_db_nii);
    V_db_nii.hdr=V_nii.hdr;
    save_nii(V_db_nii,sprintf('..\\..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_PD_darkband.nii.gz',subject,subject,LRp(h)));

    W_db_nii=NaN(sz);
    W_db_nii(region)=W_db_crop_nii.img(:,:,:);
    W_db_nii=make_nii(W_db_nii);
    W_db_nii.hdr=W_nii.hdr;
    save_nii(W_db_nii,sprintf('..\\..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_IO_darkband.nii.gz',subject,subject,LRp(h)));

    

end
