%% create the uvw domain
se(1,:)=[min(u) max(u)];
se(2,:)=[min(v) max(v)];
se(3,:)=[min(w) max(w)];

[U_dom_nii, V_dom_nii, W_dom_nii]=MakeDomain(se,100,100,10,uvw_alpha,0,0);
[X_uvw_nii,Y_uvw_nii,Z_uvw_nii]=MakeCoordinateField(U_dom_nii,V_dom_nii,W_dom_nii,Fx_uvw,Fy_uvw,Fz_uvw);
[Ut_uvw_nii,Vt_uvw_nii,Wt_uvw_nii]=MakeCoordinateField(U_dom_nii,V_dom_nii,W_dom_nii,Fut_uvw,Fvt_uvw,Fwt_uvw);


%% create utuvtwt domain
se(1,:)=[min(ut) max(ut)];
se(2,:)=[min(vt) max(vt)];
se(3,:)=[min(wt) max(wt)];

diff_ut=se(1,2)-se(1,1);
diff_vt=se(2,2)-se(2,1);
diff_wt=se(3,2)-se(3,1);
Nut=100;
Nvt=floor((Nut-1)*diff_vt/diff_ut+1);
Nwt=floor((Nut-1)*diff_wt/diff_ut+1);

[Ut_dom_nii, Vt_dom_nii, Wt_dom_nii]=MakeDomain(se,Nut,Nvt,Nwt,utvtwt_alpha,0,0);
[U_utvtwt_nii,V_utvtwt_nii,W_utvtwt_nii]=MakeCoordinateField(Ut_dom_nii,Vt_dom_nii,Wt_dom_nii,Fu_utvtwt,Fv_utvtwt,Fw_utvtwt);
[X_utvtwt_nii,Y_utvtwt_nii,Z_utvtwt_nii]=MakeCoordinateField(U_utvtwt_nii,V_utvtwt_nii,W_utvtwt_nii,Fx_uvw,Fy_uvw,Fz_uvw);