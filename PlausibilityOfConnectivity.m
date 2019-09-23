for sub=1:5
    P(sub,:)=sum(M(Msub_minmax(sub,1):Msub_minmax(sub,2),:),1);
end

figure;hold on;
for sub=1:1
   plot(P(sub,:));
end

for sub=1:5
    for sub1=1:5
        Pp(sub,sub1)=sum(P(sub,Msub_minmax(sub1,1):Msub_minmax(sub1,2)),2);
    end
end

