%here we make subfields again so that we can vary the resolution in a
%better way. Also we need to split the subfields appropriately

load('..\\Subfields\\avgBorders_NeuroImage2017study.mat')

%convert to something we can work with
avg_borders=avg_borders/100;
avg_borders(99,1)=0.66;
uv_sub=0:1/(100-1):1;
true_sub=double(true(100,1));

%get the mid point of the subfields. There should be nine curves in total

for si=1:4
    avg_borders_more(:,2*si)=avg_borders(:,si);
end

for ui=1:100
    for si=1:5
       sii=2*si-1;
       if(sii == 1)
           avg_borders_more(ui,sii)=(1+avg_borders_more(ui,sii+1))/2;
       elseif(sii == 9)
           avg_borders_more(ui,sii)=(avg_borders_more(ui,sii-1)+0)/2;
       else
           avg_borders_more(ui,sii)=(avg_borders_more(ui,sii-1)+avg_borders_more(ui,sii+1))/2;
       end
    end
end


% get the m


%% previosuly all subfields were created in reparam space and then moved to native space
% we do the same here

%move all subfield types to native space
% 1) Fat subfields PD direction only
% 2) Fat subfields in PD and AP binning
% 3) All of above with thin subfields in PD direction

% have to come with nomenclature sub_A-a_B_C.nii.gz
% 1) A-a is for PD where 'A' is 1 to 5 for subfields and 'a' is 1 or 2 for top and bottom 0 for
%    fat
% 2) B is 1 to 6 for AP binning 0 for no binning
% 3) C is 1 or 2 for IO bining 0 for no binning


% The files we need are the following
%Case I   sub_A-0_0_0.nii.gz for all A
%Case II  sub_A-0_B_0.nii.gz for all and B (this is because we already had this)
%Case III sub_A-a_B_C.nii.gz for all values of A,a,B & C

%move subfields to reparam space

%Case I

%just pushing to reparam space 
w_sub=zeros(100,1);
w_sub(:)=0.5;
ut_sub=NaN(100,4);
vt_sub=NaN(100,4);

for si=1:4
    ut_sub(:,si)=Fut_uvw(uv_sub(:),avg_borders(:,si),w_sub(:));
    vt_sub(:,si)=Fvt_uvw(uv_sub(:),avg_borders(:,si),w_sub(:));
end
wt_sub=Fwt_uvw(0.5,0.5,0.5);

%change to voxel coordinates for utvtwt space
clear i
ut_sub_vox=NaN(100,4);
vt_sub_vox=NaN(100,4);
for i=1:100
    for si=1:4
        temp=WorldI(nodif_brain_mask_nii,ut_sub(i,si),vt_sub(i,si),wt_sub);
        ut_sub_vox(i,si)=temp(1);
        vt_sub_vox(i,si)=temp(2);
    end
end

for ss=1:5
    sub_nii{ss}=zeros(size(nodif_brain_mask_nii.img));
end

for i=1:size(sub_nii{1},1)
    for j=1:size(sub_nii{1},2)
        for k=1:size(sub_nii{1},3)
            if(nodif_brain_mask_nii.img(i,j,k)==1)
                for b=1:4
                    j_bound(b)=interp1(ut_sub_vox(:,b),vt_sub_vox(:,b),i,'linear','extrap');
                end
                for b=1:4
                    if(b==1 && j>j_bound(b))
                        sub_nii{b}(i,j,k)=1;
                    elseif(b==4) 
                        if(j<j_bound(b))
                            sub_nii{b+1}(i,j,k)=1;
                        end
                        if(j<j_bound(b-1) & j>j_bound(b))
                            sub_nii{b}(i,j,k)=1;
                        end
                    elseif(b>1 & b<4)
                        if(j<j_bound(b-1) & j>j_bound(b))
                            sub_nii{b}(i,j,k)=1;
                        end
                    end
                end
            end
        end
    end
end


for b=1:5
    sub_nii{b}=make_nii(sub_nii{b});
    sub1_nii{b}.hdr=nodif_brain_mask_nii.hdr
    save_nii(sub_nii{b},sprintf('..\\Subfields\\%s\\%s\\sub_%d-0_0_0_%f.nii.gz',subject,LR,b,res));
end




