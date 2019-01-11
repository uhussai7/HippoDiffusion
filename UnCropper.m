function Uncropped_nii = UnCropper(min_xyz,max_xyz,Ref_nii,Cropped_nii,Ref_uncrop_nii)
%Ref_nii is where min and max are defined in voxel coordinates
%Cropped is the image to be uncropped
%Ref_uncrop is target size to match, this will be diffusion space since
%that is what this functionis written for

%go to world space for min_xyz and max_xyz
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

%go voxel space 
Inxyz_min=int16(WorldI(Ref_uncrop_nii,min_xyz_w(1),min_xyz_w(2),min_xyz_w(3)));
Inxyz_max=int16(WorldI(Ref_uncrop_nii,max_xyz_w(1),max_xyz_w(2),max_xyz_w(3)));



sz_3=Ref_uncrop_nii.hdr.dime.dim(2:4);
Uncropped_nii=zeros(sz_3);
 
Uncropped_nii(Inxyz_min(1):Inxyz_max(1),Inxyz_min(2):Inxyz_max(2),Inxyz_min(3):Inxyz_max(3))=Cropped_nii.img;

Uncropped_nii=make_nii(Uncropped_nii);

Uncropped_nii.hdr=Ref_uncrop_nii.hdr;
Uncropped_nii.hdr.dime.dim(5)=1;
Uncropped_nii.hdr.dime.pixdim(5)=0;

Uncropped_nii.hdr.hist.sform_code=1;
Uncropped_nii.hdr.hist.qform_code=0;


%The piece of code below works but the world coordinates will always be off
%since, in the original cropping, information was lost when rounding to voxel
%indices.

% %get 3d size
% 
% sz_3=Ref_hdr.dime.dim(2:4);
% Uncropped_nii=zeros(sz_3);
% 
% temp=World(Cropped_nii,1,1,1)
% Ref_nii.hdr=Ref_hdr;
% 
% temp=WorldI(Ref_nii,temp(1),temp(2),temp(3))
% 
% ip_i=floor(temp(1));
% jp_i=floor(temp(2));
% kp_i=floor(temp(3));
% 
% 
% sz_c=Cropped_nii.hdr.dime.dim(2:4);
% temp=World(Cropped_nii,sz_c(1),sz_c(2),sz_c(3))
% temp=WorldI(Ref_nii,temp(1),temp(2),temp(3))
% 
% ip_f=floor(temp(1));
% jp_f=floor(temp(2));
% kp_f=floor(temp(3));
% 
% Uncropped_nii(ip_i:ip_f,jp_i:jp_f,kp_i:kp_f)=Cropped_nii.img;
% 
% Uncropped_nii=make_nii(Uncropped_nii);
% 
% Uncropped_nii.hdr=Ref_nii.hdr;
% Uncropped_nii.hdr.dime.dim(5)=1;
% Uncropped_nii.hdr.dime.pixdim(5)=0;
% 
% Uncropped_nii.hdr.hist.sform_code=1;
% Uncropped_nii.hdr.hist.qform_code=0;

 

end

