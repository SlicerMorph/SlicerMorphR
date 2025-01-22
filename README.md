# SlicerMorphR
R convenience functions for importing SlicerMorph dataset

install via devtools

`devtools::install_github('SlicerMorph/SlicerMorphR')`


## Usage

* __read.markups.json__:  Reads the 3D Slicer Markups file saved in json format (the default format)
* __write.markups.json__: Writes a set of 3D coordinates as a pointList markup type, which can be loaded and visualized in 3D Slicer. 
* __parser2__: Reads and parses the analysis.json file output by SlicerMorph's GPA module (it will still read the analysis.log file)
* __geomorph2slicermorph__ : Allow to save a geomorph GPA and PCA analysis in SlicerMorph's GPA output LOG format, so that you can load the results into 3D Slicer to visualize (Use Slicer version 5.6.2 and lower).
* __geomorph2slicermorph2__ : Allow to save a geomorph GPA and PCA analysis in SlicerMorph's GPA output JSON format, so that you can load the results into 3D Slicer to visualize. (Use Slicer versions 5.8 or higher)

* __read.markups.fcsv__ : Reads the 3D Slicer Markups file saved in fcsv format (deprecated, do not use fcsv format)
* __write.markups.fcsv__: Writes a matrix of 3D LM coordinates in 3D Slicer's Markups format as fcsv. By default LM coordinates are written with LPS (Left-Posterior-SUperior) coordinate system header, which is default in Slicer. (deprecated, do not use fcsv format)
* __parser__ : Reads and parses the analysis.log file as output by the SlicerMorph's GPA module. (deprecated)

```
> library(SlicerMorphR)
# point out to the analysis.json file created by the SlicerMorph's GPA function. 
# you can also have it point out to older analysis.log file by setting the json=FALSE

> SM.output=parser2(file.choose(), json=TRUE)
#An example of using read.markups.fcsv() with the forceLPS parameter
#forceLPS = FALSE
> file = "https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"
> lms = read.markups.fcsv(file = file, forceLPS = FALSE) #default setting for forceLPS
#Return a 41x3 matrix that stores raw landmark coordinates from the fcsv files; rownames = labels in the FCSV file; colnames = "x", "y", "z"
> lms[1:3, ]
                             X       Y         Z
Gorilla_template_LM1-1 111.987 312.757 -148.0780
Gorilla_template_LM1-2 114.785 381.650 -128.2390
Gorilla_template_LM1-3 109.137 294.534  -97.4347

#forceLPS = TRUE
> file = "https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"
> lms = read.markups.fcsv(file = file, forceLPS = TRUE)
#Because forceLPS = TRUE, the function will read the "coordinateSystem" in the 2nd line of the fcsv to see if it is "LPS"
> x <- readLines(file, n = 2)
> x[[2]]
[1] "# CoordinateSystem = 0"
#The coordinateSystem is not "LPS", so the signs of x, y coordinates are reversed to be consistent with the LPS coordinate system.
> lms[1:3, ]
                           [,1]     [,2]      [,3]
Gorilla_template_LM1-1 -111.987 -312.757 -148.0780
Gorilla_template_LM1-2 -114.785 -381.650 -128.2390
Gorilla_template_LM1-3 -109.137 -294.534  -97.4347
```

### How to run a geomorph analysis with SlicerMorph data and get the results back into SlicerMorph for visualization

Since there is no sliding implemented in SlicerMorph, one may want to use R/geomorph to slide the semi-landmarks, and then visualize the results in SlicerMorph. This code snippet shows that use case and can be generalized for other use cases. 

Provided code will download a zip file which contains 4 gorilla skull landmarks with 41 fixed landmarks and 880 surface patch landmarks (also generated by SlicerMorph). While the code downloads the zip file, you have to manually unzip the file into that folder to proceed with the second part. Please modify the output.path variable to a valid folder in your computer. 

```R
library(SlicerMorphR)
library(geomorph)
output.path="/Users/amaga/Desktop/geomorph_example/"
if (!dir.exists(output.path)) dir.create(output.path)

download.file(url="https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla%20patch%20semi-landmarks.zip", 
              destfile = paste0(output.path, "Gorilla patch semi-landmarks.zip"))

#unzip the contents of the zip file into this folder. 

setwd(paste0(output.path, "Gorilla patch semi-landmarks/merged" ))

files=dir(patt='json')

fixed.LMs = 1:41
semi.LMs = 42:921
samples = gsub(".mrk.json", '', fixed=T, files)

LMs = array(dim=c(921, 3, 4))

for (i in 1:4) LMs[,,i] = read.markups.json(files[i])
dimnames(LMs) = list(paste0("LM_",1:921), c("x", "y", "z"), samples)

gpa = gpagen(A=LMs, surfaces = semi.LMs, ProcD = TRUE)
pca = gm.prcomp(gpa$coords)
geomorph2slicermorph2(gpa=gpa, pca=pca, paste0(output.path, "sliding'))

```

then go to the **Load Previous Analysis** section of the SlicerMorph's GPA module, click the `...` button next to the **Results Directory** section and navigate to the **Sliding** subfolder. Hit the `Load GPA + PCA Analysis from file` button to load the results into SlicerMorph. Note that due to the number of landmarks, interactive visualization will be slow.

