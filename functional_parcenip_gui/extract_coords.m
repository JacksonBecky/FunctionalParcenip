function coords = extract_coords(roi)

image = extract_read_image(roi);

a=find(image);
[x,y,z] = ind2sub(size(image),a);

coords = [x,y,z];

end