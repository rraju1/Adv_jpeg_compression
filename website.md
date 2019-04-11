## Motivation and Problem Statement

Machine learning has been ubiquitous in various fields like computer vision and speech recognition. Particularly, deep neural networks like convolution networks (CNN) have been able to reach recognition rates above human accuracy. However, despite these advancements, neural network classifiers have been found to be susceptible to so called adversarial images. These images are created by altering some pixels in the input space via an optimization algorithm so that a human cannot distinguish it from a natural image but a deep neural network will misclassify the input. This obviously has severe implications considering the rise of self-driving cars and computer vision systems being installed in industrial applications.

In this project, we are interested in the impact of JPEG compression on adverserial images to evaluate if some robustness to perturbations in the input can be achieved at cost of small performance degradation in accuracy. We will present a description of the JPEG compression algorithm and the threat model that we use to generate these adverserial images. 

## JPEG Compression Algorithm

Add JPEG math stuff here


## Adverserial images: Fast Sign Gradient Method (FGSM) Attack

We will now describe the Fast Gradient Sign Method (FGSM) attack. FGSM is an attack algorithm which takes the sign function of the gradient of the classification loss with respect to the input image and multiplies it by a scalar, $\epsilon$. 
This product is then added back to the original image to create an adversarial example. The analytical form of this attack is given as: 




The attack is assessing the $L_{\infty}$ distance from a legitimate example to see if the maximum distance within this threshold crosses the classification boundary and incurs a misclassification.


The adversarial example from the attack should be such that to a human observer the image visually indistingushable from a legitimate example but a classifier would mislabel it. We have conducted preliminary experiments with MNIST on standard 5-layer LeNet CNN architecture with PyTorch, with 3 conv layers and 2 fully connected layers. This network achieves 99.2\% classification accuracy on the MNIST test set. 
