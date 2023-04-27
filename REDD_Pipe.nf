#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.input_dir = "./Folder_782"


subdir_ch = Channel.fromPath("${params.input_dir}/*").filter { it.isDirectory() }.set { subdirs -> subdirs.each { subdir -> file("$subdir/*_aligned.nii.gz").set { images -> file("$subdir/*Mask.nii.gz").set { masks -> run_python(images, masks)}}}}
subdir_ch.setChannelName("subdir_ch")

//input_files = Channel.fromPath(params.input_dir)
params.output = 'output_files';


process run_python {
    input:
    file input_one
    file input_two

    output:
    file pythonOutput

    script:
    """
    python remove_extraneous_data_V2.py ${input_one} ${input_two} > ${pythonOutput}
    """
}

process run_gunzip {
    input:
    file input_file from "./save_images"
    
    output:
    file "${input_file.baseName}"

    script:
    """ 
    gunzip -c ${input_file} > ${input_file.baseName}
    """
}

process run_matlab {
    input:
    file input_file from run_gunzip

    output:
    file 'test_denoised.txt' into params.output

    script:
    """
    matlab -nodisplay -nosplash -nodesktop -r "addpath('/home/vudatha.ka/school/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode/');denoising_result = MainDWIDenoising('${input_file}', '/home/vudatha.ka/school/DWIDenoisingPackage_r01_pcode/DWIDenoisingPackage_r01_pcode/save_images');"
    rm './save_images/*'
    """
}

