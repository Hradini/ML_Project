/*
 * Macro that coverts .lif files into individual .tif files
 * Choose input folder with .lif files
 * Choose output folder for .tif files
 * Here the filename takes up the input foldername as well
 * 
 * Author : Konthalapalli Hradini - October 2020
 */
input = getDirectory("Input folder 1: .lif files");
output = getDirectory("Output folder 1: .tif files");
foldername = File.getName(input);

setBatchMode(true);

list = getFileList(input); // gets list of all files in given input folder


for (i = 0; i < lengthOf(list); i++) {
    path = input + list[i];
    run("Bio-Formats Macro Extensions");
	Ext.setId(path);
	Ext.getCurrentFile(file);
	Ext.getSeriesCount(seriesCount);
    for (s=1; s<=seriesCount; s++) {
		// Bio-Formats Importer uses an argument that can be built by concatenate a set of strings
		run("Bio-Formats Importer", "open=&path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_"+s);
		title = getTitle();
		name = replace(title, "\\.lif", "");
//		filename = foldername + "_" + name;
		out_path = output + name + ".tif";
		saveAs("tiff", out_path);
		close();
    }
}

    
