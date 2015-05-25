function [ Points ] = genpoints2(path, nPointsPerKF)
%GENPOINTS Generates the map points around the path


nKeyFrames = size(path,1);

for i = 1:nKeyFrames
   
  
        mu = path(i,:);
        Sigma = [5 0 0; 0 5 0; 0 0 5];
        R = chol(Sigma);
        Points{i}.positions = repmat(mu,nPointsPerKF,1) + randn(nPointsPerKF,3)*R;
        Points{i}.indices = (i-1)*nPointsPerKF + 1: (i-1)*nPointsPerKF + nPointsPerKF;
        Points{i}.ispoint = ones(nPointsPerKF,1);
         
end




end

