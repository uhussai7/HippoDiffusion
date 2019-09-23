%% Initialize and load depentcies 

subject='sub-100610';
LR='L'
InitializeUnfoldingWithDarkband;
CreateInterpolants
MakeDomains
    

%% Get camino data

all=readCaminoTracts('..\\scratch_camino_track\\reparam_all_f_mintp5.Bfloat');
for s=1:size(all_xyz_f,2)
    %plot3(all{1,s}(:,1),all{1,s}(:,2),all{1,s}(:,3))
    if(stream_out(s)==0)
        plot3(all_xyz_f{1,s}(:,1),all_xyz_f{1,s}(:,2),all_xyz_f{1,s}(:,3));
        hold on
    end
end


%% what happens if you just move the points??
for s=1:size(all,2)
    for p=1:(size(all{1,s},1))
        all_uvw{1,s}(p,1)=Fu_utvtwt(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
        all_uvw{1,s}(p,2)=Fv_utvtwt(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
        all_uvw{1,s}(p,3)=Fw_utvtwt(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
        all_xyz{1,s}(p,1)=Fx_uvw(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
        all_xyz{1,s}(p,2)=Fy_uvw(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
        all_xyz{1,s}(p,3)=Fz_uvw(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
    end    
end

%have to remove streamlines that are outside the native hippocampus''

stream_out=zeros(1,size(all_xyz,2));
for s=1:size(all_xyz,2)
    for p=1:(size(all{1,s},1))
        if(isnan(all_xyz{1,s}(p,:))==0)
            if(inShape(Hippo_alpha,all_xyz{1,s}(p,1),all_xyz{1,s}(p,2),all_xyz{1,s}(p,3))~=1)
                stream_out(s)=1;
                break;
            end
        end
    end
end

sf=1
for s=1:size(all_xyz,2)
    if(stream_out(s)==0)
        all_xyz_f{1,sf}=all_xyz{1,s};
        all_utvtwt_f{1,sf}=all{1,s};
        sf=sf+1;
    end
end

%write the camino file
writeCaminoTracts(all_xyz_f,'native_all_f_mintp5_f.Bfloat');
writeCaminoTracts(all_utvtwt_f,'reparam_all_f_mintp5_f.Bfloat');
%% move to native space



%% convert to camino and out