subject='sub-100610';
LR='L'
InitializeUnfoldingWithDarkband;
CreateInterpolants

%move snaps to native and write output to correct folder


for snap=1:9
    all=readCaminoTracts(sprintf('..\\scratch_camino_track\\alisnapseeds\\snap%d_sphere.Bfloat',snap));
    [all_xyz_f, all_utvtwt_f]=moveStreams2Native(all,Fu_utvtwt,Fv_utvtwt,Fw_utvtwt,Fx_uvw,Fy_uvw,Fz_uvw,Hippo_alpha);
    writeCaminoTracts(all_xyz_f,sprintf('..\\scratch_camino_track\\alisnapseeds\\snap%d_sphere_native_f.Bfloat',snap));
    writeCaminoTracts(all_utvtwt_f,sprintf('..\\scratch_camino_track\\alisnapseeds\\snap%d_sphere_reparam_f.Bfloat',snap));
end


%move manual to native, filter and write ouput to correct folder

manuals={"..\\seedsForTractography\\center.nii.gz.Bfloat", ...
         "..\\seedsForTractography\\perforant.nii.gz.Bfloat", ...
         "..\\seedsForTractography\\perforant2.nii.gz.Bfloat"};
     
for manu=1:3
    all=readCaminoTracts(manuals{manu});
    [all_xyz_f, all_utvtwt_f]=moveStreams2Native(all,Fu_utvtwt,Fv_utvtwt,Fw_utvtwt,Fx_uvw,Fy_uvw,Fz_uvw,Hippo_alpha);
    writeCaminoTracts(all_xyz_f,sprintf("%s%s",manuals{manu},"_native_f.Bfloat"));
    writeCaminoTracts(all_utvtwt_f,sprintf("%s%s",manuals{manu},"_reparam_f.Bfloat"));
end


%% Move native streams to 

all=readCaminoTracts('..\\nativeDeterministicTractography\\Crop\\native_trunc.Bflaot');
[all_xyz_f, all_utvtwt_f]=moveStreams2Reparam(all,Fu_xyz,Fv_xyz,Fw_xyz,Fut_uvw,Fvt_uvw,Fwt_uvw,utvtwt_alpha);

writeCaminoTracts(all_xyz_f,'..\\nativeDeterministicTractography\\Crop\\native_trunc_f.float');
writeCaminoTracts(all_utvtwt_f,'..\\nativeDeterministicTractography\\Crop\\reparam_trunc_f.float');

%% Move reaparam to native

all=readCaminoTracts('..\\tracts_0625mm_reparam\\all.Bfloat');
%[all_xyz_f, all_utvtwt_f]=moveStreams2Reparam(all,Fu_xyz,Fv_xyz,Fw_xyz,Fut_uvw,Fvt_uvw,Fwt_uvw,utvtwt_alpha);

[all_xyz_f, all_utvtwt_f]=moveStreams2Native(all,Fu_utvtwt,Fv_utvtwt, Fw_utvtwt, Fx_uvw, Fy_uvw, Fz_uvw,Hippo_alpha);

writeCaminoTracts(all_xyz_f,'..\\tracts_0625mm_native\\from_reparam_all_f.Bfloat');
writeCaminoTracts(all_utvtwt_f,'..\\tracts_0625mm_reparam\\all_f.Bfloat');

%% Move native to reparam

all=readCaminoTracts('..\\tracts_0625mm_native\\all.Bfloat');
[all_xyz_f, all_utvtwt_f]=moveStreams2Reparam(all,Fu_xyz,Fv_xyz,Fw_xyz,Fut_uvw,Fvt_uvw,Fwt_uvw,utvtwt_alpha);

%[all_xyz_f, all_utvtwt_f]=moveStreams2Native(all,Fu_utvtwt,Fv_utvtwt, Fw_utvtwt, Fx_uvw, Fy_uvw, Fz_uvw,Hippo_alpha);

writeCaminoTracts(all_xyz_f,'..\\tracts_0625mm_native\\all_f.Bfloat');
writeCaminoTracts(all_utvtwt_f,'..\\tracts_0625mm_reparam\\from_native_all_f.Bfloat');


