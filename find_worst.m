function [Worst] = find_worst(H)
% Finds the worst value in a population, considering both
% the value of the objective function and the sum of constraint 
% violations

global Harmonies;
global Vars;
Worst=1;
    for B=2:Harmonies
        if(H(B,Vars+2)>H(Worst,Vars+2))
            Worst=B;
        else
            if(H(B,Vars+2)==H(Worst,Vars+2))
                if(H(B,Vars+1)>H(Worst,Vars+1))
                    Worst=B;
                end
            end
        end
    end
end