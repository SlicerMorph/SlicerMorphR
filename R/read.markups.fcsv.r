#' Import a FCSV file into R
#'
#' This function imports an FCSV file into R. It utilizes the 'read.csv' function to read
#' a fcsv file,
#' @param  file the file path that leads to a particular FCSV file.
#' @return an array that contains the landmark coordinates. The dimensions are specified by dimnames x, y, and z.
#' @export
read.markups.fcsv = function (file=NULL) {
  temp = read.csv(file=file, skip = 2, header = T)
  LM = array (data=as.matrix( temp[,2:4]),
              dim =c(nrow(temp), 3),
              dimnames=list(temp$label, c("X", "Y", "Z")))
  return(LM)
}
