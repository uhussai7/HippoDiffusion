%% load full mask
mask_nii=load_nii(sprintf('..\\Diffusion\\%s\\anat\\Reparam\\%s\\nodif_brain_mask.nii.gz',subject,LR));

%% load seeds

sub1_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub1.nii.gz',subject,LR));
sub2_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub2.nii.gz',subject,LR));
sub3_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub3.nii.gz',subject,LR));
sub4_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub4.nii.gz',subject,LR));
sub5_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub5.nii.gz',subject,LR));

%% find the wr coordinates defining the 3 layers

inds=find(mask_nii.img>0);
[ur vr wr]=ind2sub(size(mask_nii.img),inds);

maxwr=max(wr);
minwr=min(wr);
diff=floor((maxwr-minwr+1)/3);
L1=max(wr);
L2=L1-diff;
L3=L2-diff;

make_layers(sub1_nii,1,subject,LR);
make_layers(sub2_nii,2,subject,LR);
make_layers(sub3_nii,3,subject,LR);
make_layers(sub4_nii,4,subject,LR);
make_layers(sub5_nii,5,subject,LR);



function make_layers(sub_nii,sub_num,subject,LR)
    
    sub_low_nii=NaN(size(sub_nii.img));
    sub_mid_nii=NaN(size(sub_nii.img));
    sub_high_nii=NaN(size(sub_nii.img));
    for i=1:size(sub_nii.img,1)
        for j=1:size(sub_nii.img,2)
            column(:)=sub_nii.img(i,j,:);
            inds=find(column>0);  
            wr=ind2sub(size(column),inds);
            maxwr=max(wr);
            minwr=min(wr);
            diff=floor((maxwr-minwr+1)/3);
            %disp(diff);
            L1=max(wr);
            L2=L1-diff;
            L3=L2-diff;
            if(diff>0)
%                 disp(L1)
%                 disp(L2)
%                 disp(L3)
                sub_low_nii(i,j,1:L3-1)=sub_nii.img(i,j,1:L3-1);
                sub_mid_nii(i,j,L3:L2)=sub_nii.img(i,j,L3:L2);
                sub_high_nii(i,j,L2+1:size(sub_nii.img,3))=sub_nii.img(i,j,L2+1:size(sub_nii.img,3));
            else
                sub_mid_nii(i,j,:)=sub_nii.img(i,j,:);
            end
            
%             if(L2-L3<1)
%                 disp(L2-L3);
%                 disp(L1);
%                 disp(L2);
%                 disp(L3);
% 
%             end
       end
    end
    
    sub_low_nii=make_nii(sub_low_nii);
    sub_mid_nii=make_nii(sub_mid_nii);
    sub_high_nii=make_nii(sub_high_nii);
    sub_low_nii.hdr=sub_nii.hdr;
    sub_mid_nii.hdr=sub_nii.hdr;
    sub_high_nii.hdr=sub_nii.hdr; 
    
    save_nii(sub_low_nii,sprintf('..\\Subfields\\%s\\%s\\sub%d_L1.nii.gz',subject,LR,sub_num));
    save_nii(sub_mid_nii,sprintf('..\\Subfields\\%s\\%s\\sub%d_L2.nii.gz',subject,LR,sub_num));
    save_nii(sub_high_nii,sprintf('..\\Subfields\\%s\\%s\\sub%d_L3.nii.gz',subject,LR,sub_num));

end

% 
% function make_layers(sub_nii,sub_num,L1,L2,L3,subject,LR)
%     sub_low_nii=NaN(size(sub_nii.img));
%     sub_mid_nii=NaN(size(sub_nii.img));
%     sub_high_nii=NaN(size(sub_nii.img));
%     
%     sub_low_nii(:,:,1:L3)=sub_nii.img(:,:,1:L3);
%     sub_mid_nii(:,:,L3+1:L2)=sub_nii.img(:,:,L3+1:L2);
%     sub_high_nii(:,:,L2+1:size(sub_nii.img,3))=sub_nii.img(:,:,L2+1:size(sub_nii.img,3));
%     sub_low_nii=make_nii(sub_low_nii);
%     sub_mid_nii=make_nii(sub_mid_nii);
%     sub_high_nii=make_nii(sub_high_nii);
%     sub_low_nii.hdr=sub_nii.hdr;
%     sub_mid_nii.hdr=sub_nii.hdr;
%     sub_high_nii.hdr=sub_nii.hdr;
%     
%     save_nii(sub_low_nii,sprintf('..\\Subfields\\%s\\%s\\sub%d_L1.nii.gz',subject,LR,sub_num));
%     save_nii(sub_mid_nii,sprintf('..\\Subfields\\%s\\%s\\sub%d_L2.nii.gz',subject,LR,sub_num));
%     save_nii(sub_high_nii,sprintf('..\\Subfields\\%s\\%s\\sub%d_L3.nii.gz',subject,LR,sub_num));
% 
% end