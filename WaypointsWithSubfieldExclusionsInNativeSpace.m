% after doing probtrackx with exclusions i.e., take seed as sub1 and
% target as sub4 while excluding sub2 sub3 sub5. Here we just analyze the
% waypoint results

subjects=["sub-100610","sub-102311","sub-111312","sub-111514"]
LRs=['L','R']
subj=1;
figure;
for jjj=1:2
    for iii=1:4
        for seed=1:5
            for tar=seed+1:5
                subject=subjects(iii)
                LR=LRs(jjj)
                waypoint=load(sprintf('..\\hipposubjects_native_probtrackx\\%s_%s_%d%dprobtrack\\waytotal',subject,LR,seed,tar));
                avoid{subj}(seed,tar)=waypoint;
                avoid{subj}(tar,seed)=waypoint;
            end
        end
        subplot(2,4,subj);
        imagesc(avoid{subj});
        axis equal;
        axis tight;
        set(gca,'xtick',[])
        set(gca,'ytick',[])

        text(-0.5,1,"CA4")
        text(-0.5,2,"CA3")
        text(-0.5,3,"CA2")
        text(-0.5,4,"CA1")
        text(-0.5,5,"SUB")

        text(1,5.75,"CA4",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(2,5.75,"CA3",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(3,5.75,"CA2",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(4,5.75,"CA1",'HorizontalAlignment','center','VerticalAlignment','middle');
        text(5,5.75,"SUB",'HorizontalAlignment','center','VerticalAlignment','middle');
        %avoid{subj}=[avoid{subj};[0,0,0,0,0]];
        subj=subj+1;
    end
end
