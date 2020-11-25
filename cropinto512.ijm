/*
 * Macro that generates cropped images (512x512) from (2048x2048) and (1024x1024) images
 * 
 * Choose input directory with images (.tif files) that need to be cropped.
 * Choose output directory where cropped images (.tif files) will be saved.
 * 
 * From one 2048x2048 image - 16 images will be generated.
 * From one 1024x1024 image - 4 images will be generated.
 * 
 * -> Change the path for the saved ROI set with the relevant crop boundaries before running the macro.
 * -> Ensure the input folder only has images that need to be cropped.
 * -> Log will have names of files that do not meet the input size criteria
 * 
 * Author - Konthalapalli Hradini - Nov 2020
 */

//hard code the paths

//output = "E:/computer science/Machine Learning/Datasets/E.coli images/Microscopy images/Annotated Dataset/Cropped images/FtsZ mutants/";
//input = "E:/computer science/Machine Learning/Datasets/E.coli images/Microscopy images/Annotated Dataset/Images/FTsZ/";

input = getDirectory("Input folder 1: .tif files");
output = getDirectory("Output folder 1 - cropped images: .tif files");

filelist = getFileList(input); // gets list of all files in input folder


for (j = 0; j < lengthOf(filelist); j++) {
	setBatchMode(true);
    path = input + filelist[j];
    open(path);
    title = getTitle(); //gets title of the image window
    filename = replace(title, "\\.tif", "");
    ht = getHeight(); //gets height of the image to decide which RoiSet to use
	//opens the relevant RoiSets
    if (ht == 2048) {
		roiManager("Open", "E:/computer science/Machine Learning/Datasets/E.coli images/Testing cropping macro/RoiSet_2048.zip");
	}
	else if (ht == 1024) {
		roiManager("open", "E:/computer science/Machine Learning/Datasets/E.coli images/Testing cropping macro/RoiSet_1024.zip");
	}
	else {
		print(title); // prints name of files that do not meet the input size requirements
	}
	
	count = roiManager("count"); // number of rois in the manager

	for (i = 0; i < count; i++) {
		name = filename + "_" + (i+1); //adds the number of crop to the name 
		out_path = output + name;
		selectWindow(filelist[j]);
		roiManager("Select", i);
		run("Duplicate...", "title=dup"); // generates a duplicate of the selected region
		selectWindow("dup");
		saveAs("PNG", out_path); // saves duplicate
		close();
	}
	close("*");
	roiManager("reset"); // resets manager before each loop

}
print('Done');
selectWindow("Log"); //makes the current window log




