%load all the relavant files 

FA_nii=load_nii(sprintf('..\\hipposubjects_reparam\\%s_%s_dtifit_FA.nii.gz',subject,LR));

sub1_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub1.nii.gz',subject,LR));
sub2_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub2.nii.gz',subject,LR));
sub3_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub3.nii.gz',subject,LR));
sub4_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub4.nii.gz',subject,LR));
sub5_nii=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub5.nii.gz',subject,LR));

FAsub1(:)=FA_nii.img(sub1_nii.img==1);
FAsub2(:)=FA_nii.img(sub2_nii.img==1);
FAsub3(:)=FA_nii.img(sub3_nii.img==1);
FAsub4(:)=FA_nii.img(sub4_nii.img==1);
FAsub5(:)=FA_nii.img(sub5_nii.img==1);
