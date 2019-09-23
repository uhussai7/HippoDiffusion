
load('..\\Subfields\\avgBorders_NeuroImage2017study.mat')

%convert to something we can work with
avg_borders=avg_borders/100;
uv_sub=0:1/(100-1):1;
true_sub=double(true(100,1));

%just pushing to reparam space 
w_sub=zeros(100,1);
w_sub(:)=0.5;
ut_sub=NaN(100,4);
vt_sub=NaN(100,4);

ut_sub(:,1)=Fut_uvw(uv_sub(:),avg_borders(:,1),w_sub(:));
ut_sub(:,2)=Fut_uvw(uv_sub(:),avg_borders(:,2),w_sub(:));
ut_sub(:,3)=Fut_uvw(uv_sub(:),avg_borders(:,3),w_sub(:));
ut_sub(:,4)=Fut_uvw(uv_sub(:),avg_borders(:,4),w_sub(:));

vt_sub(:,1)=Fvt_uvw(uv_sub(:),avg_borders(:,1),w_sub(:));
vt_sub(:,2)=Fvt_uvw(uv_sub(:),avg_borders(:,2),w_sub(:));
vt_sub(:,3)=Fvt_uvw(uv_sub(:),avg_borders(:,3),w_sub(:));
vt_sub(:,4)=Fvt_uvw(uv_sub(:),avg_borders(:,4),w_sub(:));

wt_sub=Fwt_uvw(0.5,0.5,0.5);


%change to voxel coordinates for utvtwt space
clear i
ut_sub_vox=NaN(100,4);
vt_sub_vox=NaN(100,4);
for i=1:100
    temp=WorldI(nodif_brain_mask_nii,ut_sub(i,1),vt_sub(i,1),wt_sub);
    ut_sub_vox(i,1)=temp(1);
    vt_sub_vox(i,1)=temp(2);
    temp=WorldI(nodif_brain_mask_nii,ut_sub(i,2),vt_sub(i,2),wt_sub);
    ut_sub_vox(i,2)=temp(1);
    vt_sub_vox(i,2)=temp(2);
    temp=WorldI(nodif_brain_mask_nii,ut_sub(i,3),vt_sub(i,3),wt_sub);
    ut_sub_vox(i,3)=temp(1);
    vt_sub_vox(i,3)=temp(2);
    temp=WorldI(nodif_brain_mask_nii,ut_sub(i,4),vt_sub(i,4),wt_sub);
    ut_sub_vox(i,4)=temp(1);
    vt_sub_vox(i,4)=temp(2);
    
end

sub1_nii=zeros(size(nodif_brain_mask_nii.img));
sub2_nii=zeros(size(nodif_brain_mask_nii.img));
sub3_nii=zeros(size(nodif_brain_mask_nii.img));
sub4_nii=zeros(size(nodif_brain_mask_nii.img));
sub5_nii=zeros(size(nodif_brain_mask_nii.img)); 
for i=1:size(sub1_nii,1)
    for j=1:size(sub1_nii,2)
        for k=1:size(sub1_nii,3)
            if(nodif_brain_mask_nii.img(i,j,k)==1)
                
                j_bound_1=interp1(ut_sub_vox(:,1),vt_sub_vox(:,1),i,'linear','extrap');
                j_bound_2=interp1(ut_sub_vox(:,2),vt_sub_vox(:,2),i,'linear','extrap');
                j_bound_3=interp1(ut_sub_vox(:,3),vt_sub_vox(:,3),i,'linear','extrap');
                j_bound_4=interp1(ut_sub_vox(:,4),vt_sub_vox(:,4),i,'linear','extrap');
                if(j>j_bound_1)
                    sub1_nii(i,j,k)=1;
                end
                if(j<j_bound_1 & j>j_bound_2)
                    sub2_nii(i,j,k)=1;
                end
                if(j<j_bound_2 & j>j_bound_3)
                    sub3_nii(i,j,k)=1;
                end
                if(j<j_bound_3 & j>j_bound_4)
                    sub4_nii(i,j,k)=1;
                end
                if(j<j_bound_4)
                    sub5_nii(i,j,k)=1;
                end
            end
        end
    end
end
sub1_nii=make_nii(sub1_nii);
sub1_nii.hdr=nodif_brain_mask_nii.hdr
save_nii(sub1_nii,sprintf('..\\Subfields\\%s\\%s\\sub1.nii.gz',subject,LR));
sub2_nii=make_nii(sub2_nii);
sub2_nii.hdr=nodif_brain_mask_nii.hdr
save_nii(sub2_nii,sprintf('..\\Subfields\\%s\\%s\\sub2.nii.gz',subject,LR));
sub3_nii=make_nii(sub3_nii);
sub3_nii.hdr=nodif_brain_mask_nii.hdr
save_nii(sub3_nii,sprintf('..\\Subfields\\%s\\%s\\sub3.nii.gz',subject,LR));
sub4_nii=make_nii(sub4_nii);
sub4_nii.hdr=nodif_brain_mask_nii.hdr
save_nii(sub4_nii,sprintf('..\\Subfields\\%s\\%s\\sub4.nii.gz',subject,LR));
sub5_nii=make_nii(sub5_nii);
sub5_nii.hdr=nodif_brain_mask_nii.hdr
save_nii(sub5_nii,sprintf('..\\Subfields\\%s\\%s\\sub5.nii.gz',subject,LR));            