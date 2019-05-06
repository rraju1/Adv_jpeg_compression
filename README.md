CS766 Final Project
Ravi Raju(rraju2), Stephen Dennison(srdennison), Heng Zhuo(hzhuo2)

This is our repo for JPEG Compression for Adverserial ML

In order to run our project, the user needs to setup Pytorch with the anaconda environment. The FOolbox package will also need to be installed via pip to run the FGSM attack.
The ML part of this work was done in Jupyter notebook and the compression algorithm was generated in Matlab.
To begin, run cells 1-7 to set up the model and training the neural network. 
To run the attack on our model and reproduce the attack plot, run cells 8-10.

Next, we want to see the effect that compression has on the network. So, first download the MNIST and specify an appropriate path to the directory that holds the test set. Then run jpeg2.m with the specified q factor to create the compressed images saved in a .mat file.  Run cells 11-13. Then for each q value desired, rerun the Matlab script and then cells 12-13 to collect the classification accuracy. Finally run cells 14-15 for the compression plot. 

Now, we are interested in looking at compression on adverserial images. Run cells 16-18 to save the perturbed images into .mat files. Run cell 19. Run jpeg_fgsm.m for each of the q factors desired and run cell 20. Repeat this process similar to the one above until the desired accuracies have been collected. Finally to obtain the plot, run cells 21-22.
