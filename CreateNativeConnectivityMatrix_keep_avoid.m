%assume that subject and hemisphere are already choosen

for si=1:4
    for sj=si+1:5
        xz=load(sprintf('..\\hipposubjects_native_probtrackx_curvature_keep_avoid\\%s_%s_%d%d_keep_avoid_probtrack\\fdt_matrix1.dot',subject,LR,si,sj));
        coord=load(sprintf('..\\hipposubjects_native_probtrackx_curvature_keep_avoid\\%s_%s_%d%d_keep_avoid_probtrack\\coords_for_fdt_matrix1',subject,LR,si,sj))+1;
        M=full(spconvert(xz));
        M=M/max(M(:));
        sub1_inds=find(coord(:,4)==1);
        sub2_inds=find(coord(:,4)==2);
        %sub3_inds=find(coord(:,4)==3);
        %sub4_inds=find(coord(:,4)==4);
        %sub5_inds=find(coord(:,4)==5);
        Msub_minmax=zeros(5,2);
        for i=1:2
            Msub_minmax(i,1)=min(find(coord(:,4)==i));
            Msub_minmax(i,2)=max(find(coord(:,4)==i));
        end
        Msub=zeros(5,5);
        for i=1:2
            for j=1:2
                Msub_temp=M(Msub_minmax(i,1):Msub_minmax(i,2),Msub_minmax(j,1):Msub_minmax(j,2));
                Msub_temp_c=mean(sum(Msub_temp,2)/size(Msub_temp,2));
                Msub(i,j)=Msub_temp_c;
            end
        end
        Msub_keep_avoid(si,si)=Msub(1,1);
        Msub_keep_avoid(sj,sj)=Msub(2,2);
        Msub_keep_avoid(si,sj)=Msub(1,2);
        Msub_keep_avoid(sj,si)=Msub(2,1);
    end
end

%figure;
% imagesc(Msub_keep_avoid)
% axis equal
% set(gca,'xtick',[])
% set(gca,'ytick',[])
% text(-0.5,1,"CA4")
% text(-0.5,2,"CA3")
% text(-0.5,3,"CA2")
% text(-0.5,4,"CA1")
% text(-0.5,5,"SUB")
% text(1,5.75,"CA4",'HorizontalAlignment','center','VerticalAlignment','middle');
% text(2,5.75,"CA3",'HorizontalAlignment','center','VerticalAlignment','middle');
% text(3,5.75,"CA2",'HorizontalAlignment','center','VerticalAlignment','middle');
% text(4,5.75,"CA1",'HorizontalAlignment','center','VerticalAlignment','middle');
% text(5,5.75,"SUB",'HorizontalAlignment','center','VerticalAlignment','middle');
% axis tight;