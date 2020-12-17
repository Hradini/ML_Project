/*
 * Macro that generates segmentation masks based on rois and original image.
 * Runs on Fiji 2.1.0, ImageJ 1.53c
 * 
 * Choose folder that has original images (.tif files).
 * Choose folder that has RoiSets (.zip files).
 * Choose folder to save the masks.
 * 
 * -> Ensure all windows are closed before running the macro.
 * -> Ensure filenames match for the corresponding RoiSet and image.
 * -> List of images that do not have a matching RoiSet will be in the log.
 * 
 * Author - Konthalapalli Hradini - Nov 2020
 */
inputTif = getDirectory("Input folder 1: .tif files");
inputRoi = getDirectory("Input folder 2: .zip files");
outputTif = getDirectory("Output folder 1: .tif files");

tifList = getFileList(inputTif);
roiList = getFileList(inputRoi); 

setBatchMode(true);

for (k = 0; k < lengthOf(tifList); k++) {
    tifPath = inputTif + tifList[k];
    roiPath = inputRoi + roiList[k];
    tifName = File.getNameWithoutExtension(tifPath);
    roiName = File.getNameWithoutExtension(roiPath);
    if( tifName != roiName){
    	print(tifName + " Matching Roi set not found");
    }
    else{
		open(tifPath);
		imgID = getImageID();
		roiManager("open", roiPath);
		selectImage(imgID);
		n = roiManager("count");
/*		for (i = 0; i < n; i++) {
			roiManager("Select", i);
			roiManager("Set Color", "gray");
		}*/
		run("From ROI Manager"); //all rois are added to overlay
		run("Create Mask"); //generates mask with bg as black and cells as white
		selectWindow("Mask");
		run("From ROI Manager");
		run("Flatten");
		out_path = outputTif + tifName + "_Label";
		selectWindow("Mask-1");
		run("Select None"); //ensuring the last selection is not saved with the mask
		selectWindow("Mask-1");
		saveAs("tiff", out_path);
		close("*");
		roiManager("reset"); // resets manager before each loop
    }
}
print("Done");
selectWindow("Log"); //makes the current window log
