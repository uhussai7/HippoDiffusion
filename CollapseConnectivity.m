function Msub = CollapseConnectivity(subject,LR,NR,DI,AP,BIN,res)

%NR=1 Native, NR=2 Reparam
%DI=0 Indirect, DI=1, Direct 
%AP=1/0 Anterior Posterior ON/OFF
%BIN =1 will overwrite all other options and go to reparam bins mode

NatRep=["native","reparam"];
DirIndir=["Indirect","Direct"];
resolution=["125","0625"];
%AP=["","ap"];


thepath=sprintf('..\\ChangingRes\\hipposubjects_%s_%smm\\%s_%s',NatRep(NR),resolution(res),subject,LR);

if(BIN==1)
    fprintf("WARNING: Other options ignored, if BIN=1, I will work with binned subfields in reparam space.")
    thepath=sprintf('..\\ChangingRes\\hipposubjects_reparam_%smm\\%s_%s',resolution(res),subject,LR);
    xz=load(sprintf('%s\\probtrackx_indirect_bins\\fdt_matrix1.dot',thepath));
    coord=load(sprintf('%s\\probtrackx_indirect_bins\\coords_for_fdt_matrix1',thepath))+1;
    M=full(spconvert(xz));
    Msub=CollapseMatrix(M,coord);
    map=zeros(1,120);
    count=1;
    for io=1:2 %this is going to be the "new" mapping from  
        for aapee=1:6
            for peedee=1:10
                mapping(peedee,aapee,io)= count;
                count=count+1;
            end
        end
    end
    count=1;
    for peedee=1:10
        for aapee=1:6
            for io=1:2 %this is the old mapping or the given mapping from past mistakes                  
                mapping1(peedee,aapee,io)= count;
                count=count+1;
            end
        end
    end
    for new_coords=1:120
        inds=find(mapping==new_coords);
        [peedee,aapee,io]=ind2sub(size(mapping),inds);
        oldofnew(new_coords)=mapping1(peedee,aapee,io);
    end
    Msub_old=Msub;
    for new_coords_i=1:120
        for new_coords_j=1:120
            i=oldofnew(new_coords_i);
            j=oldofnew(new_coords_j);
            Msub(new_coords_i,new_coords_j)=Msub_old(i,j);
        end
    end
    return;
end


if(DI==0 && AP==0) %this is the indirect case (most straightforward)
    xz=load(sprintf('%s\\probtrackx_indirect\\fdt_matrix1.dot',thepath));
    coord=load(sprintf('%s\\probtrackx_indirect\\coords_for_fdt_matrix1',thepath))+1;
    M=full(spconvert(xz));
    Msub=CollapseMatrix(M,coord);
    return;
end

if(AP==1 && DI==0)
    xz=load(sprintf('%s\\probtrackx_indirect_ap\\fdt_matrix1.dot',thepath));
    coord=load(sprintf('%s\\probtrackx_indirect_ap\\coords_for_fdt_matrix1',thepath))+1;
    M=full(spconvert(xz));
    size(M)
    Msub=CollapseMatrix(M,coord);
    return;
end



if(DI~=0 && AP==0) %this is the direct case for each entry you have to load seprate file
    for si=1:4
        for sj=si+1:5
            xz=load(sprintf('%s\\probtrackx_direct_pd_%d%d\\fdt_matrix1.dot',thepath,si,sj));
            coord=load(sprintf('%s\\probtrackx_direct_pd_%d%d\\coords_for_fdt_matrix1',thepath,si,sj))+1;
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



if(AP==1 && DI==1) 
    for ap=1:6
        for si=1:4
            for sj=si+1:5
                xz=load(sprintf('%s\\probtrackx_direct_pd_ap_%d%d%d\\fdt_matrix1.dot',thepath,si,sj,ap));
                coord=load(sprintf('%s\\probtrackx_direct_pd_ap_%d%d%d\\coords_for_fdt_matrix1',thepath,si,sj,ap))+1; 
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


