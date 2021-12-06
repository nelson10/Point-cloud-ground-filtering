# Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)
 
This repository contains tools to simulate the ground filtering process of a registered point cloud. The repository contain two filtering methods. The first method uses normal-vector, and fit to plane. The second method utilizes voxel adjacency, and fit to plane. This repository contains the code to reproduce the results presented in the paper following paper:

*Diaz, Nelson, et al. "Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)," Accepted to International Journal of Applied Earth Observation and Geoinformation, 2021.

If you use this code, please consider citing our paper with the following Bibtex code:

```
@article{DIAZ2021102629,
title = {Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)},
journal = {International Journal of Applied Earth Observation and Geoinformation},
volume = {105},
pages = {102629},
year = {2021},
issn = {0303-2434},
doi = {https://doi.org/10.1016/j.jag.2021.102629},
url = {https://www.sciencedirect.com/science/article/pii/S0303243421003366},
author = {Nelson Diaz and Omar Gallo and Jhon Caceres and Hernan Porras},
keywords = {Ground filter, Normal vector, PCA, TLS, Voxel},
abstract = {3D modeling based on point clouds requires ground-filtering algorithms that separate ground from non-ground objects. This study presents two ground filtering algorithms. The first one is based on normal vectors. It has two variants depending on the procedure to compute the k-nearest neighbors. The second algorithm is based on transforming the cloud points into a voxel structure. To evaluate them, the two algorithms are compared according to their execution time, effectiveness and efficiency. Results show that the ground filtering algorithm based on the voxel structure is faster in terms of execution time, effectiveness, and efficiency than the normal vector ground filtering.}
}
```
 
##  Introduction
 
The software allows simulating the ground filtering process in point clouds using machine learning techniques. In particular, this repository contains the algorithms and functions to identify points corresponding to the ground from a registered point cloud.
 
 ##  Requirements
 
This module requires the following datasets Ajaccio_2.ply, Ajaccio_57.ply y dijon_9.ply, which may be downloaded from the following [link](https://cloud.mines-paristech.fr/index.php/s/JhIxgyt0ALgRZ1O?path=%2Ftest_10_classes). In addition, scans with groundtruth are available in [link](https://cloud.mines-paristech.fr/index.php/s/JhIxgyt0ALgRZ1O?path=%2Ftraining_10_classes). The password for both links is Paris-Lille-3D.

The datasets may be included in the folder dataset.
 
 * Recommended modules
 
It is recommended to install the toolbox of Computer Vision (TCV). TCV contains the point cloud processing with plenty of functions and algorithms for the processing of point clouds.
 
 ##  Installation
 
To run the code, use the function MainNormal.m that computes principal component analysis for each point and its corresponding K-nearest neighbors, then a Naive Bayes classifier improves the ground filtering.  In the last stage, the points are adjusted to a plane, discarding the farthest points. The second algorithm runs with the function MainVoxel.m that.  The algorithm joints the points into voxels to reduce the computation time of the nearest neighbor. The algorithm discards the distant voxels with height thresholding, and then the remaining points are adjusted to a plane.
 
 ##  Configuration

 The tools are developed in Matlab R2019b.
