%this script gets all the machinery to get ready to move data to different
%spaces (native, unfolded, reparametrized etc.)
%note that this uses coordiantes that included the dark band


%subject="sub-102311";
%LR='L';

%load the coordinates (including darkband)
U_nii=load_untouch_nii(sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_AP_darkband.nii.gz',subject,subject,LR));
V_nii=load_untouch_nii(sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_PD_darkband.nii.gz',subject,subject,LR));
W_nii=load_untouch_nii(sprintf('..\\HippUnfold\\%s\\anat\\%s_hemi-%s_label-HippUnfold_IO_darkband.nii.gz',subject,subject,LR));

%Nan out the fields
U_nii.img(U_nii.img==0)=NaN;
V_nii.img(V_nii.img==0)=NaN;
W_nii.img(W_nii.img==0)=NaN;

%% create uvw lists
indsu=find(isnan(U_nii.img)==0);
indsv=find(isnan(V_nii.img)==0);
indsw=find(isnan(W_nii.img)==0);

sizeinds=[size(indsu,1),size(indsv,1),size(indsw,1)];

indcheckp=find(sizeinds==min(sizeinds))
indcheck=indcheckp(1);

if indcheck==1 inds=indsu; end 
if indcheck==2 inds=indsv; end 
if indcheck==3 inds=indsw; end 

global u v w i_L j_L k_L;
[i_L,j_L,k_L]=ind2sub(size(U_nii.img),inds);
u=double(U_nii.img(inds));
v=double(V_nii.img(inds));
w=double(W_nii.img(inds));

%% create bounding box
boundbox=false(size(U_nii.img));
boundbox(min(i_L)-1:max(i_L)+1,min(j_L)-1:max(j_L)+1,min(k_L)-1:max(k_L)+1)=true;
min_xyz(1)=min(i_L)-1;
min_xyz(2)=min(j_L)-1;
min_xyz(3)=min(k_L)-1;
max_xyz(1)=max(i_L)+1;
max_xyz(2)=max(j_L)+1;
max_xyz(3)=max(k_L)+1;



%% create alpha shape 
global Hippo_alpha;
Hippo_alpha=alphaShape(i_L,j_L,k_L);
%spc=alphaSpectrum(Hippo_alpha);
%Hippo_alpha.Alpha=min(spc);
%% create alpha shape in world coordinates
%change coordinates from voxel to world
clear temp;
for i=1:size(i_L,1)
    temp=World(U_nii,i_L(i),j_L(i),k_L(i));
    x(i,1)=temp(1);
    y(i,1)=temp(2);
    z(i,1)=temp(3);
end
%[x y z]=World(U_nii,i_L,j_L,k_L);
Hippo_alpha=alphaShape(x,y,z)
spc=alphaSpectrum(Hippo_alpha);
Hippo_alpha.Alpha=min(spc);
% 
global uvw_alpha;
uvw_alpha=alphaShape(u,v,w,'HoleThreshold',10000000);
%uvw_alpha.Alpha=0.8;


