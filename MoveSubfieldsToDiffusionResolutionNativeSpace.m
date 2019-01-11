%% have to move subfields to native diffusion space
%simplest approach is to make a domain in native space with world
%coordinates


alpha_subfields=cell(5,1);
for subfield=1:5
    subfields_nii(subfield)=load_nii(sprintf('..\\Subfields\\%s\\%s\\sub%d.nii.gz',subject,LR,subfield));
end


count=1;
for subfield=1:5
    ind_sub=find(subfields_nii(subfield).img==1);
    [ut_vox vt_vox wt_vox]=ind2sub(size(subfields_nii(1).img),ind_sub);
    x_s=NaN(size(ind_sub));
    y_s=NaN(size(ind_sub));
    z_s=NaN(size(ind_sub));
    for p=1:size(ut_vox)
        temp=World(subfields_nii(subfield),ut_vox(p),vt_vox(p),wt_vox(p));
        u_s=Fu_utvtwt(temp(1),temp(2),temp(3));
        v_s=Fv_utvtwt(temp(1),temp(2),temp(3));
        w_s=Fw_utvtwt(temp(1),temp(2),temp(3));
        x_s(p)=Fx_uvw(u_s,v_s,w_s);
        y_s(p)=Fy_uvw(u_s,v_s,w_s);
        z_s(p)=Fz_uvw(u_s,v_s,w_s);
        x_m(count)=x_s(p);
        y_m(count)=y_s(p);
        z_m(count)=z_s(p);
        s(count)=subfield;
        count=count+1;
    end
    
    [x_s y_s z_s trash]=removeNAN(x_s,y_s,z_s,z_s);
    clear trash
    scatter3(x_s,y_s,z_s);
    hold on;
    alpha_subfields{subfield}=alphaShape(x_s,y_s,z_s);
    clear ut_vox vt_vox wt_vox x_s y_s z_s u_s v_s w_s inds_sub
end


[x_m y_m z_m s]=removeNAN(x_m,y_m,z_m,s);

Fs_xyz=scatteredInterpolant(x_m',y_m',z_m',s','nearest','none');

mask_nii=load_nii(sprintf('..\\Diffusion\\%s\\anat\\Native\\Crop\\%s\\nodif_brain_mask.nii.gz',subject,LR));


sub=cell(5,1);
for subfield=1:6
    sub{subfield}=zeros(size(mask_nii.img));
end
inds_sub=find(sub{1}==0);
[x_vox y_vox z_vox]=ind2sub(size(sub{1}),inds_sub);

for p=1:size(inds_sub)
     temp=World(mask_nii,x_vox(p),y_vox(p),z_vox(p));
    if(inShape(Hippo_alpha,temp(1),temp(2),temp(3)))
        Fs_xyz(temp(1),temp(2),temp(3));
        sub{6}(x_vox(p),y_vox(p),z_vox(p))=double(Fs_xyz(temp(1),temp(2),temp(3)));
        if(isnan(sub{6}(x_vox(p),y_vox(p),z_vox(p)))~=1)
            subfield=int8(sub{6}(x_vox(p),y_vox(p),z_vox(p)));
            sub{subfield}(x_vox(p),y_vox(p),z_vox(p))=1;
        end
    end
end

for subfield=1:5
    subb=double(sub{subfield});
    sub_nii=make_nii(subb);
    sub_nii.hdr=mask_nii.original.hdr;
    save_nii(sub_nii,sprintf('..\\Diffusion\\%s\\anat\\Native\\Crop\\%s\\sub%d.nii.gz',subject,LR,subfield));
end

[vertices, label, colortable]=read_annotation('..\\label\\lh.aparc.a2009s.annot')


% colors={'red', 'blue', 'green', 'yellow', 'white'}
% figure;hold on;axis equal;
% for subfield=1:5
%     plot(alpha_subfields{subfield},'FaceColor',colors{subfield})
% end
function [x y z s]=removeNAN(x_s,y_s,z_s,s_s)
    
nans1=(isnan(x_s)==1);
nans2=(isnan(y_s)==1);
nans3=(isnan(z_s)==1);
nans4=(isnan(z_s)==1);

nans=nans1+nans2+nans3+nans4;
nans(nans==2)=1;
nans(nans==3)=1;
nans(nans==4)=1;

x=x_s;
y=y_s;
z=z_s;
s=s_s;

x(nans==1)='';
y(nans==1)='';
z(nans==1)='';
s(nans==1)='';
end