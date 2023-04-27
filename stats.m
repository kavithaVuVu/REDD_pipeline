original_nifti = niftiread('save_images/test_masked_1.nii')
denoised_nifti_once = niftiread('test_masked_1_denoised.nii')


A = double(original_nifti)
B = double(denoised_nifti_once)


A = 255 * (A - min(A(:))) / (max(A(:)) - min(A(:)))
B = 255 * (B - min(B(:))) / (max(B(:)) - min(B(:)))

A = (A - min(A(:))) / (max(A(:)) - min(A(:)));
B = (B - min(B(:))) / (max(B(:)) - min(B(:)));

PSNR = psnr(A, B)
fprintf('PSNR = %.2f dB\n', PSNR)

if PSNR < 28.492
    disp('This PSNR value of %.2f dB indicates high levels of noise remain after denoising. An additional round of denoising is needed.', PSNR)
end
    

% Check that the files have the same dimensions
assert(all(size(original_nifti) == size(denoised_nifti_once)), 'Files must have the same dimensions.');

% Compute SSIM for each pair of corresponding 3D volumes
ssim_vals = zeros(size(original_nifti, 4), 1);
for t = 1:size(original_nifti, 4)
    img1 = original_nifti(:, :, :, t);
    img2 = denoised_nifti_once(:, :, :, t);
    ssim_vals(t) = ssim(img1, img2);
end

%parfor (loopVar ...

% Average SSIM over time dimension
mean_ssim = mean(ssim_vals);


disp(['SSIM between original and denoised data: ', num2str(mean_ssim)]);
if mean_ssim < 0.90
    disp('This ssim value indicates that the denoised images lacks structural similarity to the original image. Thus, a reevaluation of the denoising parameters is needed.')
end

