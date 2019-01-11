%% Create a diffusion mask for the hippocampus in cropped images

sz_diff_crop=size(diff_crop_nii.img)
sz_diff_crop(4)=[];
mask_nii=NaN(sz_diff_crop);

inds_mask=find(isnan(mask_nii)==1);

%in_hippo=false(size(inds_mask),1);


large_hippo_alpha=Hippo_alpha;
large_hippo_alpha.Alpha=1.2;
U_nii_crop=Cropper(min_xyz,max_xyz,U_nii,U_nii);
for c=1:size(inds_mask,1)
    [i_m,j_m,k_m]=ind2sub(size(mask_nii),inds_mask(c));
    temp=World(diff_crop_nii,i_m,j_m,k_m);
    %temp=WorldI(U_nii_crop,temp(1),temp(2),temp(3));
    if( inShape(large_hippo_alpha,temp(1),temp(2),temp(3))==1)
       mask_nii(i_m,j_m,k_m)=1;
    end
%      %temp=ceil(temp);
%      result=interp3(U_nii_crop.img,temp(1),temp(2), temp(3),'nearest');
%      if( isnan(result)~=1)%isnan(U_nii.img(temp(1),temp(2),temp(3)))~=1)
%          mask_nii(i_m,j_m,k_m)=1;
%      end
%      temp=floor(temp);
%      if( isnan(U_nii.img(temp(1),temp(2),temp(3)))~=1)
%          mask_nii(i_m,j_m,k_m)=1;
%      end
end

mask_nii(:)=1;

mask_nii=make_nii(mask_nii);
    
mask_nii.hdr=diff_crop_nii.hdr;
mask_nii.hdr.dime.dim(1)=3;
mask_nii.hdr.dime.dim(5)=1;
mask_nii.hdr.dime.pixdim(5)=0;
mask_nii.hdr.hist.qform_code=0;

