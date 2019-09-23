subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
curv=["0","0.34","0.64","0.866","0.98"]
NOrReparam=["native","reparam"];

% for iii=1:4
%     for jjj=1:2
%         subject=subjects(iii)
%         LR=LRs(jjj)
%         xz=
%         CreateDarkBandExtension
%         clearvars -except iii jjj subjects LRs 
%     end
% end

iii=1;jjj=1;
subject=subjects(iii);
LR=LRs(jjj);
norr=2;
for c=1:5
    curv(c)
    %xz=load(sprintf('Z:\\scratch\\hipposubjects_%s_probtrackx_curvature\\%s_%s_%sprobtrack\\fdt_matrix1.dot',NOrReparam(norr),subject,LR,curv(c)));
    %coord=load(sprintf('Z:\\scratch\\hipposubjects_%s_probtrackx_curvature\\%s_%s_%sprobtrack\\coords_for_fdt_matrix1',NOrReparam(norr),subject,LR,curv(c)))+1;
    xz=load(sprintf('..//hipposubjects_%s_probtrackx_curvature//%s_%s_%sprobtrack//fdt_matrix1.dot',NOrReparam(norr),subject,LR,curv(c)));
    coord=load(sprintf('..//hipposubjects_%s_probtrackx_curvature//%s_%s_%sprobtrack//coords_for_fdt_matrix1',NOrReparam(norr),subject,LR,curv(c)))+1;
    figure;
    CreateConnectivityMatrix
    Msub_all_reparam{c}=Msub;
end


plot(Msub_all{:}(1,1));

figure;
for i=1:5
    for j=i:5
        i
        for c=1:5
            buffer(c)=Msub_all_native{c}(i,j)
        end
        plot(buffer);
        clear buffer;
        hold on;
    end
end
