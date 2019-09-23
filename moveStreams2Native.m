function [native_streams_f, reparam_streams_f] = moveStreams2Native(all,Fu,Fv,Fw,Fx,Fy,Fz,alphaS)
%MOVESTREAMS2NATIVE moves reparam streams to native 
%   moves reparam streams to native and also filters the reparam streams
%   for a 1 to 1 mapping
%   all is all the reparam strams in cell array format
%   alphaS is alpha shape for the native hippocampus

for s=1:size(all,2)
    for p=1:(size(all{1,s},1))
        all_uvw{1,s}(p,1)=Fu(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
        all_uvw{1,s}(p,2)=Fv(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
        all_uvw{1,s}(p,3)=Fw(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
        all_xyz{1,s}(p,1)=Fx(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
        all_xyz{1,s}(p,2)=Fy(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
        all_xyz{1,s}(p,3)=Fz(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
    end    
end

stream_out=zeros(1,size(all_xyz,2));
for s=1:size(all_xyz,2)
    for p=1:(size(all{1,s},1))
        if(isnan(all_xyz{1,s}(p,:))==0)
            if(inShape(alphaS,all_xyz{1,s}(p,1),all_xyz{1,s}(p,2),all_xyz{1,s}(p,3))~=1)
                stream_out(s)=1;
                break;
            end
        end
    end
end

sf=1
for s=1:size(all_xyz,2)
    if(stream_out(s)==0)
        native_streams_f{1,sf}=all_xyz{1,s};
        reparam_streams_f{1,sf}=all{1,s};
        sf=sf+1;
    end
end


end

