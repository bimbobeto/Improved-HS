function [C] = deb(A,B)

global Vars; 
if (A(Vars+2)>0) && (B(Vars+2)>0)
        % selects lower sum of violations if both are unfeasible 
    if (A(Vars+2) > B(Vars+2))
        C=B;
    else
        C=A;
    end        
else 
    if (A(Vars+2)<=0) && (B(Vars+2)<=0)
        % selects best objective function if both are feasible
        if (A(Vars+1)>B(Vars+1))
            C=B;
        else
            C=A;
        end
    end
end       
% selects son if only father is unfeasible
if (A(Vars+2)>0 && B(Vars+2)<=0) 
    C=B;
else
    if B(Vars+2)>0 && A(Vars+2)<=0 
        C=A;
    end
end
end

