function smoo3_out=smoo3_db(distance,ker3,sz_x,sz_y,sz_z)
%This function smooths "distance". Note that at it accounts for NaN in that
%it avoids voxels with NaN and renormalizes the kernel accordingly.

I_pad=padarray(distance,[floor(sz_x/2) floor(sz_y/2) floor(sz_z/2)],NaN);
col_I_pad=im2col3(I_pad,[sz_x,sz_y,sz_z]);

sz_col=size(col_I_pad);

h=ker3(:);

for m=1:sz_col(2)
    renorm=0;
    pixvalue=0;
    for s=1:size(h)
        if(isnan(col_I_pad(s,m))~=1)
            renorm=renorm+h(s);
            pixvalue=pixvalue+col_I_pad(s,m)*h(s);
        end
    end
    smoo3_col(1,m)=pixvalue/renorm;
end

sz_I=size(distance);
col_i=1;

for k=1:sz_I(3)
    for i=1:sz_I(1)
        for j=1:sz_I(2)
            smoo3_out(i,j,k)=smoo3_col(1,col_i);
            col_i=col_i+1;
        end
    end
end


end
