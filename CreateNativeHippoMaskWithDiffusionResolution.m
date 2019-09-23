%% load diffusion header only but pretend it is full size image
diff_nii.hdr=load_untouch_header_only(sprintf('..\\Diffusion\\%s\\anat\\Native\\data.nii.gz',subject));

%% create fullsize mask
%there are two ways to do this 1) use imresize3 function 2) use the world
%space alpha shape

%1)-this doesn't work as well

%2)use alpha shape
mask_nii=zeros(diff_nii.hdr.dime.dim(2:4));

buff=World(U_nii,min_xyz(1),0,0);
min_xyz_w(1)=buff(1);

buff=World(U_nii,0,min_xyz(2),0);
min_xyz_w(2)=buff(2);

buff=World(U_nii,0,0,min_xyz(3));
min_xyz_w(3)=buff(3);

buff=World(U_nii,max_xyz(1),0,0);
max_xyz_w(1)=buff(1);

buff=World(U_nii,0,max_xyz(2),0);
max_xyz_w(2)=buff(2);

buff=World(U_nii,0,0,max_xyz(3));
max_xyz_w(3)=buff(3);

Inxyz_min=int16(WorldI(diff_nii,min_xyz_w(1),min_xyz_w(2),min_xyz_w(3)));
Inxyz_max=int16(WorldI(diff_nii,max_xyz_w(1),max_xyz_w(2),max_xyz_w(3)));

large_hippo_alpha=Hippo_alpha;
large_hippo_alpha.Alpha=1.2;
for i_m=Inxyz_min(1):Inxyz_max(1)
    for j_m=Inxyz_min(2):Inxyz_max(2)
        for k_m=Inxyz_min(3):Inxyz_max(3)
            temp=World(diff_nii,i_m,j_m,k_m);
            if(inShape(large_hippo_alpha,temp(1),temp(2),temp(3))==1)
                mask_nii(i_m,j_m,k_m)=1;
            end  
        end
    end
end

mask_nii=make_nii(mask_nii);
mask_nii.hdr=diff_nii.hdr;
mask_nii.hdr.dime.dim(5)=1;
mask_nii.hdr.dime.pixdim(5)=0;

mkdir(sprintf('..\\Diffusion\\%s\\anat\\Native_lowRes\\%s\\',subject,LR));

save_nii(mask_nii,sprintf('..\\Diffusion\\%s\\anat\\Native_lowRes\\%s\\nodif_brain_mask.nii.gz',subject,LR));

