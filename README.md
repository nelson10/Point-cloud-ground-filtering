# Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)
 
This repository contains tools to simulate the ground filtering process of a registered point cloud. The repository contain two filtering methods. The first method uses normal vector, and fit to plane. The second method utilizes voxel adjacency, and fit to plane. This repository contains the code to reproduce the results presented in the paper following paper:

*Diaz, Nelson, et al. "Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)," summited to International Journal of Applied Earth Observation and Geoinformation, 2021.
 
##  Introduction
 
The software allows simulating the ground filtering process in point clouds using machine learning techniques. In particular, this repository contains the algorithms and functions to identify points corresponding to the ground from a registered point cloud.
 
 ##  Requirements
 
This module requires the following datasets Ajaccio_2.ply, Ajaccio_57.ply y dijon_9.ply, which may be downloaded from the following [link](https://cloud.mines-paristech.fr/index.php/s/JhIxgyt0ALgRZ1O?path=%2Ftest_10_classes). In addition, scans with groundtruth are available in [link](https://cloud.mines-paristech.fr/index.php/s/JhIxgyt0ALgRZ1O?path=%2Ftraining_10_classes).

The datasets may be included in the folder dataset.
 
 * Recommended modules
 
It is recommended to install the toolbox of Computer Vision (TCV). TCV contains the point cloud processing with plenty of functions and algorithms for the processing of point clouds.
 
 ##  Installation
 
To run the code, use the function MainNormal.m that computes principal component analysis for each point and its corresponding K-nearest neighbors, then a Naive Bayes classifier improves the ground filtering.  In the last stage, the points are adjusted to a plane, discarding the farthest points. The second algorithm runs with the function MainVoxel.m
 
 ##  Configuration

 The tools are developed in Matlab R2020b.
