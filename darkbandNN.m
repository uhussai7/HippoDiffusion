function [Udb_crop_nii,Vdb_crop_nii,Wdb_crop_nii] = darkbandNN(U_crop_nii,V_crop_nii,W_crop_nii,labelmap_crop_nii)


Wdb_crop_nii=W_crop_nii.img;
Udb_crop_nii=U_crop_nii.img;
Vdb_crop_nii=V_crop_nii.img;


%Since the hippocampus is defined slightly differently in U, V, W, grad W & label map we need to find one mask that is common to all (all but label map).
[gradWy, gradWx, gradWz] = grad_nonan(W_crop_nii.img);

mask_gx=isnan(gradWx)==0;
mask_gy=isnan(gradWy)==0;
mask_gz=isnan(gradWz)==0;

mask_u=isnan(U_crop_nii.img)==0;
mask_v=isnan(V_crop_nii.img)==0;
mask_w=isnan(W_crop_nii.img)==0;
grand_mask=double(mask_gx.*mask_gy.*mask_gz.*mask_u.*mask_v);
grand_mask_for_later=mask_w.*mask_u.*mask_v;

Wdb_crop_nii(grand_mask==0 | grand_mask==2)=NaN;
Vdb_crop_nii(grand_mask==0 | grand_mask==2)=NaN;
Udb_crop_nii(grand_mask==0 | grand_mask==2)=NaN;

localmask=double(labelmap_crop_nii.img);
localmask(localmask>2)=0;
localmask(localmask==1)=0;
localmask=grand_mask+localmask;
localmask(localmask==3)=1;

inds_db=find(localmask==2);

counter=0;
while size(inds_db,1)>1
    before=size(inds_db);
    inds_db=find(localmask==2);
    xyzdb=NaN(size(inds_db,1),3);
    [xyzdb(:,1) xyzdb(:,2) xyzdb(:,3)]=ind2sub(size(localmask),inds_db);

    inds_hp=find(localmask==1);
    %inds_hp=find(isnan(U_crop_nii.img)==0);
    xyzhp=NaN(size(inds_hp,1),3);
    [xyzhp(:,1) xyzhp(:,2) xyzhp(:,3)]=ind2sub(size(localmask),inds_hp);

    [nn,D]=knnsearch(xyzhp,xyzdb);
    nn(D>1)=[];

    inds_nn=inds_hp(nn);
    size(inds_nn)
    xyznn=NaN(size(inds_nn,1),3);
    size(xyznn)
    [xyznn(:,1) xyznn(:,2) xyznn(:,3)]=ind2sub(size(localmask),inds_nn);
    


    inds_db_nn=inds_db;
    inds_db_nn(D>1)=[];
    xyznndb=NaN(size(inds_db_nn,1),3);
    [xyznndb(:,1) xyznndb(:,2) xyznndb(:,3)]=ind2sub(size(localmask),inds_db_nn);


    wnn=Wdb_crop_nii(inds_nn);
    udb=Udb_crop_nii(inds_nn);
    vdb=Vdb_crop_nii(inds_nn);


    
    gradW(:,1)=-gradWx(inds_nn);
    gradW(:,2)=-gradWy(inds_nn);
    gradW(:,3)=-gradWz(inds_nn);
    


    wdb=wnn+dot(gradW,xyznn-xyznndb,2);
    

    
    Wdb_crop_nii(inds_db_nn)=wdb;
    Udb_crop_nii(inds_db_nn)=udb;
    Vdb_crop_nii(inds_db_nn)=vdb;
    
    %localmask(inds_db_nn)=1;
    clear gradW
    [gradWy, gradWx, gradWz] = grad_nonan(Wdb_crop_nii);
    mask_gx=isnan(gradWx)==0;
    mask_gy=isnan(gradWy)==0;
    mask_gz=isnan(gradWz)==0;
     
     grand_mask=mask_gx.*mask_gy.*mask_gz;
     
     localmask(localmask==1)=0;
     localmask(grand_mask==1)=1;
     
     after=size(find(localmask==2));
     
     
     if(before==after)
         break;
     end
     counter=counter+1;
     if(counter>0)
        break;
    end
    
     
end
    
Wdb_crop_nii(grand_mask_for_later==1)=W_crop_nii.img(grand_mask_for_later==1);
Wdb_crop_nii=make_nii(Wdb_crop_nii);
Wdb_crop_nii.hdr=W_crop_nii.hdr;

Udb_crop_nii(grand_mask_for_later==1)=U_crop_nii.img(grand_mask_for_later==1);
Udb_crop_nii=make_nii(Udb_crop_nii);
Udb_crop_nii.hdr=U_crop_nii.hdr;

Vdb_crop_nii(grand_mask_for_later==1)=V_crop_nii.img(grand_mask_for_later==1);
Vdb_crop_nii=make_nii(Vdb_crop_nii);
Vdb_crop_nii.hdr=V_crop_nii.hdr;

end


function D2=distfun(ZI,ZJ)
    ZI=repmat(ZI,size(ZJ,1),1);
    diff=ZI-ZJ;
    D2=dot(diff,diff,2);
    D2(D2>1)=NaN;
end
    


