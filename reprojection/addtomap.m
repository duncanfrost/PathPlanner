function [ Map ] = addtomap(Pose1,Pose2,Measurements1,Measurements2,Map,K)

for i = 1:size(Measurements1,2)
    p = Measurements1{i}.p;
    if (Map{p}.assigned == false)
        for j = 1 : size(Measurements2,2)
            if (Measurements2{j}.p == p)
                
                P1 = K*Pose1(1:3,:);
                P2 = K*Pose2(1:3,:);
                
                match1 = Measurements1{i}.position;
                match2 = Measurements2{j}.position;
                
                
                X = linearreproject(match1, match2, P1, P2);
                Map{p}.position = X(1:3)';
                Map{p}.ispoint = 1;
                Map{p}.assigned = true;
                
                
                if (norm(Map{p}.position - Map{p}.gt) > 0.1)
                    display('Problem');
                end
                
                
                
            end
            
        end
    end
end

    



end

