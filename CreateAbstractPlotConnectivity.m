subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
iter=1
titer=0
for iii=1:4
    for jjj=1:2
        subject=subjects(iii)
        LR=LRs(jjj)
        load(sprintf('..\\Probtrackx\\%s_%s\\data.mat',subject,LR));
        subplot(2,4,iii+(jjj-1)*4)
        imagesc(Msub)
        axis equal;
        set(gca,'xtick',[])
        set(gca,'ytick',[])

        text(-.5,1,"CA4")
        text(-.5,2,"CA3")
        text(-.5,3,"CA2")
        text(-.5,4,"CA1")
        text(-.5,5,"SUB")

        text(1,5.75,"CA4",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(2,5.75,"CA3",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(3,5.75,"CA2",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(4,5.75,"CA1",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(5,5.75,"SUB",'HorizontalAlignment','center','VerticalAlignment','middle');
        
        %clearvars -except iii jjj subjects LRs 
        

    end
end
