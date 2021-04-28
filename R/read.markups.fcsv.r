#' Import a FCSV file into R
#'
#' This function imports an FCSV file into R. It utilizes the 'read.csv' function to read
#' a fcsv file,
#' @param  File the file path that leads to a particular FCSV file.
#' @returns An array/matrix that contains the landmark coordinates. \cr
#' Row numbers = number of landmarks;  \cr
#' Column numbers = dimensions of the landmark coordinates  \cr
#' Row names are assigned from the labels in the FCSV file  \cr
#' Column names are assigned as "x", "y", and "z", depending on the dimensionality  \cr
#' @examples
#' lms = read.markups.fcsv(file = url("https://raw.githubusercontent.com/SlicerMorph/SampleData/master/Gorilla_template_LM1.fcsv"))
#' #Return a 41x3 matrix; rownames = labels in the FCSV file; colnames = "x", "y", "z"
#' @export
read.markups.fcsv = function (file=NULL) {
  temp = read.csv(file=file, skip = 2, header = T)
  LM = array (data=as.matrix( temp[,2:4]),
              dim =c(nrow(temp), 3),
              dimnames=list(temp$label, c("X", "Y", "Z")))
  return(LM)
}
