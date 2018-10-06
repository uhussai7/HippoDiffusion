function In_crop_nii = Cropper(min_xyz,max_xyz,Ref_nii,In_nii)
%CROPPER Summary of this function goes here
%   Detailed explanation goes here
%-Ref_nii is where min_xyz and max_xyz are defined

buff=World(Ref_nii,min_xyz(1),0,0);
min_xyz_w(1)=buff(1);

buff=World(Ref_nii,0,min_xyz(2),0);
min_xyz_w(2)=buff(2);

buff=World(Ref_nii,0,0,min_xyz(3));
min_xyz_w(3)=buff(3);

buff=World(Ref_nii,max_xyz(1),0,0);
max_xyz_w(1)=buff(1);

buff=World(Ref_nii,0,max_xyz(2),0);
max_xyz_w(2)=buff(2);

buff=World(Ref_nii,0,0,max_xyz(3));
max_xyz_w(3)=buff(3);

Inxyz_min=int16(WorldI(In_nii,min_xyz_w(1),min_xyz_w(2),min_xyz_w(3)));
Inxyz_max=int16(WorldI(In_nii,max_xyz_w(1),max_xyz_w(2),max_xyz_w(3)));

In_diff=Inxyz_max-Inxyz_min+1;

if(In_nii.hdr.dime.dim(5)~=1)
    In_sz=In_nii.hdr.dime.dim(2:5);
    In_cropping=zeros(In_sz);
    In_cropping(Inxyz_min(1):Inxyz_max(1),Inxyz_min(2):Inxyz_max(2),Inxyz_min(3):Inxyz_max(3),:)=1;
    In_crop=zeros(In_diff(1),In_diff(2),In_diff(3),In_sz(4));
    In_crop(:)=In_nii.img(In_cropping==1);  
    In_crop_nii=make_nii(In_crop);
    In_crop_nii.hdr=In_nii.hdr;
    In_crop_nii.hdr.dime.dim(2:5)=size(In_crop);
    In_crop_nii.hdr.hist.srow_x(4)=max(min_xyz_w(1),max_xyz_w(1));
    In_crop_nii.hdr.hist.srow_y(4)=min(min_xyz_w(2),max_xyz_w(2));
    In_crop_nii.hdr.hist.srow_z(4)=min(min_xyz_w(3),max_xyz_w(3));
    In_crop_nii.hdr.hist.sform_code=1;
else
    In_sz=In_nii.hdr.dime.dim(2:4);
    In_cropping=zeros(In_sz);
    In_cropping(Inxyz_min(1):Inxyz_max(1),Inxyz_min(2):Inxyz_max(2),Inxyz_min(3):Inxyz_max(3))=1;
    In_crop=zeros(In_diff(1),In_diff(2),In_diff(3));
    In_crop(:)=In_nii.img(In_cropping==1);  
    In_crop_nii=make_nii(In_crop);
    In_crop_nii.hdr=In_nii.hdr;
    In_crop_nii.hdr.dime.dim(2:4)=size(In_crop);
    In_crop_nii.hdr.hist.srow_x(4)=max(min_xyz_w(1),max_xyz_w(1));
    In_crop_nii.hdr.hist.srow_y(4)=min(min_xyz_w(2),max_xyz_w(2));
    In_crop_nii.hdr.hist.srow_z(4)=min(min_xyz_w(3),max_xyz_w(3));
    In_crop_nii.hdr.hist.sform_code=1;
end




end

