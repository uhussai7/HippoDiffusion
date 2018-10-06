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