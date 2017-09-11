function [Selected] = selection(H1,H2)
% Selects best harmony
global Vars;

if (H1(Vars+1)<H2(Vars+1))
    Selected=H1;
else
    Selected=H2;
end
end