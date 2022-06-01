#' Import a FCSV file into R
#'
#' This function imports an FCSV as written by 3D Slicer file into R.
#'
#' In the older version of 3D Slicer,
#' markup coordinates were written in RAS (Right-Anterior-Superior) coordinate system assumption.
#' More recently, it has been saved as LPS (Left-Posterior-Superior).\cr
#'
#' If forceLPS set to FALSE (default), the contents of the file will be read as as, ignoring the header information, where the coordinate system is stored.\cr
#'
#' If forceLPS is set to TRUE, the function will check for the coordinate system definition in the FCSV header,
#' and will negate the x,y coordinate values if the coordinate system is defined as RAS. File will be read as is, if the coordinate system definition is LPS.
#' @param  file The file path that leads to a particular FCSV file.
#' @param  forceLPS The forceLPS determines if the coordinate system should be converted into LPS. The default is FALSE. If set to be TRUE, the function will read the "coordinateSystem" value at the second line of fcsv. If not "LPS", it will reverse the signs of x and y coordinates to force the coordinate system into LPS.
#' @returns An array/matrix that contains the landmark coordinates. \cr
#' Row numbers = number of landmarks;  \cr
#' Column numbers = dimensions of the landmark coordinates  \cr
#' Row names are assigned from the labels in the FCSV file  \cr
#' Column names are assigned as "x", "y", and "z", depending on the dimension  \cr
#' @examples
#' #forceLPS = FALSE
#' file = "https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"
#' lms = read.markups.fcsv(file = file, forceLPS = FALSE) #default setting for forceLPS
#' #Return a 41x3 matrix that stores raw landmark coordinates from the fcsv files; rownames = labels in the FCSV file; colnames = "x", "y", "z"
#' lms[1:3, ]
#'                              X       Y         Z
#' Gorilla_template_LM1-1 111.987 312.757 -148.0780
#' Gorilla_template_LM1-2 114.785 381.650 -128.2390
#' Gorilla_template_LM1-3 109.137 294.534  -97.4347
#'
#' #forceLPS = TRUE
#' file = "https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"
#' lms = read.markups.fcsv(file = file, forceLPS = TRUE)
#' #Because forceLPS = TRUE, the function will read the "coordinateSystem" in the 2nd line of the fcsv to see if it is "LPS"
#' x <- readLines(file, n = 2)
#' x[[2]]
#' [1] "# CoordinateSystem = 0"
#' #The coordinateSystem is not "LPS", so the signs of x, y coordinates are reversed to be consistent with the LPS coordinate system.
#' lms[1:3, ]
#'                            [,1]     [,2]      [,3]
#' Gorilla_template_LM1-1 -111.987 -312.757 -148.0780
#' Gorilla_template_LM1-2 -114.785 -381.650 -128.2390
#' Gorilla_template_LM1-3 -109.137 -294.534  -97.4347
#'
#' @export

read.markups.fcsv = function (file=NULL, forceLPS = FALSE) {
  temp <- read.csv(file, skip = 3, header = F)
  LM <- array (data=as.matrix( temp[,2:4]),
              dim =c(nrow(temp), 3),
              dimnames=list(temp[, 12], c("X", "Y", "Z")))

  M_flip <- rbind(c(-1, 0, 0), c(0, -1, 0), c(0, 0, 1))

  if (forceLPS == TRUE){
    #if the coordinate system = "0", flip the sign of the x and y coordinates to make it consistent with LPS coordinate system
    #if the coordinate system = "LPS", do nothing
    x <- readLines(file, n = 2)
    y <- strsplit(x, split = " ", fixed = T)[[2]][4] #return coordinate system type, either "0" or "LPS"
    if ( (y == "LPS") | (y == "1")) {
      LM <- LM
    }
    else {
      LM <- LM%*%M_flip
    }
  }

  return(LM)
}
