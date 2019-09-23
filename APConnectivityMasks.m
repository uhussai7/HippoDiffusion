% Computes from nodif_brain_mask and subfields masks the AP-subfield masks
% for connectivity gradient search

%% load nodif_brain_mask
no_dif_nii=load_nii(sprintf('..\\hipposubjects_reparam_probtrackx_curvature\\%s_%s\\dwi\\multishell\\nodif_brain_mask.nii.gz',subject,LR));

%% load subfields
for s=1:5
    subs_nii(s)=load_nii(sprintf('..\\hipposubjects_reparam_probtrackx_curvature\\%s_%s\\dwi\\subfields\\sub%d.nii.gz',subject,LR,s));
end
    
%% get AP direction max and min voxels
APinds=find(no_dif_nii.img==1);

[x_ap y_ap z_ap]=ind2sub(size(no_dif_nii.img),APinds);

%find the AP bins
NumOfBins=6
delta=round((max(x_ap)-min(x_ap)+1)/NumOfBins);

fileID = fopen(sprintf('..\\hipposubjects_reparam_probtrackx_curvature\\%s_%s\\dwi\\subfields\\seedsAP.txt',subject,LR),'w');
for a=1:6
    min_c=min(x_ap)+(a-1)*(delta)
    max_c=min(x_ap)+a*(delta)-1
    for s=1:5
        inds_c=find(subs_nii(1,s).img ==1);
        [x_c y_c z_c]=ind2sub(size(subs_nii(s).img),inds_c);
        inds_cc=x_c>=min_c & x_c<=max_c;
        img=zeros(size(subs_nii(s).img));
        img(inds_c(inds_cc))=1;
        img_nii=make_nii(img);
        img_nii.hdr=subs_nii(s).hdr;
        save_nii(img_nii,sprintf('..\\hipposubjects_reparam_probtrackx_curvature\\%s_%s\\dwi\\subfields\\sub%d_AP%dof%d.nii.gz',subject,LR,s,a,NumOfBins));
        fprintf(fileID,'%s_%s/dwi/subfields/sub%d_AP%dof%d.nii.gz\n',subject,LR,s,a,NumOfBins);
    end
end
fclose(fileID);
 