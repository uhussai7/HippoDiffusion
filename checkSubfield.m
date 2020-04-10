function [i,j,k,A,a,B,C] = checkSubfield(mask_nii,avg_borders_more,Fut_uvw,Fvt_uvw,Fwt_uvw)
%CHECKSUBFIELD Summary of this function goes here
%   Detailed explanation goes here


%just pushing to reparam space 
w_sub=zeros(100,1);
w_sub(:)=0.5;
ut_sub=NaN(100,9);
vt_sub=NaN(100,9);
uv_sub=0:1/(100-1):1;

for si=1:9
    ut_sub(:,si)=Fut_uvw(uv_sub(:),avg_borders_more(:,si),w_sub(:));
    vt_sub(:,si)=Fvt_uvw(uv_sub(:),avg_borders_more(:,si),w_sub(:));
end
wt_sub=Fwt_uvw(0.5,0.5,0.5);

%change to voxel coordinates for utvtwt space
clear i
ut_sub_vox=NaN(100,9);
vt_sub_vox=NaN(100,9);
for i=1:100
    for si=1:9
        temp=WorldI(mask_nii,ut_sub(i,si),vt_sub(i,si),wt_sub);
        ut_sub_vox(i,si)=temp(1);
        vt_sub_vox(i,si)=temp(2);
    end
end


%need to split IO into two, top and bottom
size(mask_nii.img);
mid=zeros(size(mask_nii.img,1),size(mask_nii.img,2));
for i=1:size(mask_nii.img,1)
    for j= 1:size(mask_nii.img,2)
        w_col=find(mask_nii.img(i,j,:)==1);
        if(isempty(w_col)~=1)
            mid(i,j)=(max(w_col)+min(w_col))/2;
        end
    end
end


N_ap=6;

%do the AP
[i j k]=ind2sub(size(mask_nii.img),find(mask_nii.img==1));
ap_bins=min(i):(max(i)-min(i))/(N_ap):max(i);

[A,a,B,C]=deal(zeros(size(i)));

j_bound=zeros(1,11);
j_bound(1)=size(mask_nii.img,2);
for t=1:size(i)
    for b=2:10
        j_bound(b)=interp1(ut_sub_vox(:,b-1),vt_sub_vox(:,b-1),i(t),'linear','extrap');
    end
    %j_bound
    for b=1:10
        check=inBetween(j_bound(b),j_bound(b+1),j(t));
        if(check==1)
            a(t)=b;
            A(t)=ceil(b/2);
        end
    end
    for b=1:N_ap
        check=inBetween(ap_bins(b),ap_bins(b+1),i(t));
        if(check==1)
            B(t)=b;
        end
    end
    if(k(t) < mid(i(t),j(t)))
        C(t)=1;
    else
        C(t)=2;
    end
end
end



function yesno=inBetween(X,Y,M)
    L=min([X,Y]);
    R=max([X,Y]);
    if((L < M & R > M) | R==M)% | L==M)
        yesno=1;
        return
    else
        yesno=0;
        return
    end
end
    


