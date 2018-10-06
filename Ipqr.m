function Iout_nii = Ipqr(Iabc_nii,A_nii,B_nii,C_nii,vol,interp,extrapp)
%-Iabc_nii is the (cropped) nifti file of the domain i.e. where I(a,b,c) is defined
%and will be pushed from
%-alpha is the alpha shape of the domain
%-alpha_nii is the nifti file whose s-form brings us to cords. where alpha
%is defined
%-A,B,C are a(p,q,r), b(p,q,r) and c(p,q,r) 
%-Note that a,b,c are the voxel coordinates of alpha_nii (the same space
%alpha is defined in)
%-vol is the volume being used, use vol=0 for single volume files

if(vol==0)
    roi=Iabc_nii.img;
else
    roi=Iabc_nii.img(:,:,:,vol);
end

%if(extrap==1)
%    extrapp='linear';
%else
%    extrapp='none';
%end



inds=find(isnan(roi)==0);
V=roi(inds);
[i,j,k]=ind2sub(size(roi),inds);

for q=1:size(i)
    temp=World(Iabc_nii,i(q),j(q),k(q));
    i(q,1)=temp(1);
    j(q,1)=temp(2);
    k(q,1)=temp(3);
end
   
Fimg=scatteredInterpolant(i,j,k,V,interp,extrapp);


Iout_nii=Fimg(A_nii.img,B_nii.img,C_nii.img);

Iout_nii=make_nii(Iout_nii);

Iout_nii.hdr=A_nii.hdr;

if(vol~=0)
    Iout_nii.hdr=Iabc_nii.hdr;
    Iout_nii.hdr.dime.dim(2:4)=A_nii.hdr.dime.dim(2:4);
    Iout_nii.hdr.dime.pixdim(2:4)=A_nii.hdr.dime.pixdim(2:4);
    Iout_nii.hdr.hist=A_nii.hdr.hist;
end

end
