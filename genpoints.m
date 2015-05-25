function [ points ] = genpoints(path, nPointsPerKF)
%GENPOINTS Generates the map points around the path

points = [];

nKeyFrames = size(path,1);

for i = 1:nKeyFrames
  
        mu = path(i,:);
        Sigma = [300 0 0; 0 300 0; 0 0 300];
        R = chol(Sigma);
        positions = repmat(mu,nPointsPerKF,1) + randn(nPointsPerKF,3)*R;
        
        points = [points; positions];
              
end




end

