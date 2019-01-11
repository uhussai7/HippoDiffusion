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

figure;
bars=50;
maxx=0.4;
subplot(5,1,1);
hist(FAsub1,bars);
xlabel('FA')
text(0.41,100,'CA4')
ylabel('N')
%title('CA4')
xlim([0,maxx]);
subplot(5,1,2);
hist(FAsub2,bars);
xlabel('FA')
ylabel('N')
%title('CA3')
text(0.41,150,'CA3')
xlim([0,maxx]);
subplot(5,1,3);
hist(FAsub3,bars);
xlabel('FA')
ylabel('N')
%title('CA2')
text(0.41,100,'CA2')
xlim([0,maxx]);
subplot(5,1,4);
hist(FAsub4,bars);
xlabel('FA')
ylabel('N')
%title('CA1')
text(0.41,500,'CA1')
xlim([0,maxx]);
subplot(5,1,5);
hist(FAsub5,bars);
xlabel('FA')
ylabel('N')
%title('SUB')
text(0.41,100,'SUB')
xlim([0,maxx]);

[test,pval]=ttest2(FAsub1,FAsub4)

bigsz=size(FAsub1,2)+size(FAsub2,2)+size(FAsub3,2)+size(FAsub4,2)+size(FAsub5,2);
allFA=NaN(1,bigsz);
g=NaN(1,bigsz);


allFA(1:size(FAsub1,2))=FAsub1(:);
g(1:size(FAsub1,2))=1;
cumaL=size(FAsub1,2)+1;
cumaR=size(FAsub1,2)+size(FAsub2,2);

allFA(cumaL:cumaR)=FAsub2(:);
g(cumaL:cumaR)=2;
cumaL=cumaR+1;
cumaR=cumaR+size(FAsub3,2);

allFA(cumaL:cumaR)=FAsub3(:);
g(cumaL:cumaR)=3;
cumaL=cumaR+1;
cumaR=cumaR+size(FAsub4,2);

allFA(cumaL:cumaR)=FAsub4(:);
g(cumaL:cumaR)=4;
cumaL=cumaR+1;
cumaR=cumaR+size(FAsub5,2);

allFA(cumaL:cumaR)=FAsub5(:);
g(cumaL:cumaR)=5;


[p,tgb1,stats]=anova1(allFA,g)
ylabel('FA')
xticklabels({'CA4','CA3','CA2','CA1','SUB'})
multcompare(stats)