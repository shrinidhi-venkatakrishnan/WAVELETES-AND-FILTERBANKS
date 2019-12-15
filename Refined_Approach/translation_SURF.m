function  average_translation = translation_SURF(image, template)
disp('Here')

pts_template = detectSURFFeatures(template);
pts_image = detectSURFFeatures(image);


[features_image,validPts_image] = extractFeatures(image,pts_image);
[features_template,validPts_template] = extractFeatures(template,pts_template);

index_pairs = matchFeatures(features_image,features_template);

matched_image = validPts_image(index_pairs(:,1));
matched_template = validPts_template(index_pairs(:,2));


image_location = matched_image.Location;
template_location = matched_template.Location; 
disp(template_location)
disp(image_location)
average_translation = (mean(image_location-template_location));