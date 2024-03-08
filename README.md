# SlicerMorphR
R convenience functions for importing SlicerMorph dataset

install via devtools

`devtools::install_github('SlicerMorph/SlicerMorphR')`


## Usage

* __read.markups.fcsv__ : Reads the 3D Slicer Markups file saved in fcsv format
* __read.markups.json__:  Reads the 3D Slicer Markups file saved in json format (the default format)
* __write.markups.fcsv__: Writes a matrix of 3D LM coordinates in 3D Slicer's Markups format as fcsv. By default LM coordinates are written with LPS (Left-Posterior-SUperior) coordinate system header, which is default in Slicer.
* __parser__ : Reads and parses the analysis.log file as output by the SlicerMorph's GPA module.
* __geomorph2slicermorph__ : Allow to save a geomorph GPA and PCA analysis in SlicerMorph's GPA output format, so that you can load the results into Slicer to visualize in 3D. 

```
> library(SlicerMorphR)
# point out to the analysis.log file created by the SlicerMorph's GPA function. 
> SM.output=parser(file.choose(), forceLPS = TRUE)
#For details of the forceLPS parameter, please see the example of read.markup.fcsv() below and its associated help file
Warning message:
In readLines(file) :
  incomplete final line found on 'C:\Users\murat\Desktop\2021-08-09_14_17_38\analysis.log'
> SM.output
$input.path
[1] "C:/Semi_LM_paper/landmark sets/Gorilla/sphere"

$output.path
[1] "C:/Users/murat/Desktop/2021-08-09_14_17_38"

$files
 [1] "USNM174715-Cranium.vtk_SL_warped.fcsv"         
 [2] "USNM174722-Cranium.vtk_SL_warped.fcsv"         
 [3] "USNM176209-Cranium.vtk_SL_warped.fcsv"         
 [4] "USNM176211-Cranium.vtk_SL_warped.fcsv"         
 [5] "USNM176216-Cranium.vtk_SL_warped.fcsv"         
 [6] "USNM176217-Cranium.vtk_SL_warped.fcsv"         
 [7] "USNM220060-Cranium.vtk_SL_warped.fcsv"         
 [8] "USNM220324-Cranium.vtk_SL_warped.fcsv"         
 [9] "USNM252575-Cranium.vtk_SL_warped.fcsv"         
[10] "USNM252577-Cranium.vtk_SL_warped.fcsv"         
[11] "USNM252578-Cranium.vtk_SL_warped.fcsv"         
[12] "USNM252580-Cranium.vtk_SL_warped.fcsv"         
[13] "USNM297857-Cranium.vtk_SL_warped.fcsv"         
[14] "USNM582726-Cranium.vtk_SL_warped.fcsv"         
[15] "USNM590942_CRANIUM.vtk_SL_warped.fcsv"         
[16] "USNM590947_CRANIUM.vtk_SL_warped.fcsv"         
[17] "USNM590951_CRANIUM.vtk_SL_warped.fcsv"         
[18] "USNM590953_CRANIUM.vtk_SL_warped.fcsv"         
[19] "USNM590954_CRANIUM.vtk_SL_warped.fcsv"         
[20] "USNM599165_CRANIUM_MANDIBLE.vtk_SL_warped.fcsv"
[21] "USNM599166_CRANIUM.vtk_SL_warped.fcsv"         
[22] "USNM599167_CRANIUM.vtk_SL_warped.fcsv"         

$format
[1] ".fcsv"

$no.LM
[1] 2304

$skipped
[1] FALSE

$semi
[1] TRUE

$semiLMs
[1] " "

$scale
[1] TRUE

$MeanShape
[1] "MeanShape.csv"

$eigenvalues
[1] "eigenvalues.csv"

$eigenvectors
[1] "eigenvectors.csv"

$OutputData
[1] "OutputData.csv"

$pcScores
[1] "pcScores.csv"

$ID
 [1] "USNM174715-Cranium.vtk_SL_warped"          "USNM174722-Cranium.vtk_SL_warped"         
 [3] "USNM176209-Cranium.vtk_SL_warped"          "USNM176211-Cranium.vtk_SL_warped"         
 [5] "USNM176216-Cranium.vtk_SL_warped"          "USNM176217-Cranium.vtk_SL_warped"         
 [7] "USNM220060-Cranium.vtk_SL_warped"          "USNM220324-Cranium.vtk_SL_warped"         
 [9] "USNM252575-Cranium.vtk_SL_warped"          "USNM252577-Cranium.vtk_SL_warped"         
[11] "USNM252578-Cranium.vtk_SL_warped"          "USNM252580-Cranium.vtk_SL_warped"         
[13] "USNM297857-Cranium.vtk_SL_warped"          "USNM582726-Cranium.vtk_SL_warped"         
[15] "USNM590942_CRANIUM.vtk_SL_warped"          "USNM590947_CRANIUM.vtk_SL_warped"         
[17] "USNM590951_CRANIUM.vtk_SL_warped"          "USNM590953_CRANIUM.vtk_SL_warped"         
[19] "USNM590954_CRANIUM.vtk_SL_warped"          "USNM599165_CRANIUM_MANDIBLE.vtk_SL_warped"
[21] "USNM599166_CRANIUM.vtk_SL_warped"          "USNM599167_CRANIUM.vtk_SL_warped"         

$LM
, , USNM174715-Cranium.vtk_SL_warped

             x        y          z
1    113.57322 289.4062  -47.68592
2    108.90213 289.2997  -48.16833
3    111.90668 292.8073  -46.45086
4    107.57013 293.4006  -46.32930
5    104.77066 290.7697  -47.70352
6    105.19183 287.0535  -48.59508
7    108.95377 285.2464  -48.92385
8     93.12697 315.0776 -146.69631
9     91.10847 326.3815 -130.82622
10    78.21323 327.9392 -126.33089
11    73.24375 307.2772 -116.18021
12   104.85556 301.4360 -103.32111
13   118.44697 289.5207  -46.93095
14   123.72807 289.7841  -46.25342
15   129.60968 290.5058  -46.02137


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

#setwd(paste0(output.path, "Gorilla patch semi-landmarks/merged" ))
setwd("/Users/amaga/Desktop/SlicerMorph_sample/Gorilla patch semi-landmarks/merged")

files=dir(patt='json')

fixed.LMs = 1:41
semi.LMs = 42:921
samples = gsub(".mrk.json", '', fixed=T, files)

LMs = array(dim=c(921, 3, 4))

for (i in 1:4) LMs[,,i] = read.markups.json(files[i])
dimnames(LMs) = list(paste0("LM_",1:921), c("x", "y", "z"), samples)

gpa = gpagen(A=LMs, surfaces = semi.LMs, ProcD = TRUE)
pca = gm.prcomp(gpa$coords)
geomorph2slicermorph(gpa=gpa, pca=pca, paste0(output.path, "sliding'))

```

then go to the **Load Previous Analysis** section of the SlicerMorph's GPA module, click the `...` button next to the **Results Directory** section and navigate to the **Sliding** subfolder. Hit the `Load GPA + PCA Analysis from file` button to load the results into SlicerMorph. Note that due to the number of landmarks, interactive visualization will be slow.

