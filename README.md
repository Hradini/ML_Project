# Machine Learning Project
### Classifying *Escherichia coli* mutants from phase contrast images using machine learning

The aim of our project is to classify *E.coli* cells from phase contrast images based on shape features. For this purpose, machine learning can be useful in two places:

- To segment the images and to separate out individual cells even when they are closely clumped together.
- To classify cells based on shape

#### Image processing steps
- lif_to_tif.ijm <br>
This is a Fiji macro. It will convert images from .lif format to .tif format. 
- cellboundary.ijm <br>
This is a Fiji macro. It thresholds the images, generates binary masks, finds boundary of connected regions in masks. Boundaries saved as RoiSets (.zip), binary masks saved as .tif files.
- cropinto512.ijm <br>
This is a Fiji macro. It will generate crops of size 512x512 from larger images. It needs input images and RoiSet with the relevant crops.
- 3labelMasks.ijm <br>
This is a Fiji macro. Given the image and the relevant RoiSet of the cells, it will generate a mask where the background is black, cell boundary is yellow and cell interior is white
- ChangingLabels.ipynb <br>
This is a Google Colab notebook. Given masks with colour labels (white, black, yellow) converts to masks with labels as integers (0,1,2)

More information about the project [here](http://www.niser.ac.in/~smishra/teach/cs460/project20/group24/)
