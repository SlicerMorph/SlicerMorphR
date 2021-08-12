#' Import a FCSV file into R
#'
#' This function imports an FCSV file into R. It utilizes the 'read.csv' function to read
#' a fcsv file,
#' If the coordinate system = 0 (i.e., not LPS), the sign of the x and y coordinates will be flipped to be consistent with LPS coordinate system.
#' @param  File The file path that leads to a particular FCSV file.
#' @returns An array/matrix that contains the landmark coordinates. \cr
#' Row numbers = number of landmarks;  \cr
#' Column numbers = dimensions of the landmark coordinates  \cr
#' Row names are assigned from the labels in the FCSV file  \cr
#' Column names are assigned as "x", "y", and "z", depending on the dimension  \cr
#' @examples
#' lms = read.markups.fcsv(file = url("https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"))
#' #Return a 41x3 matrix; rownames = labels in the FCSV file; colnames = "x", "y", "z"
#' #The x, and y coordinates in the original fcsv will be flipped to match the LPS coordiante system
#' @export

read.markups.fcsv = function (file=NULL) {
  #
  temp = read.csv(file=file, skip = 2, header = T)
  LM = array (data=as.matrix( temp[,2:4]),
              dim =c(nrow(temp), 3),
              dimnames=list(temp$label, c("X", "Y", "Z")))

  x <- readLines(file, n = 2)
  y <- strsplit(x,"=", split = " ", fixed = T)[[2]][2] #return coordinate system type, either "0" or "LPS"
  M_flip <- rbind(c(-1, 0, 0), c(0, -1, 0), c(0, 0, 1))

  if (y == "0"){
    #if the coordinate system = "0", flip the sign of the x and y coordinates to make it consistent with LPS coordinate system
    #if the coordinate sysem = "LPS", do nothing
    LM <- LM%*%M_flip
  }

  return(LM)
}
