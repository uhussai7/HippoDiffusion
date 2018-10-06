function [A_nii,B_nii,C_nii] = InvertSpacesSI(a,b,c,p,q,r,start_pqr,end_pqr,Np,Nq,Nr)
%INVERTSPACES Summary of this function goes here
%   Detailed explanation goes here
%   -goes from p(a,b,c), q(a,b,c), r(a,b,c) --> a(p,q,r), b(p,q,r),
%   c(p,q,r)= A, B, C
%   -a,b,c,p,q,r are lists
%   -shp_... are the alpha shapes
%   -start_pqr, end_pqr, Np, Nq, Nr are the the start and end points
%   and the size of the pqr grid

Fa=scatteredInterpolant(p,q,r,a,'linear','none');
Fb=scatteredInterpolant(p,q,r,b,'linear','none');
Fc=scatteredInterpolant(p,q,r,c,'linear','none');


sp=start_pqr(1);
sq=start_pqr(2);
sr=start_pqr(3);

ep=end_pqr(1);
eq=end_pqr(2);
er=end_pqr(3);

samplingp=sp:(ep-sp)/(Np-1):ep;
samplingq=sq:(eq-sq)/(Nq-1):eq;
samplingr=sr:(er-sr)/(Nr-1):er;


[Q,P,R]=meshgrid(samplingq,samplingp,samplingr);


A=Fa(P,Q,R);
B=Fb(P,Q,R);
C=Fc(P,Q,R);

A_nii=make_nii(A);
B_nii=make_nii(B);
C_nii=make_nii(C);


A_nii.hdr.dime.pixdim(2:4)=[(ep-sp)/(Np-1),(eq-sq)/(Nq-1),(er-sr)/(Nr-1)];
A_nii.hdr.hist.sform_code=1;
A_nii.hdr.hist.srow_x=[(ep-sp)/(Np-1),0,0,sp];
A_nii.hdr.hist.srow_y=[0,(eq-sq)/(Nq-1),0,sq];
A_nii.hdr.hist.srow_z=[0,0,(er-sr)/(Nr-1),sr];

B_nii.hdr=A_nii.hdr;
C_nii.hdr=A_nii.hdr;


end
