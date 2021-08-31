A simulation tool to filter ground from the point cloud using machine learning 
 
This repository contains tools to simulate the ground filtering process of a registered point cloud using Principal Component Analysis (PCA) and adjustment to a plane. 
 
Introduction
 
The software allows simulating the ground filtering process in point clouds using machine learning techniques. In particular, this repository contains the algorithms and functions to identify points corresponding to the ground from a registered point cloud.
 
 * Requirements
 
This module requires the following datasets Ajaccio_2.ply, Ajaccio_57.ply y dijon_9.ply, which may be download from:
 
https://cloud.mines-paristech.fr/index.php/s/JhIxgyt0ALgRZ1O?path=%2Ftest_10_classes

The datasets may be included in the folder dataset.
 
 * Recommended modules
 
It is recommended to install the toolbox of Computer Vision (TCV). TCV contains the point cloud processing with plenty of functions and algorithms for the processing of point clouds.
 
 * Installation
 
To run the acquisition system that simulates the diffractive compressive measurements run the file Main.m 
which executes the sensing process and reconstruction from the compressive measurements.
 
 * Configuration

 The tools are developed in Matlab R2019b.