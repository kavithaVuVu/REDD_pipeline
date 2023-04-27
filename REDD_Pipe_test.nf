#!/usr/bin/env nextflow

params.input_dir = "./Folder_782"

channelOne = Channel.fromPath("${params.input_dir}/**/*").filter { it.isFile() && it.name.endsWith('_aligned.nii.gz') }

channelTwo = Channel.fromPath("${params.input_dir}/**/*").filter {it.isFile() && it.name.endsWith('Mask.nii.gz') }

params.output = 'output_files'

process run_python {
    //input:
    //file image from 'home/vudatha.ka/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode/9202_0.nii'
    //file mask from 'home/vudatha.ka/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode/20HzMask.nii'

    output:
    file pythonOutput

    script:
    """
    python /home/vudatha.ka/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode/remove_extraneous_data_V2.py '9202.nii' '20HzMask.nii' > ${pythonOutput}
    """
}



process run_matlab {
    input:
    file uncompressed_file from './save_images'
    //file input from run_python.pythonOutput

    output:
    file 'test_denoised.txt' into params.output

    script:
    """
    matlab -nodisplay -nosplash -nodesktop -r "addpath('/home/vudatha.ka/school/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode/');denoising_result = MainDWIDenoising('${uncompressed_file}', '/home/vudatha.ka/school/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode');" 
    rm './save_images/*
    echo 'I am saying hello here!' > 'test_denoised.txt'
    """
}

//run_python()

