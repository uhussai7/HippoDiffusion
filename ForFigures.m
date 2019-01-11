subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']

iii=1
jjj=1

subject=subjects(iii)
LR=LRs(jjj)

InitializeUnfolding


[bf,P] = boundaryFacets(Hippo_alpha)


trisurf(bf,P(:,1),P(:,2),P(:,3),Fu_xyz(P(:,1),P(:,2),P(:,3))) 


axis equal

stlwrite('test',bf,P)

FV.faces=bf;
FV.vertices=P;
FV2=smoothpatch(FV2,0,1,1,1)

thres=0.1;
thres=0.075;
UU=Fu_xyz(FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3));
VV=Fv_xyz(FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3));
WW=Fw_xyz(FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3));
inds1UU=UU>1-thres;
inds2UU=UU<thres;
inds1VV=VV>1-thres;
inds2VV=VV<thres;
inds1WW=WW>1-thres;
inds2WW=WW<thres;


B=UU;
B(:)=62;
B(inds1UU)=44;
B(inds1VV)=54;
%B(inds1WW)=48;


%h=trisurf(FV2.faces,FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3),Fw_xyz(FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3)),'EdgeColor','none') 

figure;
h=trisurf(FV2.faces,FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3),B,'EdgeColor','none') 

axis equal

colormap colorcube
caxis([1,64])
h.FaceLighting='gouraud'
view(-152,41)
c = camlight('left');


