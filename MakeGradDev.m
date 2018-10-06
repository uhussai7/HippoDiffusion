function grad_dev_nii = CreateGradDev(in1_nii,in2_nii,in3_nii)
%CREATEGRADDEV Summary of this function goes here


in1=in1_nii.img;
in2=in2_nii.img;
in3=in3_nii.img;

d1=in1_nii.hdr.dime.pixdim(2);
d2=in1_nii.hdr.dime.pixdim(3);
d3=in1_nii.hdr.dime.pixdim(4);

[grad_dev(:,:,:,4),grad_dev(:,:,:,1),grad_dev(:,:,:,7)]=grad_nonan(in1);
[grad_dev(:,:,:,5),grad_dev(:,:,:,2),grad_dev(:,:,:,8)]=grad_nonan(in2);
[grad_dev(:,:,:,6),grad_dev(:,:,:,3),grad_dev(:,:,:,9)]=grad_nonan(in3);

size_gd=size(grad_dev);

grad_dev(:,:,:,1)=grad_dev(:,:,:,1)/d1;
grad_dev(:,:,:,2)=grad_dev(:,:,:,2)/d1;
grad_dev(:,:,:,3)=grad_dev(:,:,:,3)/d1;
grad_dev(:,:,:,4)=grad_dev(:,:,:,4)/d2;
grad_dev(:,:,:,5)=grad_dev(:,:,:,5)/d2;
grad_dev(:,:,:,6)=grad_dev(:,:,:,6)/d2;
grad_dev(:,:,:,7)=grad_dev(:,:,:,7)/d3;
grad_dev(:,:,:,8)=grad_dev(:,:,:,8)/d3;
grad_dev(:,:,:,9)=grad_dev(:,:,:,9)/d3;

grad_dev_nii=make_nii(grad_dev);
grad_dev_nii.hdr=in1_nii.hdr;
grad_dev_nii.hdr.dime.dim(1)=4;
grad_dev_nii.hdr.dime.dim(2:5)=size(grad_dev_nii.img);


end