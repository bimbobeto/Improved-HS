function [Best] = FindBest(H)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global Harmonies; global Vars;

Best=1;
    for B=2:Harmonies
        if(H(B,Vars+2)<H(Best,Vars+2))
            Best=B;
        else
            if(H(B,Vars+2)==H(Best,Vars+2))
                if(H(B,Vars+1)<H(Best,Vars+1))
                    Best=B;
                end
            end
        end
    end
end

