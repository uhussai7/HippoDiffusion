function Msub = CollapseConnectivity(subject,LR,NR,DI,AP)

%NR=0 Native, NR=1 Reparam
%DI=0 Indirect, DI=1, Direct 
%AP=1/0 Anterior Posterior ON/OFF

NatRep=["Native","Reparam"];
DirIndir=["Indirect","Direct"];
%AP=["","ap"];


thepath=sprintf('..\\PaperResults\\%s\\Data\\ConnectivityMatrix\\%s',NatRep(NR+1),DirIndir(DI+1))

if(DI==0 && AP==0) %this is the indirect case (most straightforward)
    xz=load(sprintf('%s\\%s_%s_probtrackx_indirect\\fdt_matrix1.dot',thepath,subject,LR));
    coord=load(sprintf('%s\\%s_%s_probtrackx_indirect\\coords_for_fdt_matrix1',thepath,subject,LR))+1;
    M=full(spconvert(xz));
    Msub=CollapseMatrix(M,coord);
    return;
end

if(DI~=0 && AP==0) %this is the direct case for each entry you have to load seprate file
    for si=1:4
        for sj=si+1:5
            xz=load(sprintf('%s\\%s_%s_%d%d_keep_avoid_probtrack\\fdt_matrix1.dot',thepath,subject,LR,si,sj));
            coord=load(sprintf('%s\\%s_%s_%d%d_keep_avoid_probtrack\\coords_for_fdt_matrix1',thepath,subject,LR,si,sj))+1;
            M=full(spconvert(xz));
            Mtemp=CollapseMatrix(M,coord);
            Msub(si,si)=Mtemp(1,1);
            Msub(sj,sj)=Mtemp(2,2);
            Msub(si,sj)=Mtemp(1,2);
            Msub(sj,si)=Mtemp(2,1);
        end
    end
    return;
end


if(AP==1 && DI==0)
    thepath='..\\PaperResults\\Reparam\\Data\\ConnectivityMatrix\\AnteriorPosterior\\Indirect'
    xz=load(sprintf('%s\\%s_%s_probtrackx_ap_indirect\\fdt_matrix1.dot',thepath,subject,LR));
    coord=load(sprintf('%s\\%s_%s_probtrackx_ap_indirect\\coords_for_fdt_matrix1',thepath,subject,LR))+1;
    M=full(spconvert(xz));
    Msub=CollapseMatrix(M,coord);
    return;
end

if(AP==1 && DI==1) %the following are the only conditions where we use AP
    thepath='..\\PaperResults\\Reparam\\Data\\ConnectivityMatrix\\AnteriorPosterior\\Direct'
    for ap=1:6
        for si=1:4
            for sj=si+1:5
                xz=load(sprintf('%s\\%s_%s_ap%d_%d%d_probtrackx_direct\\fdt_matrix1.dot',thepath,subject,LR,ap,si,sj));
                coord=load(sprintf('%s\\%s_%s_ap%d_%d%d_probtrackx_direct\\coords_for_fdt_matrix1',thepath,subject,LR,ap,si,sj))+1; 
                M=full(spconvert(xz));
                Mtemp=CollapseMatrix(M,coord);
                Msub(ap,si,si)=Mtemp(1,1);
                Msub(ap,sj,sj)=Mtemp(2,2);
                Msub(ap,si,sj)=Mtemp(1,2);
                Msub(ap,sj,si)=Mtemp(2,1);
            end
        end
    end
    return;
end

end

function Msmall= CollapseMatrix(M,coord)
   
M=M/max(M(:));
N_fields=max(coord(:,4));
Msub_minmax=NaN(N_fields,2);
N_samples=5000;

for i=1:N_fields
    Msub_minmax(i,1)=min(find(coord(:,4)==i));
    Msub_minmax(i,2)=max(find(coord(:,4)==i));
end

Msub=zeros(N_fields,N_fields);

for i=1:N_fields
    for j=1:N_fields
        Msub_temp=M(Msub_minmax(i,1):Msub_minmax(i,2),Msub_minmax(j,1):Msub_minmax(j,2));
        Msub_temp_c=mean(sum(Msub_temp,2)/size(Msub_temp,2));
        Msmall(i,j)=Msub_temp_c;
    end
end

end