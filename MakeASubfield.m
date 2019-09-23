function [sub_nii,check] = MakeASubfield(Ai,ai,Bi,Ci,i,j,k, A,a,B,C,nodif_brain_mask_nii)
%MAKEASUBFIELD Make subfield based on "coarse" binning coordiantes
%   Ai,ai,Bi,Ci are the binning coordinates, a value of zero means 'for
%   all'

clear sub_nii;
sub_nii=zeros(size(nodif_brain_mask_nii.img));
check=0;
for p=1:size(i)
    if(Ai==A(p))
        if(ai==a(p) | ai==0) 
            if(Bi==B(p)| Bi==0) 
                if(Ci==C(p) | Ci==0)
                    check=1;
                    sub_nii(i(p),j(p),k(p))=1;
                end
            end
        end
    end
end
sub_nii=make_nii(sub_nii);
sub_nii.hdr=nodif_brain_mask_nii.hdr;


end

        
        


