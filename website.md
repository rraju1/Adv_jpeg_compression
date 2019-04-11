## Motivation and Problem Statement

Machine learning has been ubiquitous in various fields like computer vision and speech recognition. Particularly, deep neural networks like convolution networks (CNN) have been able to reach recognition rates above human accuracy. However, despite these advancements, neural network classifiers have been found to be susceptible to so called adversarial images. These images are created by altering some pixels in the input space via an optimization algorithm so that a human cannot distinguish it from a natural image but a deep neural network will misclassify the input. This obviously has severe implications considering the rise of self-driving cars and computer vision systems being installed in industrial applications.

In this project, we are interested in the impact of JPEG compression on adverserial images to evaluate if some robustness to perturbations in the input can be achieved at cost of small performance degradation in accuracy. We will present a description of the JPEG compression algorithm and the threat model that we use to generate these adverserial images. 

## JPEG Compression Algorithm

Add JPEG math stuff here


## Adverserial images: Fast Sign Gradient Method (FGSM) Attack

We will now describe the Fast Gradient Sign Method (FGSM) attack\cite{Linear}. FGSM is an attack algorithm which takes the sign function of the gradient of the classification loss with respect to the input image and multiplies it by a scalar, $\epsilon$. 
This product is then added back to the original image to create an adversarial example. The analytical form of this attack is given as: 
