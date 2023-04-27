#!/bin/bash

start=$SECONDS

# NOTE: This can only be run on HiPerGator!
# The user inputs name of directory that stores the image and mask

echo "Type in the name of the directory with the Nifti image and mask"
read directory
echo $directory
cd $directory

# mask and image names are extracted 

mask=$(ls *Mask.nii)
image=$(ls *fMRI.nii)
echo $directory/$image
echo $directory/$mask
cd ..

# Removal of extraneous data is performed first with image and mask as input

module load python3
python3 remove_extraneous_data_V3.py $directory/$image $directory/$mask
gunzip save_images/masked_V3_1.nii.gz

duration = $(( SECONDS - start ))
echo "It has been $duration seconds since the script was executed. Removal of extraneous data is complete."

# Denoising of image is performed with input from previous code
# Review the Removal of extranous data code comments to manipulate output file name

module load matlab
matlab -nodisplay -nosplash -nodesktop -r "addpath('<add full path to this directory>');denoising_result = MainDWIDenoising('<add name of file>', '<add full path to folder for output storage>');exit;"
matlab -nodisplay -nosplash -r "run('stats.m'); exit;"

duration = $(( SECONDS - start ))
echo "The script execution has finished. It lasted $duration seconds"
echo "The final output can be found in the current directory"
