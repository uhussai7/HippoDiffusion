%% these interpolants are straight forward
Fu_xyz=scatteredInterpolant(x,y,z,u,'linear','none');
Fv_xyz=scatteredInterpolant(x,y,z,v,'linear','none');
Fw_xyz=scatteredInterpolant(x,y,z,w,'linear','none');

Fx_uvw=scatteredInterpolant(u,v,w,x,'linear','none');
Fy_uvw=scatteredInterpolant(u,v,w,y,'linear','none');
Fz_uvw=scatteredInterpolant(u,v,w,z,'linear','none');

%% the tilde space needs gridding

Nu=50;
Nv=50;
Nw=50;
[Xuvw_nii,Yuvw_nii,Zuvw_nii]=InvertSpacesSI(x,y,z,u,v,w,[min(u),min(v),min(w)],[max(u),max(v),max(w)],Nu,Nv,Nw);
for i=1:size(Xuvw_nii.img,1)
    for j=1:size(Xuvw_nii.img,2)
        for k=1:size(Xuvw_nii.img,3)
            temp=World(Xuvw_nii,i,j,k);
            if(inShape(uvw_alpha,temp(1),temp(2),temp(3))==0)
                Xuvw_nii.img(i,j,k)=NaN;
                Yuvw_nii.img(i,j,k)=NaN;
                Zuvw_nii.img(i,j,k)=NaN;
            end
        end
    end
end
[Utuvw_nii,Vtuvw_nii,Wtuvw_nii]=CreateSmoothDistanceMaps(Xuvw_nii,Yuvw_nii,Zuvw_nii);

clear inds;
inds=find(isnan(Xuvw_nii.img)==0);
ut=Utuvw_nii.img(inds);
vt=Vtuvw_nii.img(inds);
wt=Wtuvw_nii.img(inds);
[u_ v_ w_]=ind2sub(size(Xuvw_nii.img),inds);
for p=1:size(u_,1);
    temp=World(Xuvw_nii,u_(p),v_(p),w_(p));
    u_(p)=temp(1);
    v_(p)=temp(2);
    w_(p)=temp(3);
end
utvtwt_alpha=alphaShape(ut,vt,wt,'HoleThreshold',10000000);
utvtwt_alpha.Alpha=1.5;

Fut_uvw=scatteredInterpolant(u_,v_,w_,ut,'linear','linear');
Fvt_uvw=scatteredInterpolant(u_,v_,w_,vt,'linear','linear');
Fwt_uvw=scatteredInterpolant(u_,v_,w_,wt,'linear','linear');


Fu_utvtwt=scatteredInterpolant(ut,vt,wt,u_,'linear','linear');
Fv_utvtwt=scatteredInterpolant(ut,vt,wt,v_,'linear','linear');
Fw_utvtwt=scatteredInterpolant(ut,vt,wt,w_,'linear','linear');
