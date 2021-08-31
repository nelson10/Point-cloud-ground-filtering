# Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)
 
This repository contains tools to simulate the ground filtering process of a registered point cloud using Principal Component Analysis (PCA) and adjustment to a plane. This repository contains the code to reproduce the results presented in the paper following paper:

*Diaz, Nelson, et al. "Real-time ground filtering algorithm of cloud points acquired using Terrestrial Laser Scanner (TLS)," summited to International Journal of Applied Earth Observation and Geoinformation, 2021.
 
##  Introduction
 
The software allows simulating the ground filtering process in point clouds using machine learning techniques. In particular, this repository contains the algorithms and functions to identify points corresponding to the ground from a registered point cloud.
 
 ##  Requirements
 
This module requires the following datasets Ajaccio_2.ply, Ajaccio_57.ply y dijon_9.ply, which may be download from the following [link](https://cloud.mines-paristech.fr/index.php/s/JhIxgyt0ALgRZ1O?path=%2Ftest_10_classes)

The datasets may be included in the folder dataset.
 
 * Recommended modules
 
It is recommended to install the toolbox of Computer Vision (TCV). TCV contains the point cloud processing with plenty of functions and algorithms for the processing of point clouds.
 
 ##  Installation
 
To run the code, use the function Main.m that performs the PCA for each point and its corresponding K-nearest neighbors, then a Naive Bayes classifier improves the ground filtering.  In the last stage, the points are adjusted to a plane, discarding the farthest points.
 
 ##  Configuration

 The tools are developed in Matlab R2019b.
