function [dyE,dxE,dzE] = grad_nonan(E)
%LRX Summary of this function goes here
%   Detailed explanation goes here
sz_E=size(E);
dxEr=zeros(sz_E);
dxEr(:)=NaN;
dxEl=dxEr;
dxE=dxEr;
dyEr=dxEr;
dyEl=dxEl;
dyE=dxEr;
dzEr=dxEr;
dzEl=dxEr;
dzE=dxEr;


for x=1:sz_E(1)
    for y=1:sz_E(2)
        for z=1:sz_E(3)
            if(x+1<=sz_E(1))
                dxEr(x,y,z)=E(x+1,y,z)-E(x,y,z);
            end
            if(x-1>=1)
                dxEl(x,y,z)=E(x,y,z)-E(x-1,y,z);
            end
             if(y+1<=sz_E(2))
                dyEr(x,y,z)=E(x,y+1,z)-E(x,y,z);
            end
            if(y-1>=1)
                dyEl(x,y,z)=E(x,y,z)-E(x,y-1,z);
            end
             if(z+1<=sz_E(3))
                dzEr(x,y,z)=E(x,y,z+1)-E(x,y,z);
            end
            if(z-1>=1)
                dzEl(x,y,z)=E(x,y,z)-E(x,y,z-1);
            end
        end
    end
end
for x=1:sz_E(1)
    for y=1:sz_E(2)
        for z=1:sz_E(3)
            dxE(x,y,z)=nanchecker(dxEr(x,y,z),dxEl(x,y,z));
            dyE(x,y,z)=nanchecker(dyEr(x,y,z),dyEl(x,y,z));
            dzE(x,y,z)=nanchecker(dzEr(x,y,z),dzEl(x,y,z));
        end
    end
end

end

function C=nanchecker(A,B)
    
    if(isnan(A)==1 & isnan(B)==1)
        C=NaN;
    elseif(isnan(A)==1 & isnan(B)~=1)
        C=B;
    elseif(isnan(A)~=1 & isnan(B)==1)
        C=A;
    elseif(isnan(A)~=1 & isnan(B)~=1)
        C=0.5*(A+B);
    end
end