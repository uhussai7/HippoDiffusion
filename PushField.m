function field_out_nii = PushField(field_in_nii,in1_nii, in2_nii, in3_nii,interp,extrap)

is4=0;
if(field_in_nii.hdr.dime.dim(1)==4)
    is4=1;
end

if(is4==0)
    field_out_nii=Ipqr(field_in_nii,in1_nii,in2_nii,in3_nii,0,interp,extrap);
    return
end

if(is4==1)
    sz=size(field_in_nii.img);
    sz(1:3)=size(in1_nii.img);
    field_out_nii=NaN(sz);
    for vol=1:sz(4)
        vol 
        temp_nii=Ipqr(field_in_nii,in1_nii,in2_nii,in3_nii,vol,interp,extrap);
        field_out_nii(:,:,:,vol)=temp_nii.img;
    end
    field_out_nii=make_nii(field_out_nii);
    field_out_nii.hdr=temp_nii.hdr;
    return
end
   


end

