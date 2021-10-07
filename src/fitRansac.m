function [remainPtCloud,plane] = fitRansac(ptCloud)
maxDistance = 0.02;
referenceVector = [0,0,1];
maxAngularDistance = 5;
%ptCloudOut = select(ptCloud,id);
%referenceVector = mean(ptCloud.Location(gr,:),1);
[model1,inlierIndices,outlierIndices] = pcfitplane(ptCloud,...
            maxDistance,referenceVector,maxAngularDistance);
plane = select(ptCloud,inlierIndices);
remainPtCloud = select(ptCloud,outlierIndices);
end