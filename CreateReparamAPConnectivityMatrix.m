xz=load(sprintf('..\\hipposubjects_reparam_AP\\%s_%s_AP_probtrack\\fdt_matrix1.dot',subject,LR));
coord=load(sprintf('..\\hipposubjects_reparam_AP\\%s_%s_AP_probtrack\\coords_for_fdt_matrix1',subject,LR))+1;
M=full(spconvert(xz));
M=M/max(M(:));

% how does mask #'s 1-30 map to subfields?
%
NumOfBins=6

Msub_minmax=zeros(5,2);
for a=1:NumOfBins*5
    %a
    sub_inds(a).inds=find(coord(:,4)==a);
    sub_inds(a).min=min(sub_inds(a).inds);
    sub_inds(a).max=max(sub_inds(a).inds);
end

Msub_minmax=zeros(5*NumOfBins,2);

Msub=zeros(30,30);
for i=1:30
    for j=1:30
        Msub_temp=M(sub_inds(i).min:sub_inds(i).max,sub_inds(j).min:sub_inds(j).max);
        Msub_temp_c=mean(sum(Msub_temp,2)/size(Msub_temp,2));
        Msub(i,j)=Msub_temp_c;
    end
end


% imagesc(Msub)
% axis equal;
% axis tight;
% set(gca,'xtick',[])
% set(gca,'ytick',[])
% for a=1:NumOfBins
%     text(-0.5,5*(a-1)+1,"CA4")
%     text(-0.5,5*(a-1)+2,"CA3")
%     text(-0.5,5*(a-1)+3,"CA2")
%     text(-0.5,5*(a-1)+4,"CA1")
%     text(-0.5,5*(a-1)+5,"SUB")
%     
%     text(5*(a-1)+1,0,"CA4",'HorizontalAlignment','center','VerticalAlignment','middle');
%     text(5*(a-1)+2,0,"CA3",'HorizontalAlignment','center','VerticalAlignment','middle');
%     text(5*(a-1)+3,0,"CA2",'HorizontalAlignment','center','VerticalAlignment','middle');
%     text(5*(a-1)+4,0,"CA1",'HorizontalAlignment','center','VerticalAlignment','middle');
%     text(5*(a-1)+5,0,"SUB",'HorizontalAlignment','center','VerticalAlignment','middle');
%     hline(5*a+.5)
%     vline(5*a+.5)
% 
% end
% text(-2.5,1,"TAIL")
% text(-2.5,30,"HEAD")
% text(1,-0.5,"TAIL",'Rotation',90)
% text(30,-0.5,"HEAD",'Rotation',90)


% NumOfBins=6
% for a=1:NumOfBins
%     sub1_inds=find(coord(:,4)==5*(a-1)+1);
%     sub2_inds=find(coord(:,4)==5*(a-1)+2);
%     sub3_inds=find(coord(:,4)==5*(a-1)+3);
%     sub4_inds=find(coord(:,4)==5*(a-1)+4);
%     sub5_inds=find(coord(:,4)==5*(a-1)+5);
%     for s=1:5
%         