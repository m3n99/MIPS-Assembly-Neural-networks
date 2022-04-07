# MIPS-Assembly-Neural-networks

Background:
Neural networks operate in a manner inspired by the natural neural network in the brain. The objective of such artificial neural networks is to perform such cognitive functions as problem solving and machine learning. Training neural networks requires large dataset and high computational resources. In order to reduce time of learning we need to implement the training algorithm using assembly language.

Project Description:
Implement the learning algorithm of single layer neural networks (Perceptron) with momentum and adaptive learning rates using MIPS assembly language. The program will ask the user to enter the name of the training file and the initial values of the parameters (weights, momentum, learning rate, thresholds, number of epochs…). The program must print the value of the error, weights, thresholds, and learning rate after each iteration.
Notes:
• The structure of the training file must be CSV structure (comma separated file).
• The first row of the training file contains the number of features.
• The values of the features must be numeric only. • The second line contains the number of classes.
• The last field of each training sample represent the class or the label. 
• The program will determine the number of input neurons and output neurons dynamically from the training file.
• Your code must be written using procedures.
