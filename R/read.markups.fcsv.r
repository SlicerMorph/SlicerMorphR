#' Import a FCSV file into R
#'
#' This function imports an FCSV file into R. It utilizes the 'read.csv' function to read
#' a fcsv file,
#' If the coordinate system = 0 (i.e., not LPS), the sign of the x and y coordinates will be flipped to be consistent with LPS coordinate system.
#' @param  file The file path that leads to a particular FCSV file.
#' @param  forceLPS The forceLPS determines if the coordinate system should be converted into LPS. The default is FALSE. If set to be TRUE, the function will read the "coordinateSystem" value at the second line of fcsv. If not "LPS", it will reverse the signs of x and y coordinates to force the coordinate system into LPS.
#' @returns An array/matrix that contains the landmark coordinates. \cr
#' Row numbers = number of landmarks;  \cr
#' Column numbers = dimensions of the landmark coordinates  \cr
#' Row names are assigned from the labels in the FCSV file  \cr
#' Column names are assigned as "x", "y", and "z", depending on the dimension  \cr
#' @examples
#' file = url("https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv")
#' lms = read.markups.fcsv(file = file, forceLPS = FALSE) #default setting for forceLPS
#' #Return a 41x3 matrix that stores raw landmark coordinates from the fcsv files; rownames = labels in the FCSV file; colnames = "x", "y", "z"
#' lms[1:3, ]
#'                              X       Y         Z
#' Gorilla_template_LM1-1 111.987 312.757 -148.0780
#' Gorilla_template_LM1-2 114.785 381.650 -128.2390
#' Gorilla_template_LM1-3 109.137 294.534  -97.4347
#'
#' lms = read.markups.fcsv(file = file, forceLPS = TRUE)
#' #Because forceLPS = TRUE, the function will read the "coordinateSystem" in the 2nd line of the fcsv to see if it is "LPS"
#' x <- readLines(file, n = 2)
#' x[2]
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
  temp = read.csv(file=file, skip = 2, header = T)
  LM = array (data=as.matrix( temp[,2:4]),
              dim =c(nrow(temp), 3),
              dimnames=list(temp$label, c("X", "Y", "Z")))

  M_flip <- rbind(c(-1, 0, 0), c(0, -1, 0), c(0, 0, 1))

  if (forceLPS == TRUE){
    x <- readLines(file, n = 2)
    y <- strsplit(x, split = " ", fixed = T)[[2]][4] #return coordinate system type, either "0" or "LPS"
    #if the coordinate system = "0", flip the sign of the x and y coordinates to make it consistent with LPS coordinate system
    #if the coordinate system = "LPS", do nothing
    if (y != "LPS")
    LM <- LM%*%M_flip
  }

  return(LM)
}
