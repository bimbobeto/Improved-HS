close all; clear all; format long;
rand('twister',sum(100*clock)); % seed for random generator
global Vars; global R_accept; global R_pa; global Harmonies;
global MaxImprovisations; global Range; global Evaluations;
global Bw; global A; global R_ia;
Start=clock; 

initialize( );
for I=1:Harmonies % creates initial Harmony Memory
    for J=1:Vars
        X(I,J)=Range(J,1)+(Range(J,2)-Range(J,1))*rand(1);
    end
    [X(I,Vars+1) X(I,Vars+2)]=evaluation(X(I,1:Vars));
    Evaluations=Evaluations+1;
    %X
end
for Improvisation=1:MaxImprovisations % starts composition process
    Best=find_best(X);
    for J=1:Vars
        if (rand(1)<R_accept)
            I=randi(Harmonies);
            if (rand(1)<=R_pa)
                Bw_adj=(Range(J,2)-Range(J,1))/Improvisation^A;
                X_New(J)=X(I,J)+Bw_adj*((1+1).*rand(1)-1);
                if(X_New(J)<Range(J,1))
                    X_New(J)=2*Range(J,1)-X_New(J);
                elseif(X_New(J)>Range(J,2))
                        X_New(J)=2*Range(J,2)-X_New(J);
                end
            else
                if (rand(1)<=R_ia)
                    X_New(J)=X(Best,J);
                else
                    X_New(J)=X(I,J);
                end
            end
        else
            X_New(J)=Range(J,1)+(Range(J,2)-Range(J,1))*rand(1);
        end
    end
    [X_New(Vars+1) X_New(Vars+2)]=evaluation(X_New(1:Vars)); 
    Evaluations=Evaluations+1;
    Worst=find_worst(X);
    X(Worst,:)=deb(X(Worst,:),X_New(:));
    disp('Cycle'); disp(Improvisation);
    disp('Best'); disp(X(Best,Vars+1:Vars+2));
    X(Best,1:Vars)
end 
%disp('Final best'); disp(X(Best,:));
%disp('Evals'); disp(E   valuations);