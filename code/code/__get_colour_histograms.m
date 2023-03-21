function output = get_colour_histograms_1(image_paths, quant)
%GET_COLOUR_HISTOGRAMS 

    rows                            = size(image_paths, 1);
    output                          = zeros(rows, quant^3);
    
    parfor i = 1:rows
        img                         = imread(image_paths{i});

        % Quantise the image
        norm_img                    = double(img)/255;
        quant_img                   = round(norm_img*(quant-1)) + 1;
        
        % reshape the image into a col vector with 3 channels 
        quant_img_to_vect           = reshape(quant_img, [],1,3);

        % init a zero filled 3D matrix of dimension quant
        hist_out                    = zeros(quant, quant, quant);
        for j = 1:size(quant_img_to_vect)
            red                     = quant_img_to_vect(j,:,1);
            green                   = quant_img_to_vect(j,:,2);
            blue                    = quant_img_to_vect(j,:,3);
            hist_out(red,green,blue)= hist_out(red,green,blue) +1;
        end
        
        output(i,:)                 = reshape(hist_out, 1,[]);
    end
end