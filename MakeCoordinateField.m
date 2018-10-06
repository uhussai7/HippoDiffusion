function [out1_nii,out2_nii,out3_nii] = MakeCoordinateField(in1_nii,in2_nii,in3_nii,F1,F2,F3)

out1_nii=make_nii(F1(in1_nii.img,in2_nii.img,in3_nii.img));
out1_nii.hdr=in1_nii.hdr;
out2_nii=make_nii(F2(in1_nii.img,in2_nii.img,in3_nii.img));
out2_nii.hdr=in1_nii.hdr;
out3_nii=make_nii(F3(in1_nii.img,in2_nii.img,in3_nii.img));
out3_nii.hdr=in1_nii.hdr;

end

