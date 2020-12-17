/*
 * Macro runs auto threshold on .tif file, saves the resultant binary mask. Runs Analyse Particles on binary mask and saves rois in .zip file.
 * Runs on Fiji 2.1.0, ImageJ 1.53c
 * Choose input folder with .tif files
 * Choose output directory for the binary masks
 * Choose output folder for .zip files with rois
 * 
 * Ensure all windows are closed before running the macro
 * 
 */
input = getDirectory("Input folder 1: .tif files");
output = getDirectory("Output folder 1: .tif files (binary masks)");
output2 = getDirectory("Output folder 2: .zip files");

list = getFileList(input);

setBatchMode(true); //speeds up processing

for (i = 0; i < lengthOf(list); i++) {
	path = input + list[i];
	open(path);
	name = File.getNameWithoutExtension(path);
	newfilename = name + "_BM";
	run("Duplicate...", " ");
	setAutoThreshold("Default"); //does autothreshold
	setOption("BlackBackground", true);
	run("Convert to Mask"); //converts to binary mask
	saveAs("Tiff", output + newfilename); // saves binary mask
	run("Analyze Particles...", "size=1-Infinity add"); //1 ensures some small debris are not considered
	roiname = name + ".zip"; //ROIs need to saved as .zip
	roiManager("Save", output2 + roiname);
	roiManager("reset"); //Need to clear roi manager in batch mode
	close("*");
}

print("Done");
