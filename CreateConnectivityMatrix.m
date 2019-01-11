%xz=load('fdt_matrix1.dot');
M=full(spconvert(xz));
%figure;imagesc(M);
 
%coord = load('coords_for_fdt_matrix1')+1;


sub1_inds=find(coord(:,4)==1);
sub2_inds=find(coord(:,4)==2);
sub3_inds=find(coord(:,4)==3);
sub4_inds=find(coord(:,4)==4);
sub5_inds=find(coord(:,4)==5);

Msub_minmax=zeros(5,2);
for i=1:5
    Msub_minmax(i,1)=min(find(coord(:,4)==i));
    Msub_minmax(i,2)=max(find(coord(:,4)==i));
end

Msub1=M(1:max(sub1_inds),1:max(sub1_inds));
Msub2=M(max(sub1_inds):max(sub2_inds),max(sub1_inds):max(sub2_inds));
Msub3=M(max(sub2_inds):max(sub3_inds),max(sub2_inds):max(sub3_inds));
Msub4=M(max(sub3_inds):max(sub4_inds),max(sub3_inds):max(sub4_inds));
Msub5=M(max(sub4_inds):max(sub5_inds),max(sub4_inds):max(sub5_inds));


%figure;imagesc(log(Msub12))

%diagM=diag(M)

%plot(diagM)

Msub1_c=mean(sum(Msub1,2)/size(Msub1,1))
Msub2_c=mean(sum(Msub2,2)/size(Msub2,1))
Msub3_c=mean(sum(Msub3,2)/size(Msub3,1))
Msub4_c=mean(sum(Msub4,2)/size(Msub4,1))
Msub5_c=mean(sum(Msub5,2)/size(Msub5,1))


Msub=zeros(5,5);
for i=1:5
    for j=1:5
        Msub_temp=M(Msub_minmax(i,1):Msub_minmax(i,2),Msub_minmax(j,1):Msub_minmax(j,2));
        Msub_temp_c=mean(sum(Msub_temp,2)/size(Msub_temp,2));
        Msub(i,j)=Msub_temp_c;
    end
end



%add some text
figure;
imagesc(Msub)
axis equal;
set(gca,'xtick',[])
set(gca,'ytick',[])

text(0,1,"CA4")
text(0,2,"CA3")
text(0,3,"CA2")
text(0,4,"CA1")
text(0,5,"SUB")

text(1,5.75,"CA4",'HorizontalAlignment','center','VerticalAlignment','middle');
text(2,5.75,"CA3",'HorizontalAlignment','center','VerticalAlignment','middle');
text(3,5.75,"CA2",'HorizontalAlignment','center','VerticalAlignment','middle');
text(4,5.75,"CA1",'HorizontalAlignment','center','VerticalAlignment','middle');
text(5,5.75,"SUB",'HorizontalAlignment','center','VerticalAlignment','middle');




