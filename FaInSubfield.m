function FAs = FaInSubfield(sub1_nii,sub2_nii,sub3_nii,sub4_nii,sub5_nii, FA_nii)
FAsub1(:)=FA_nii.img(sub1_nii.img==1);
FAsub2(:)=FA_nii.img(sub2_nii.img==1);
FAsub3(:)=FA_nii.img(sub3_nii.img==1);
FAsub4(:)=FA_nii.img(sub4_nii.img==1);
FAsub5(:)=FA_nii.img(sub5_nii.img==1);

FAs(1)=mean(FAsub1);
FAs(2)=mean(FAsub2);
FAs(3)=mean(FAsub3);
FAs(4)=mean(FAsub4);
FAs(5)=mean(FAsub5);

end

