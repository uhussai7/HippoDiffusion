function [final_grad_dev_nii, not_final_distortion_nii, not_final_distortion_scalar_nii,not_final_distortion_scalar_diag_nii] = FinalizeGradDevAndDistortion(grad_dev1_nii,grad_dev2_nii,grad_dev3_nii,num)
%the aim of this function is to finalize the grad dev file that is needed
%for this particular space and domain
%we have to be careful of the order in which the grad devs get multiplied
%as these are jacobians and order matters ABC -> (A,B,C) in the arguments
%above,i.e., left most argument goes to the left when multiplying
%num is the number of grad dev's to be combined, for e.g., tilde space will
%have num=3
%make sure you subtract out the shear part and keep only the rotation part
%make sure you subtract the identity for the final graddev matrix as this
%is the standard used by all the code (AFAIK)

final_grad_dev_nii=grad_dev1_nii;
not_final_distortion_nii=grad_dev1_nii;
not_final_distortion_scalar_nii=grad_dev1_nii;
not_final_distortion_scalar_diag_nii=grad_dev1_nii;
sz=size(grad_dev1_nii.img);

if(num==2)
    for i=1:sz(1)
        for j=1:sz(2)
            for k=1:sz(3)
                gd_temp(:)=grad_dev1_nii.img(i,j,k,:);
                J1=graddev2jacobian(gd_temp);
                gd_temp(:)=grad_dev2_nii.img(i,j,k,:);
                J2=graddev2jacobian(gd_temp);
                J1J2=J1*J2;
                gd_temp=jacobian2graddev(J1J2);
                final_grad_dev_nii.img(i,j,k,:)=gd_temp(:);
            end
        end
    end
end

if(num==3)
    for i=1:sz(1)
        for j=1:sz(2)
            for k=1:sz(3)
                gd_temp(:)=grad_dev1_nii.img(i,j,k,:);
                J1=graddev2jacobian(gd_temp);
                gd_temp(:)=grad_dev2_nii.img(i,j,k,:);
                J2=graddev2jacobian(gd_temp);
                gd_temp(:)=grad_dev3_nii.img(i,j,k,:);
                J3=graddev2jacobian(gd_temp);
                J1J2J3=J1*J2*J3;
                gd_temp=jacobian2graddev(J1J2J3);
                final_grad_dev_nii.img(i,j,k,:)=gd_temp(:);
            end
        end
    end
end



%get rid of shear part and subtract identity
for i=1:sz(1)
    for j=1:sz(2)
        for k=1:sz(3)
            gd_temp(:)=final_grad_dev_nii.img(i,j,k,:);
            J_temp=graddev2jacobian(gd_temp);
            det_temp=det(J_temp);
            if(isnan(det_temp)~=1 && det_temp~=0)
                [R U V]=poldecomp(J_temp);
                J_temp=R-eye(3);
                U_temp=U;
                [delete, U_diag_temp]=eig(U_temp);
            else
                J_temp=NaN(3,3);
                U_temp=NaN(3,3);
                U_diag_temp=NaN(3,3);
            end
            gd_temp=jacobian2graddev(J_temp);
            u_temp=jacobian2graddev(U_temp);
            u_diag_temp=jacobian2graddev(U_diag_temp);
            final_grad_dev_nii.img(i,j,k,:)=gd_temp(:);
            not_final_distortion_nii.img(i,j,k,:)=u_temp(:);
            [scalar(1),scalar(2)]=distortionScalar(u_temp);
            not_final_distortion_scalar_nii.img(i,j,k,1)=scalar(1);
            not_final_distortion_scalar_nii.img(i,j,k,2)=scalar(2);
            [scalar(1),scalar(2)]=distortionScalar(u_diag_temp);
            not_final_distortion_scalar_diag_nii.img(i,j,k,1)=scalar(1);
        end
    end
end


end

function [s1 ,s2]=distortionScalar(dist)
    s1=sqrt((dist(1)-dist(5))^2+(dist(1)-dist(9))^2+(dist(9)-dist(5))^2)/3;
    dist=abs(dist);
    s2=(dist(2)+dist(3)+dist(4)+dist(6)+dist(7)+dist(8))/6;
end

function J_out=graddev2jacobian(graddev)

J_out(1,:)=[graddev(1),graddev(4),graddev(7)];
J_out(2,:)=[graddev(2),graddev(5),graddev(8)];
J_out(3,:)=[graddev(3),graddev(6),graddev(9)];

end

function gd_out=jacobian2graddev(J)

gd_out(1)=J(1,1);
gd_out(2)=J(2,1);
gd_out(3)=J(3,1);
gd_out(4)=J(1,2);
gd_out(5)=J(2,2);
gd_out(6)=J(3,2);
gd_out(7)=J(1,3);
gd_out(8)=J(2,3);
gd_out(9)=J(3,3);

end