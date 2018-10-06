function xyz = World(nii,i,j,k)
indices=[i-1;j-1;k-1;1]; %the -1 is there because matalb indices start at 1 ~everyone else is 0
sform=zeros(4,4);
sform(1,:)=nii.hdr.hist.srow_x;
sform(2,:)=nii.hdr.hist.srow_y;
sform(3,:)=nii.hdr.hist.srow_z;
sform(4,:)=[0,0,0,1];
xyz=sform*double(indices);
end

