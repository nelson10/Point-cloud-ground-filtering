function [] = plotVoxels(ptCloud1,g)

    %g = boolean(g);
    figure(2)
    pcshow(ptCloud1.Location(g==0,:),[1 0 0])
    hold on;
    pcshow(ptCloud1.Location(g==1,:),[0 0 1])
    hold on;
    pcshow(ptCloud1.Location(g==2,:),[0 1 0])
        hold on;
    pcshow(ptCloud1.Location(g==3,:),[0 1 1])
end