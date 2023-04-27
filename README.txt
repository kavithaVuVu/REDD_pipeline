Spring 2023 Senior Design Project README

The Removal of Extraneous Data and Denoising Pipeline is a shell script run on HiPerGator with both Python and Matlab scripts embedded. The data used in this project was provided by our advisor, Dr. Matthew Schiefer.

The Denoising pipeline was adapted and modified from Pierrick Coupe DWIDenoising Software. Please cite his work when using this pipeline for educational or professional purposes: https://sites.google.com/site/pierrickcoupe/softwares/denoising/dwi-denoising/dwi-denoising-software 
The Removal of Extraneous was written solely by the Senior Project Group. Please note the package download from Pierrick Coupe was modified to fit our needs. The Mac version of the denoising algorithm was removed but can be retrieved from the link above.

The Denoising script, titled MainDenoising.m, is located in the DWIDenoisingPackage_r01_pcode directory. Thus, it's path is REDD_Pipeline/DWIDenoisingPackage_r01_pcode. Before running the script, make sure to identify the full path for input and output in both the Denoising and Removal of Extraneous data code.

The code to run the pipeline is as follows:

./REDD.sh

The script will prompt a user input. Please provide the folder in which the mask and fMRI image are located. Please note that the files should clearly end in *fMRI or *Mask in order for the script to recognize the files.

The script will output statistics as well as a final Nifti file. The file can be viewed on Matlab. For the purpose of our project, the file was viewed on Matlab via UFApps.

NOTE: There is a Nextflow version of the shell script available in this package. While we were not able to make this work, the code has been provided for future researchers to attempt it as well.


Sample input and output has been provided for testing. The sample input is folder 748_50Hz and the sample output is masked_V3_1_denoised_748_50Hz.nii. Use these files to test run the pipeline before making any edits. The files have been uploaded using Git LFS due to their large size. Please refer to further documentation for retrieval of the sample input and output.
