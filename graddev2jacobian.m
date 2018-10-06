function J_out=graddev2jacobian(graddev)

J_out(1,:)=[graddev(1),graddev(4),graddev(7)];
J_out(2,:)=[graddev(2),graddev(5),graddev(8)];
J_out(3,:)=[graddev(3),graddev(6),graddev(9)];

end