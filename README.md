# SlicerMorphR
R convenience functions for importing SlicerMorph dataset

install via devtools

`devtools::install_github('SlicerMorph/SlicerMorphR')`


## Usage

```
> library(SlicerMorphR)
# point out to the analysis.log file created by the SlicerMorph's GPA function. 
> SM.output=parser(file.choose())
Warning message:
In readLines(file) :
  incomplete final line found on 'C:\Users\murat\Desktop\2021-08-09_14_17_38\analysis.log'
> SM.output
$input.path
[1] "C:/Users/murat/Box Sync/PI_Maga/grant_proposals/Nsf_Informatics/Publications/Semi_LM_paper/landmark sets/Gorilla/sphere"

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
...
```
