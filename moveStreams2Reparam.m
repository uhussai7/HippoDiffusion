function [native_streams_f, reparam_streams_f] = moveStreams2Reparam(all,Fu,Fv,Fw,Fut,Fvt,Fwt,alphaS)
%MOVESTREAMS2NATIVE moves reparam streams to native 
%   moves native streams to reparam and also filters the native streams
%   for a 1 to 1 mapping
%   all is all the native strams in cell array format
%   alphaS is alpha shape for the unfolded hippocampus

    for s=1:size(all,2)
        for p=1:(size(all{1,s},1))
            all_uvw{1,s}(p,1)=Fu(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
            all_uvw{1,s}(p,2)=Fv(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
            all_uvw{1,s}(p,3)=Fw(all{1,s}(p,1),all{1,s}(p,2),all{1,s}(p,3));
            all_utvtwt{1,s}(p,1)=Fut(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
            all_utvtwt{1,s}(p,2)=Fvt(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
            all_utvtwt{1,s}(p,3)=Fwt(all_uvw{1,s}(p,1),all_uvw{1,s}(p,2),all_uvw{1,s}(p,3));
        end    
    end

    stream_out=zeros(1,size(all_utvtwt,2));
    for s=1:size(all_utvtwt,2)
        for p=1:(size(all{1,s},1))
            if(isnan(all_utvtwt{1,s}(p,:))==0)
                if(inShape(alphaS,all_utvtwt{1,s}(p,1),all_utvtwt{1,s}(p,2),all_utvtwt{1,s}(p,3))~=1)
                    stream_out(s)=1;
                    break;
                end
            end
        end
    end

    sf=1
    for s=1:size(all_utvtwt,2)
        if(stream_out(s)==0)
            reparam_streams_f{1,sf}=all_utvtwt{1,s};
            native_streams_f{1,sf}=all{1,s};
            sf=sf+1;
        end
    end


end




