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

%Get the AaBC lists


[i,j,k,A,a,B,C]=checkSubfield(nodif_brain_mask_nii,avg_borders_more,Fut_uvw,Fvt_uvw,Fwt_uvw);


%MakeASubfield(Ai,ai,Bi,Ci,i,j,k, A,a,B,C,nodif_brain_mask_nii)
%make just the P-D subfields, no other partitioning

for Ai=min(A):max(A)
    for ai=0:max(a)
        for Bi=0:max(B)
            for Ci=0:max(C)
                [sub_nii, check]=MakeASubfield(Ai,ai,Bi,Ci,i,j,k,A,a,B,C,nodif_brain_mask_nii);
                if( check ==1)
                    save_nii(sub_nii,sprintf('..\\Subfields\\%s\\%s\\sub_%d-%d_%d_%d_%s.nii.gz',subject,LR,Ai,ai,Bi,Ci,ress(rrr)));
                end
                clear sub_nii;
            end
        end
    end
end

                      
                    


