N=6;

theta=pi*(-1/2:1/(N-1):1/2);
phi=2*pi*(-1:1/(N-1):1);
radius=(0.05:0.9/(N-1):1);

k=1;
for t=1:N
    for p=1:N
        for r=1:N
            theta_l(k)=theta(t);
            phi_l(k)=phi(p);
            r_l(k)=radius(r);
            k=k+1;
        end
    end
end

[x, y, z]= sph2cart(phi_l,theta_l,r_l);

for f=1:9
    fid=fopen(sprintf('snap%d.txt',f),'r');
    A=fscanf(fid,'%f %f %f')
    fid2=fopen(sprintf('snap%d_sphere.txt',f),'w');
    for k=1:N*N*N
        fprintf(fid2,'%f %f %f\n',A(1)+x(k),A(2)+y(k),A(3)+z(k));
    end
    fclose(fid2);
end