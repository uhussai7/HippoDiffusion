function [out1_nii,out2_nii, out3_nii] = MakeDomain(se,N1,N2,N3,alpha,nii,usenii)

%this function will create the "domain in world coordinates"
%for example if we want to build UVW space for some Nu Nv Nw - it will
%return mesh grid matrices with world coordinates. These can be passed to
%any scattered interpolant and we can get the required values.
%note that there are two ways to build a domain by using a reference given
%by nii (usenii=1) or by specifing all the parameters like startend
%points(se) and size of grid

if(usenii==0)
    sampling1=se(1,1):(se(1,2)-se(1,1))/(N1-1):se(1,2);
    sampling2=se(2,1):(se(2,2)-se(2,1))/(N2-1):se(2,2);
    sampling3=se(3,1):(se(3,2)-se(3,1))/(N3-1):se(3,2);

    sampling1(2)-sampling1(1)
    sampling2(2)-sampling2(1)
    sampling3(2)-sampling3(1)
    
    [out2_nii,out1_nii,out3_nii]=meshgrid(sampling2,sampling1,sampling3);

    for i=1:N1
        for j=1:N2
            for k=1:N3
                w(1)=out1_nii(i,j,k);
                w(2)=out2_nii(i,j,k);
                w(3)=out3_nii(i,j,k);
                if(inShape(alpha,w(1),w(2),w(3))==0)
                    out1_nii(i,j,k)=NaN;
                    out2_nii(i,j,k)=NaN;
                    out3_nii(i,j,k)=NaN;
                end
            end
        end
    end

    out1_nii=make_nii(out1_nii);
    out2_nii=make_nii(out2_nii);
    out3_nii=make_nii(out3_nii);

    dels1=abs(sampling1(2)-sampling1(1));
    dels2=abs(sampling2(2)-sampling2(1));
    dels3=abs(sampling3(2)-sampling3(1));
    out1_nii.hdr.dime.pixdim(2:4)=[dels1,dels2,dels3];
    out1_nii.hdr.hist.sform_code=1;
    out1_nii.hdr.hist.srow_x=[dels1,0,0,se(1,1)];
    out1_nii.hdr.hist.srow_y=[0,dels2,0,se(2,1)];
    out1_nii.hdr.hist.srow_z=[0,0,dels3,se(3,1)];

    out2_nii.hdr=out1_nii.hdr;
    out3_nii.hdr=out1_nii.hdr;
else
    sz1=size(nii.img);
    sz=sz1(1:3);
    N1=sz(1);
    N2=sz(2);
    N3=sz(3);
    out1_nii=NaN(sz);
    out2_nii=NaN(sz);
    out3_nii=NaN(sz);
    for i=1:N1
        for j=1:N2
            for k=1:N3
                w=World(nii,i,j,k);
                if(inShape(alpha,w(1),w(2),w(3))==1)
                    out1_nii(i,j,k)=w(1);
                    out2_nii(i,j,k)=w(2);
                    out3_nii(i,j,k)=w(3);
                end
            end
        end
    end
    out1_nii=make_nii(out1_nii);
    out2_nii=make_nii(out2_nii);
    out3_nii=make_nii(out3_nii);
    if(size(nii.img,4)==0)
        out1_nii.hdr=nii;
        out2_nii.hdr=nii;
        out3_nii.hdr=nii;
    else
        out1_nii.hdr=nii.hdr;
        out1_nii.hdr.dime.dim(5)=1;
        out1_nii.hdr.dime.pixdim(5)=0;
        out2_nii.hdr=out1_nii.hdr;
        out3_nii.hdr=out1_nii.hdr;
    end
end
    
end

